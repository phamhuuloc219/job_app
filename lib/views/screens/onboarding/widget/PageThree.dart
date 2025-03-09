import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:job_app/constants/app_constants.dart';
import 'package:job_app/views/common/custom_outline_btn.dart';
import 'package:job_app/views/common/exports.dart';
import 'package:job_app/views/screens/mainscreen.dart';

class PageThree extends StatelessWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: Color(kLightBlue.value),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("assets/images/page3.png"),
            ),
            SizedBox(height: 20,),
            Column(
              children: [
                Text(
                  "Welcome to NTU Job",
                  textAlign: TextAlign.center,
                  style: appStyle(30, Color(kLight.value), FontWeight.w600),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: EdgeInsets.all(8.0.h),
                  child: Text(
                    "We help find your dream job according to your skills and experience. We help find your dream job according to your skills and experience.",
                    textAlign: TextAlign.center,
                    style: appStyle(14, Color(kLight.value), FontWeight.normal),
                  ),
                ),
                SizedBox(height: 10,),
                CustomOutlineBtn(
                    onTap: () {
                      Get.to(()=>Mainscreen());
                    },
                    hieght: height * 0.05,
                    width: width * 0.9,
                    text: "Continue as guest",
                    color: Color(kLight.value)
                ),
              ],
            )
          ],
        ),
       ),
    );
  }
}
