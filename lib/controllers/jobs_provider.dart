import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_app/constants/app_constants.dart';
import 'package:job_app/models/request/bookmarks/bookmarks_model.dart';
import 'package:job_app/models/response/bookmarks/all_bookmarks.dart';
import 'package:job_app/models/response/jobs/get_job.dart';
import 'package:job_app/models/response/jobs/jobs_response.dart';
import 'package:job_app/services/helpers/book_helper.dart';
import 'package:job_app/services/helpers/jobs_helper.dart';

class JobsNotifier extends ChangeNotifier {
  late Future<List<JobsResponse>> jobList;

  Future<List<JobsResponse>> getJobs(){
    jobList = JobsHelper.getJobs();
    return jobList;
  }
}
