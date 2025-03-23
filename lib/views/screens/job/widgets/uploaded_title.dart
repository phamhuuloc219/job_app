import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:job_app/constants/app_constants.dart';
import 'package:job_app/models/response/jobs/jobs_response.dart';
import 'package:job_app/views/common/app_style.dart';
import 'package:job_app/views/common/custom_outline_btn.dart';
import 'package:job_app/views/common/reusable_text.dart';
import 'package:job_app/views/screens/job/job_details_screen.dart';

class UploadedTitle extends StatelessWidget {
  const UploadedTitle({super.key, required this.job, required this.text});

  final JobsResponse job;
  final String text;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: GestureDetector(
        onTap: () {
          Get.to(()=> JobDetailsScreen(id: job.id, title: job.title, companyName:  job.companyName));
        },
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
            height: height * 0.11,
            width: width,
            decoration: BoxDecoration(
              color: const Color(0x09000000),
              borderRadius: BorderRadius.all(Radius.circular(9.w)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(job.imageUrl),
                        ),

                        SizedBox(width: 10.w,),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ReusableText(
                              text: job.companyName,
                              style: appStyle(
                                  12.5,
                                  Color(kDark.value),
                                  FontWeight.w500
                              ),
                            ),
                            SizedBox(
                              width: width * 0.5,
                              child: ReusableText(
                                text: job.title,
                                style: appStyle(
                                    12.5,
                                    Color(kDarkGrey.value),
                                    FontWeight.w500
                                ),
                              ),
                            ),
                            ReusableText(
                              text: "${job.salary} per ${job.period}",
                              style: appStyle(
                                  12.5,
                                  Color(kDarkGrey.value),
                                  FontWeight.w500
                              ),
                            ),
                          ],
                        ),

                        text == 'popular'
                            ?CustomOutlineBtn(
                              width: 90.w,
                              height: 36.h,
                              text: "View",
                              color: Color(kLightBlue.value)
                            )
                            :CustomOutlineBtn(
                                width: 90.w,
                                height: 36.h,
                                text: "Apply",
                                color: Color(kLightBlue.value)
                            )
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
