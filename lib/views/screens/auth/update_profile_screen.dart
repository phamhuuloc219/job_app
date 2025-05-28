import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:job_app/constants/app_constants.dart';
import 'package:job_app/controllers/profile_provider.dart';
import 'package:job_app/views/common/app_bar.dart';
import 'package:job_app/views/common/custom_btn.dart';
import 'package:job_app/views/common/custom_textfield.dart';
import 'package:job_app/views/common/drawer/drawer_widget.dart';
import 'package:job_app/views/common/height_spacer.dart';
import 'package:job_app/views/common/pages_loader.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key, required this.drawer});

  final bool drawer;

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController username = TextEditingController();
  final TextEditingController location = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final String imageUrl =
      'https://raw.githubusercontent.com/phamhuuloc219/job_app/main/assets/images/user.png';

  bool _initialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileNotifier>().loadProfile();
    });
  }

  @override
  void dispose() {
    username.dispose();
    location.dispose();
    phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileNotifier>(
      builder: (context, notifier, child) {
        final profile = notifier.profile;

        if (profile != null && !_initialized) {
          username.text = profile.username;
          location.text = profile.location;
          phone.text = profile.phone;
          _initialized = true;
        }

        return Scaffold(
          backgroundColor: Color(kNewBlue.value),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(60.h),
            child: CustomAppBar(
              color: Color(kNewBlue.value),
              text: 'Update Profile',
              child: Padding(
                padding: EdgeInsets.all(12.0.h),
                child: widget.drawer == false
                    ? GestureDetector(
                        onTap: () => Get.back(),
                        child: const Icon(
                          AntDesign.leftcircleo,
                          color: Colors.white,
                          size: 30,
                        ),
                      )
                    : DrawerWidget(color: Color(kLight.value)),
              ),
            ),
          ),
          body: notifier.isLoading
              ? const PageLoader()
              : Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(kLight.value),
                    borderRadius: BorderRadius.circular(12.w),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Form(
                      key: _formKey,
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          const HeightSpacer(size: 40),
                          Center(
                            child: CircleAvatar(
                              radius: 75,
                              backgroundImage: NetworkImage(
                                profile?.profile ?? imageUrl,
                              ),
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                          const HeightSpacer(size: 20),
                          Text("Full Name"),
                          CustomTextField(
                            controller: username,
                            hintText: 'Enter your full name',
                            keyboardType: TextInputType.text,
                            validator: (username) {
                              if (username == null || username.isEmpty) {
                                return 'Please enter full name';
                              }
                              return null;
                            },
                          ),
                          const HeightSpacer(size: 20),
                          Text("Location"),
                          CustomTextField(
                            controller: location,
                            hintText: 'Enter your location',
                            keyboardType: TextInputType.text,
                          ),
                          const HeightSpacer(size: 20),
                          Text("Phone number"),
                          CustomTextField(
                            controller: phone,
                            hintText: 'Enter your phone',
                            keyboardType: TextInputType.phone,
                            validator: (phone) {
                              if (phone != null && phone.isNotEmpty) {
                                if (phone.length < 7 || phone.length > 20) {
                                  return 'Phone number must be between 7 and 20 digits';
                                }
                              }
                              return null;
                            },
                          ),
                          const HeightSpacer(size: 50),
                          CustomButton(
                            text: 'Update',
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                await notifier.updateProfile(
                                  username: username.text.trim(),
                                  location: location.text.trim(),
                                  phone: phone.text.trim(),
                                );

                                final message = notifier.error != null
                                    ? 'Failed to update profile'
                                    : 'Profile updated successfully';

                                final prefs =
                                    await SharedPreferences.getInstance();
                                await prefs.setBool('profile_updated', true);
                                await notifier.loadProfile();

                                if (notifier.profile != null) {
                                  username.text = notifier.profile!.username;
                                  location.text = notifier.profile!.location;
                                  phone.text = notifier.profile!.phone;
                                }

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(message),
                                    backgroundColor: Color(kDark.value),
                                    behavior: SnackBarBehavior.floating,
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
