import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_app/constants/app_constants.dart';
import 'package:job_app/controllers/jobs_provider.dart';
import 'package:job_app/models/response/jobs/jobs_response.dart';
import 'package:job_app/views/common/loader.dart';
import 'package:job_app/views/common/pages_loader.dart';
import 'package:job_app/views/screens/job/widgets/uploaded_title.dart';
import 'package:provider/provider.dart';

class PopularJobList extends StatelessWidget {
  const PopularJobList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<JobsNotifier>(
      builder: (context, jobsNotifier, child) {
        jobsNotifier.getJobs();
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0.w),
          child: FutureBuilder<List<JobsResponse>>(
            future: jobsNotifier.jobList,
            builder:(context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: PageLoader());
              } else if(snapshot.hasError){
                return Text("Error: ${snapshot.error}");
              } else if(snapshot.data!.isEmpty){
                return NoSearchResults(text: "No Jobs Available");
              } else{
                final jobs = snapshot.data;

                return ListView.builder(
                  itemCount: jobs!.length,
                  scrollDirection:  Axis.vertical,
                  itemBuilder: (context, index) {
                    var job = jobs[index];
                    return UploadedTitle(job: job, text: 'popular');
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
