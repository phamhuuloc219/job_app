import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:job_app/constants/app_constants.dart';
import 'package:job_app/models/response/jobs/jobs_response.dart';
import 'package:job_app/views/common/exports.dart';
import 'package:job_app/views/common/height_spacer.dart';
import 'package:job_app/views/common/width_spacer.dart';

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
            // padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
            decoration: BoxDecoration(
              // image: DecorationImage(
              //     image: AssetImage("assets/images/jobs.png"),
              //     fit: BoxFit.contain,
              //     opacity: 0.5
              // ),
              color: Color(kLightGrey.value),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(job.imageUrl),
                      ),
                      const WidthSpacer(width: 15),
                      Container(
                        width: 160.w,
                        padding: EdgeInsetsDirectional.symmetric(horizontal: 20.w),
                        decoration: BoxDecoration(
                          color: Color(kLight.value),
                          borderRadius: BorderRadius.all(Radius.circular(20.w)),
                        ),
                        child: ReusableText(
                            text: job.companyName,
                            style: appStyle(22, Color(kDark.value), FontWeight.w600)
                        ),
                      )
                    ],
                  ),
                  HeightSpacer(size: 15),
                  ReusableText(
                      text: job.title,
                      style: appStyle(18, Color(kDark.value), FontWeight.w600)
                  ),
                  HeightSpacer(size: 5),
                  ReusableText(
                      text: job.location,
                      style: appStyle(16, Color(kDarkGrey.value), FontWeight.w600)
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          ReusableText(
                              text: job.salary,
                              style: appStyle(20, Color(kDark.value), FontWeight.w600)
                          ),
                          ReusableText(
                              text: "/${job.period}",
                              style: appStyle(18, Color(kDarkGrey.value), FontWeight.w600)
                          ),
                        ],
                      ),
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: Color(kLight.value),
                        child: Icon(Ionicons.chevron_forward),
                      )
                    ],
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
