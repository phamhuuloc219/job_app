import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_app/constants/app_constants.dart';
import 'package:job_app/models/response/jobs/jobs_response.dart';

class JobsHorizotalTitle extends StatelessWidget {
  JobsHorizotalTitle({super.key, this.onTap, required this.job});

  final void Function()? onTap;
  final JobsResponse job;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
          padding: EdgeInsets.only(right: 12.w),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(12.w)),
          child: Container(
            height: height * 0.27,
            width:  width * 0.7,
            decoration: BoxDecoration(
              color: Color(kLightGrey.value)
            ),
          ),
        ),
      ),
    );
  }
}
