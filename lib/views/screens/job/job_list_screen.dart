import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_app/views/common/BackBtn.dart';
import 'package:job_app/views/common/app_bar.dart';
import 'package:job_app/views/common/page_load.dart';
import 'package:job_app/views/screens/job/widgets/job_category.dart';
import 'package:job_app/services/helpers/jobs_helper.dart';
import 'package:job_app/models/response/jobs/jobs_response.dart';

class JobListScreen extends StatefulWidget {
  const JobListScreen({super.key});

  @override
  _JobListScreenState createState() => _JobListScreenState();
}

class _JobListScreenState extends State<JobListScreen> {
  List<JobsResponse> allJobs = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchJobsFromAPI();
  }

  Future<void> fetchJobsFromAPI() async {
    try {
      List<JobsResponse> fetchedJobs = await JobsHelper.getJobs();
      setState(() {
        allJobs = fetchedJobs;
        isLoading = false;
      });
    } catch (error) {
      print("$error");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.w),
        child: CustomAppBar(
          text: "Jobs",
          child: BackBtn(),
        ),
      ),
      body: isLoading
          ? PageLoad()
          : JobCategory(allJobs: allJobs),
    );
  }
}
