import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:job_app/constants/app_constants.dart';
import 'package:job_app/models/response/jobs/jobs_response.dart';
import 'package:job_app/views/common/exports.dart';
import 'package:job_app/views/screens/job/job_details_screen.dart';

class JobVerticalTitle extends StatelessWidget {
  const JobVerticalTitle({super.key, required this.job});

  final JobsResponse job;

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
              color: Color(kLightGrey.value),
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
                                    12,
                                    Color(kDark.value),
                                    FontWeight.w500
                                ),
                            ),
                            SizedBox(
                              width: width * 0.5,
                              child: ReusableText(
                                text: job.title,
                                style: appStyle(
                                    12,
                                    Color(kDarkGrey.value),
                                    FontWeight.w500
                                ),
                              ),
                            ),
                            ReusableText(
                              text: "${job.salary} per ${job.period}",
                              style: appStyle(
                                  12,
                                  Color(kDarkGrey.value),
                                  FontWeight.w500
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: Color(kLight.value),
                      child: Center(child: Icon(Ionicons.chevron_forward)),
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
