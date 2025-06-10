import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_app/constants/app_constants.dart';
import 'package:job_app/controllers/jobs_provider.dart';
import 'package:job_app/models/response/jobs/jobs_response.dart';
import 'package:job_app/views/common/app_style.dart';
import 'package:job_app/views/common/disconnect.dart';
import 'package:job_app/views/common/loader.dart';
import 'package:job_app/views/common/pages_loader.dart';
import 'package:job_app/views/common/reusable_text.dart';
import 'package:job_app/views/common/width_spacer.dart';
import 'package:job_app/views/screens/job/widgets/job_vertical_title.dart';
import 'package:provider/provider.dart';

class RecentJobs extends StatelessWidget {
  const RecentJobs({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<JobsNotifier>(
      builder: (context, jobsNotifier, child) {
        jobsNotifier.getRecent();
        return SizedBox(
          height:  height * 0.28,
          child: FutureBuilder<List<JobsResponse>>(
            future: jobsNotifier.recentJob,
            builder:(context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: PageLoader());
              } else if(snapshot.hasError){
                return Center(
                  child: Padding(
                    padding: EdgeInsets.all(5.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/404.png",
                          height: 130,

                        ),
                        const WidthSpacer(width: 20),
                        ReusableText(
                            text: "Disconnect",
                            style: appStyle(18, Color(kDark.value), FontWeight.w500))
                      ],
                    ),
                  ),
                );
              } else if(snapshot.data!.isEmpty){
                return NoSearchResults(text: "No Jobs Available");
              } else{
                final jobs = snapshot.data;

                return ListView.builder(
                  itemCount: jobs!.length,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection:  Axis.vertical,
                  itemBuilder: (context, index) {
                    var job = jobs[index];
                    return JobVerticalTitle(job: job,);
                  },
                );
              }
            },
          ),
        );
      },
    );
  }
}
