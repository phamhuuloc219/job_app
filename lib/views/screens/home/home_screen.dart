import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_app/constants/app_constants.dart';
import 'package:job_app/views/common/app_bar.dart';
import 'package:job_app/views/common/app_style.dart';
import 'package:job_app/views/common/drawer/drawer_widget.dart';
import 'package:job_app/views/common/heading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_app/views/common/search.dart';
import 'package:job_app/views/screens/auth/login_screen.dart';
import 'package:job_app/views/screens/auth/profile_screen.dart';
import 'package:job_app/views/screens/job/job_list_screen.dart';
import 'package:job_app/views/screens/job/widgets/popular_jobs.dart';
import 'package:job_app/views/screens/job/widgets/recentlist.dart';
import 'package:job_app/views/screens/search/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                    Get.to(()=> LoginScreen());
                    // Get.to(()=> ProfileScreen(drawer: false));
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
      body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Search \n Find & Apply",
                    style: appStyle(38, Color(kDark.value), FontWeight.bold),),
                  SizedBox(height: 20.h,),
                  SearchWidget(
                    onTap: () {
                      Get.to(()=> const SearchScreen());
                    },
                  ),
                  SizedBox(height: 30.h,),
                  HeadingWidget(
                    text: "Popular Jobs", 
                    onTap: () {
                      Get.to(()=> const JobListScreen());
                    },
                  ),
                  SizedBox(height: 15.h,),
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(12.w)),
                      child: const PopularJobs()
                  ),

                  SizedBox(height: 15.h,),
                  HeadingWidget(
                    text: "Recently Posted",
                    onTap: () {
                      Get.to(()=> const JobListScreen());
                    },
                  ),
                  SizedBox(height: 15.h,),
                  const RecentJobs()
                ],
              ),
            ),
          )
      ),
    );
  }
}
