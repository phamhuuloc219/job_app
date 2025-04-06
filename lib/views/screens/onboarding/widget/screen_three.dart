import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:job_app/constants/app_constants.dart';
import 'package:job_app/views/common/exports.dart';
import 'package:job_app/views/screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageThree extends StatelessWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: Color(kLightBlue.value),
        child: Stack(
          children: [
            Image.asset(
              "assets/images/3.jpg",
              fit: BoxFit.cover,
              width: width,
              height: height,
            ),
            // Column(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     Padding(
            //       padding: EdgeInsets.symmetric(horizontal: 100.w, vertical: 300.h),
            //       child: Column(
            //         children: [
            //           CustomOutlineBtn(
            //             onTap: () {
            //               Get.to(() => Mainscreen());
            //             },
            //             height: height * 0.08,
            //             width: width * 0.5,
            //             text: "JOIN NOW !",
            //             color: Color(kLight.value),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ],
            // ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  // padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 300.h),
                  padding: EdgeInsets.only(
                    left: 40.w,
                    right: 20.w,
                    bottom: 300.h,
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () async{
                          final SharedPreferences prefs = await SharedPreferences.getInstance();

                          prefs.setBool('entrypoint', true);
                          Get.to(() => Mainscreen());
                        },
                        child: Container(
                          width: width * 0.8,
                          height: height * 0.08,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(12)),
                            color: Color(kOrange.value).withOpacity(0.3),
                            border: Border.all(
                              width: 2,
                              color: Color(kLight.value),
                            ),
                          ),
                          child: Center(
                            child: ReusableText(
                              text: "JOIN NOW!",
                              style: appStyle(20, Color(kLight.value), FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}