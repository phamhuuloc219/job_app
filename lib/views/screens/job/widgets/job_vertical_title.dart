import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_app/constants/app_constants.dart';
import 'package:job_app/models/response/jobs/jobs_response.dart';

class JobVerticalTitle extends StatelessWidget {
  const JobVerticalTitle({super.key, required this.job});

  final JobsResponse job;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: GestureDetector(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Container(
            height: height * 0.1,
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
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
