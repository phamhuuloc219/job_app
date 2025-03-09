import 'package:flutter/material.dart';
import 'package:job_app/constants/app_constants.dart';
import 'package:job_app/views/common/exports.dart';

class PageOne extends StatelessWidget {
  const PageOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: Color(kDarkPurple.value),
        child: Column(
          children: [
            SizedBox(height: 70,),
            Image.asset("assets/images/page1.png"),
            SizedBox(height: 40,),
            Column(
              children: [
                ReusableText(
                    text: "Find your dream job",
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
