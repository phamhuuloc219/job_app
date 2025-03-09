import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_app/constants/app_constants.dart';
import 'package:job_app/views/common/app_style.dart';
import 'package:job_app/views/common/reusable_text.dart';

class PageTwo extends StatelessWidget {
  const PageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: Color(kDarkBlue.value),
        child: Column(
          children: [
            SizedBox(height: 65,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("assets/images/page2.png"),
            ),
            SizedBox(height: 20,),
            Column(
              children: [
                Text(
                  "Stable yourself\n With your abilities",
                  textAlign: TextAlign.center,
                  style: appStyle(30, Color(kLight.value), FontWeight.w500),
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text(
                    "We help find your dream job according to your skills and experience. We help find your dream job according to your skills and experience.",
                    textAlign: TextAlign.center,
                    style: appStyle(14, Color(kLight.value), FontWeight.normal),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}