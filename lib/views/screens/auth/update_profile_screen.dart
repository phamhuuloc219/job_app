import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:job_app/constants/app_constants.dart';
import 'package:job_app/controllers/profile_provider.dart';
import 'package:job_app/views/common/app_bar.dart';
import 'package:job_app/views/common/custom_btn.dart';
import 'package:job_app/views/common/custom_textfield.dart';
import 'package:job_app/views/common/height_spacer.dart';
import 'package:job_app/views/common/pages_loader.dart';
import 'package:job_app/views/common/styled_container.dart';
import 'package:provider/provider.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({super.key});

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  final TextEditingController username = TextEditingController();
  final TextEditingController location = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Chỉ load profile, không gán controller ở đây
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

        if (profile != null) {
          if (username.text.isEmpty) username.text = profile.username;
          if (location.text.isEmpty) location.text = profile.location;
          if (phone.text.isEmpty) phone.text = profile.phone;
        }

        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: CustomAppBar(
              text: 'Update Profile',
              child: GestureDetector(
                onTap: () => Get.back(),
                child: const Icon(AntDesign.leftcircleo),
              ),
            ),
          ),
          body: notifier.isLoading
              ? const PageLoader()
              : buildStyleContainer(
            context,
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    const HeightSpacer(size: 50),
                    CustomTextField(
                      controller: username,
                      hintText: 'Enter your username',
                      keyboardType: TextInputType.text,
                      // validator: (val) {
                      //   if (val == null || val.isEmpty) {
                      //     return 'Please enter a username';
                      //   }
                      //   return null;
                      // },
                    ),
                    const HeightSpacer(size: 20),
                    CustomTextField(
                      controller: location,
                      hintText: 'Enter your location',
                      keyboardType: TextInputType.text,
                      // validator: (val) {
                      //   if (val == null || val.isEmpty) {
                      //     return 'Please enter a location';
                      //   }
                      //   return null;
                      // },
                    ),
                    const HeightSpacer(size: 20),
                    CustomTextField(
                      controller: phone,
                      hintText: 'Enter your phone',
                      keyboardType: TextInputType.phone,
                      // validator: (val) {
                      //   if (val == null || val.isEmpty) {
                      //     return 'Please enter a phone number';
                      //   }
                      //   return null;
                      // },
                    ),
                    const HeightSpacer(size: 50),
                    CustomButton(
                      text: 'Update',
                      onTap: () async {
                        if (!_formKey.currentState!.validate()) return;

                        await notifier.updateProfile(
                          username: username.text.trim(),
                          location: location.text.trim(),
                          phone: phone.text.trim(),
                        );

                        if (notifier.error != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: const Text('Failed to update profile'),
                                backgroundColor: Color(kDark.value),
                                behavior: SnackBarBehavior.floating,
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: const Text('Profile updated successfully'),
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
