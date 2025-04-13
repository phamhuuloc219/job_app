import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:job_app/controllers/login_provider.dart';
import 'package:job_app/controllers/zoom_provider.dart';
import 'package:job_app/models/response/auth/profile_model.dart';
import 'package:job_app/services/helpers/auth_helper.dart';
import 'package:job_app/views/common/BackBtn.dart';
import 'package:job_app/views/common/app_bar.dart';
import 'package:job_app/views/common/custom_outline_btn.dart';
import 'package:job_app/views/common/drawer/drawer_widget.dart';
import 'package:job_app/views/common/exports.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_app/views/common/height_spacer.dart';
import 'package:job_app/views/common/pages_loader.dart';
import 'package:job_app/views/common/styled_container.dart';
import 'package:job_app/views/common/width_spacer.dart';
import 'package:job_app/views/screens/auth/login_screen.dart';
import 'package:job_app/views/screens/auth/non_user.dart';
import 'package:job_app/views/screens/auth/widgets/circular_avatar.dart';
import 'package:job_app/views/screens/auth/widgets/edit_button.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.drawer});

  final bool drawer;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<ProfileRes> userProfile;
  String username = '';

  @override
  void initState() {
    super.initState();
    getProfile();
    getName();
  }

  getProfile() async{
    var loginNotifier = Provider.of<LoginNotifier>(context, listen: false);
    if(widget.drawer == false && loginNotifier.loggedIn == true){
      userProfile = AuthHelper.getProfile();
    } else if(widget.drawer == true && loginNotifier.loggedIn == true){
      userProfile = AuthHelper.getProfile();
    } else{}
  }

  getName() async {
    var loginNotifier = Provider.of<LoginNotifier>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if(widget.drawer == false && loginNotifier.loggedIn == true){
      username = prefs.getString('username') ?? "";
      userProfile = AuthHelper.getProfile();
    } else if(widget.drawer == true && loginNotifier.loggedIn == true){
      username = prefs.getString('username') ?? "";
      userProfile = AuthHelper.getProfile();
    } else{}
  }

  @override
  Widget build(BuildContext context) {
    var zoomNotifier = Provider.of<ZoomNotifier>(context);
    var loginNotifier = Provider.of<LoginNotifier>(context);
    return Scaffold(
      appBar:PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
            text: loginNotifier.loggedIn ? username.toUpperCase() : '',
            child: Padding(
              padding: EdgeInsets.all(12.0.h),
              child: widget.drawer == false ? BackBtn() : DrawerWidget(color: Color(kDark.value)),
            )
        ),
      ),
      body: loginNotifier.loggedIn == false
          ? const NonUser()
          : FutureBuilder(
          future: userProfile,
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return const PageLoader();
            } else if(snapshot.hasError){
              return Text("Error: ${snapshot.error}");
            } else{
              var profile = snapshot.data;
              return buildStyleContainer(
                context,
                ListView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      width: width,
                      height: height * 0.07,
                      decoration: BoxDecoration(
                        color: Color(0xFFEFFFFC),
                        borderRadius: BorderRadius.all(Radius.circular(12.w)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircularAvatar(
                                image: profile!.profile,
                                w: 50,
                                h: 50,
                              ),
                              const WidthSpacer(width: 5),

                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    profile.username,
                                    softWrap: true,
                                    maxLines: null,
                                    overflow: TextOverflow.visible,
                                    style: TextStyle(fontSize: 12, color: Color(kDarkGrey.value), fontWeight:  FontWeight.w400),
                                  ),
                                  Text(
                                    profile.email,
                                    softWrap: true,
                                    maxLines: null,
                                    overflow: TextOverflow.visible,
                                    style: TextStyle(fontSize: 12, color: Color(kDarkGrey.value), fontWeight:  FontWeight.w400),
                                  ),
                                ],
                              ),
                              const WidthSpacer(width: 10),

                              GestureDetector(
                                  onTap: () {},
                                  child: const Icon(Feather.edit),
                              ),

                            ],
                          ),
                        ],
                      ),
                    ),
                    const HeightSpacer(size: 20),

                    Stack(
                      children: [
                        Container(
                          width: width,
                          height: height * 0.12,
                          color: Color(kLightGrey.value),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 12.w),
                                width: 60.w,
                                height: 70.h,
                                color: Color(kLight.value),
                                child: Icon(
                                  FontAwesome5Regular.file_pdf,
                                  color: Colors.red,
                                  size: 40,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ReusableText(
                                    text: 'Upload Your Resume',
                                    style: appStyle(
                                        16,
                                        Color(kDark.value),
                                        FontWeight.w500
                                    ),
                                  ),
                                  ReusableText(
                                    text: 'Please make sure to upload your resume in PDF format',
                                    style: appStyle(
                                        8,
                                        Color(kDarkGrey.value),
                                        FontWeight.w500
                                    ),
                                  ),
                                ],
                              ),
                              const WidthSpacer(width: 1)
                            ],
                          ),
                        ),
                        Positioned(
                            right: 0.w,
                            child: EditButton(
                                onTap: () {}
                              ),
                        )
                      ],
                    ),
                    const HeightSpacer(size: 20),

                    !profile.isCompany
                    ? Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            ReusableText(
                                text: 'Company Section',
                                style: appStyle(14, Color(kDark.value), FontWeight.w600)
                            ),
                            HeightSpacer(size: 20),

                            CustomOutlineBtn(
                              height: 40.h,
                              width: width,
                              text: "Add Jobs",
                              color: Color(kOrange.value),
                              onTap: () {},
                            ),
                            HeightSpacer(size: 20),

                            CustomOutlineBtn(
                              height: 40.h,
                              width: width,
                              text: "Update Information",
                              color: Color(kOrange.value),
                              onTap: () {},
                            ),
                          ],
                        )
                    : CustomOutlineBtn(
                      height: 40.h,
                      width: width,
                      text: "Apply to become an company",
                      color: Color(kOrange.value),
                      onTap: () {},
                    ),
                    HeightSpacer(size: 20),

                    CustomOutlineBtn(
                      height: 40.h,
                      width: width,
                      text: "Proceed to Logout",
                      color: Color(kOrange.value),
                      onTap: () {
                        zoomNotifier.currentIndex = 0;
                        loginNotifier.logout();
                        Get.offAll(()=> LoginScreen());
                      },
                    ),
                  ],
                ),
              );
            }
          },
      ),
    );
  }
}
