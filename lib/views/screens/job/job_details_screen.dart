import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:job_app/controllers/jobs_provider.dart';
import 'package:job_app/models/response/jobs/get_job.dart';
import 'package:job_app/views/common/BackBtn.dart';
import 'package:job_app/views/common/app_bar.dart';
import 'package:job_app/views/common/loader.dart';
import 'package:job_app/views/common/pages_loader.dart';
import 'package:job_app/views/common/styled_container.dart';
import 'package:provider/provider.dart';

class JobDetailsScreen extends StatefulWidget {
  const JobDetailsScreen({super.key, required this.title, required this.id, required this.companyName});

  final String title;
  final String id;
  final String companyName;

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<JobsNotifier>(
      builder: (context, jobsNotifier, child) {
        jobsNotifier.getJob(widget.id);
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: CustomAppBar(
                actions: [
                  GestureDetector(
                    onTap: () {

                    },
                    child: Padding(
                      padding: EdgeInsets.only(right: 12.w),
                      child: const Icon(Fontisto.bookmark),
                    ),
                  ),
                ],
                child: const BackBtn()
            ),
          ),
          body: buildStyleContainer(
              context,
              FutureBuilder<GetJobRes>(
                future: jobsNotifier.job,
                builder:(context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const PageLoader();
                  } else if(snapshot.hasError){
                    return Text("Error: ${snapshot.error}");
                  } else{
                    final jobs = snapshot.data;

                    return Container();
                  }
                },
              ),
          ),
        );
      },
    );
  }

}
