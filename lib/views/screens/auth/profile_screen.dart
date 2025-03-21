import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_app/views/common/BackBtn.dart';
import 'package:job_app/views/common/app_bar.dart';
import 'package:job_app/views/common/drawer/drawer_widget.dart';
import 'package:job_app/views/common/exports.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key, required this.drawer});

  final bool drawer;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
            actions: [
              Padding(
                padding: EdgeInsets.all(12.0.h),
                child: GestureDetector(
                  onTap: () {
                    Get.to(()=> ProfileScreen(drawer: false));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    child: CachedNetworkImage(
                      height: 30.w,
                      width: 30.w,
                      imageUrl: 'https://raw.githubusercontent.com/phamhuuloc219/job_app/refs/heads/main/assets/images/user.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            ],
            child: Padding(
              padding: EdgeInsets.all(12.0.h),
              child: widget.drawer == false ? BackBtn() : DrawerWidget(color: Color(kDark.value)),
            )
        ),
      ),
      body: Center(
        child: 
        ReusableText(
            text: 'Profile Pgae', 
            style: appStyle(30, Color(kDark.value), FontWeight.bold)
        ),
      ),
    );
  }
}
