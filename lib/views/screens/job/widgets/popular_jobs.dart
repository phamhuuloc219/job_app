import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_app/constants/app_constants.dart';
import 'package:job_app/controllers/jobs_provider.dart';
import 'package:job_app/models/response/jobs/jobs_response.dart';
import 'package:job_app/views/common/loader.dart';
import 'package:job_app/views/common/pages_loader.dart';
import 'package:job_app/views/common/styled_container.dart';
import 'package:job_app/views/screens/job/job_details_screen.dart';
import 'package:job_app/views/screens/job/widgets/jobs_horizotal_title.dart';
import 'package:provider/provider.dart';

class PopularJobs extends StatelessWidget {
  const PopularJobs({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<JobsNotifier>(
        builder: (context, jobsNotifier, child) {
          jobsNotifier.getJobs();
          return SizedBox(
            height:  height * 0.28,
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
                    scrollDirection:  Axis.horizontal,
                    itemBuilder: (context, index) {
                      var job = jobs[index];
                      return JobsHorizotalTitle(
                        job: job,
                        onTap: () {
                          Get.to(()=> JobDetailsScreen(id: job.id, title: job.title, companyName:  job.companyName));
                        },
                      );
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
