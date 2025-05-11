import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:job_app/views/common/exports.dart';
import 'package:job_app/constants/app_constants.dart';

class BackBtn extends StatelessWidget {
  const BackBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Get.back();
        },
        child: const Icon(AntDesign.leftcircleo),
      );
  }
}
