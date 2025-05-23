import 'dart:convert';

import 'package:http/http.dart' as https;
import 'package:job_app/models/response/jobs/get_job.dart';
import 'package:job_app/models/response/jobs/job_categories_response.dart';
import 'package:job_app/models/response/jobs/jobs_response.dart';
import 'package:job_app/services/config.dart';

class JobsHelper {
  static var client = https.Client();

  static Future<List<JobsResponse>> getJobs() async{
    Map<String, String> requestHeaders = {
      'Content-Type' : 'application/json'
    };

    var url = Uri.https(Config.apiUrl, Config.jobs);
    var response = await client.get(url, headers: requestHeaders);

    if(response.statusCode == 200){
      var jobList = jobsResponseFromJson(response.body);
      return jobList;
    } else{
      throw Exception('Failed to load jobs');
    }
  }

  static Future<GetJobRes> getJob(String jobId) async{
    Map<String, String> requestHeaders = {
      'Content-Type' : 'application/json'
    };

    var url = Uri.https(Config.apiUrl, "${Config.jobs}/$jobId");
    var response = await client.get(url, headers: requestHeaders);

    if(response.statusCode == 200){
      var job = getJobResFromJson(response.body);
      return job;
    } else{
      throw Exception('Failed to load jobs');
    }
  }

  static Future<List<JobsResponse>> getRecent() async{
    Map<String, String> requestHeaders = {
      'Content-Type' : 'application/json'
    };

    var url = Uri.https(Config.apiUrl, Config.jobs, {'new':'true'});
    var response = await client.get(url, headers: requestHeaders);

    if(response.statusCode == 200){
      var jobList = jobsResponseFromJson(response.body);
      return jobList;
    } else{
      throw Exception('Failed to load jobs');
    }
  }

  static Future<List<JobsResponse>> searchJobs(String query) async{
    Map<String, String> requestHeaders = {
      'Content-Type' : 'application/json'
    };

    var url = Uri.https(Config.apiUrl, '${Config.search}/$query');
    var response = await client.get(url, headers: requestHeaders);

    if(response.statusCode == 200){
      var jobList = jobsResponseFromJson(response.body);
      return jobList;
    } else{
      throw Exception('Failed to load jobs');
    }
  }
  static Future<List<JobCategoriesResponse>> getJobCategories() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json'
    };

    var url = Uri.https(Config.apiUrl, Config.jobCategories);
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      return jsonData.map((category) => JobCategoriesResponse.fromJson(category)).toList();
    } else {
      throw Exception('Failed to load job categories');
    }
  }

  static Future<List<JobsResponse>> getJobsByCategory(String categoryId) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json'
    };

    var url = Uri.https(Config.apiUrl, "${Config.jobCategory}/$categoryId");
    var response = await client.get(url, headers: requestHeaders);

    if (response.statusCode == 200) {
      var jobList = jobsResponseFromJson(response.body);
      return jobList;
    } else {
      throw Exception('Failed to load jobs for category $categoryId');
    }
  }
}
