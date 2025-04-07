import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_app/constants/app_constants.dart';
import 'package:job_app/controllers/login_provider.dart';
import 'package:job_app/views/common/app_bar.dart';
import 'package:job_app/views/common/app_style.dart';
import 'package:job_app/views/common/drawer/drawer_widget.dart';
import 'package:job_app/views/common/reusable_text.dart';
import 'package:job_app/views/screens/auth/non_user.dart';
import 'package:job_app/views/screens/auth/profile_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class AppliedJobs extends StatefulWidget {
  const AppliedJobs({super.key});

  @override
  State<AppliedJobs> createState() => _AppliedJobsState();
}

class _AppliedJobsState extends State<AppliedJobs> {
  @override
  Widget build(BuildContext context) {
    var loginNotifier = Provider.of<LoginNotifier>(context);
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
              child: DrawerWidget(color: Color(kDark.value)),
            )
        ),
      ),
      body: loginNotifier.loggedIn == false
          ? const NonUser()
          : Center(
        child: ReusableText(
            text: "Applied Jobs Screen",
            style: appStyle(30, Color(kDark.value), FontWeight.bold)
        ),
      ),
    );
  }
}
