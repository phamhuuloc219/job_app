import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:job_app/views/common/custom_outline_btn.dart';
import 'package:job_app/views/common/exports.dart';
import 'package:job_app/views/common/height_spacer.dart';
import 'package:job_app/views/common/styled_container.dart';
import 'package:job_app/views/screens/auth/login_screen.dart';

class NonUser extends StatelessWidget {
  const NonUser({super.key});

  @override
  Widget build(BuildContext context) {

    String imageUrl = 'https://raw.githubusercontent.com/phamhuuloc219/job_app/refs/heads/main/assets/images/user.png';

    return buildStyleContainer(
      context,
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ReusableText(
              text: "To access content please login",
              style: appStyle(16, Color(kLight.value), FontWeight.normal)
          ),
          HeightSpacer(size: 50),
          Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 10.w
              ),
            child: CustomOutlineBtn(
              height: 40.h,
              width: width,
              text: "Proceed to Login",
              color: Color(kLight.value),
              onTap: () {
                Get.to(()=> LoginScreen());
              },
            ),
          ),
        ],
      ),
    );
  }
}
