import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_app/constants/app_constants.dart';
import 'package:job_app/models/response/jobs/jobs_response.dart';
import 'package:job_app/services/helpers/jobs_helper.dart';
import 'package:job_app/views/common/loader.dart';
import 'package:job_app/views/common/pages_loader.dart';
import 'package:job_app/views/screens/job/widgets/job_vertical_title.dart';
import 'package:job_app/views/screens/search/widget/custom_field.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});


  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(kLight.value),
        automaticallyImplyLeading: false,
        elevation: 0,
        title: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(25.w)),
          child: CustomField(
            controller: controller,
            onTap: () {
              setState(() {

              });
            },
          ),
        ),
      ),
      body: controller.text.isNotEmpty ?
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.w),
        child: FutureBuilder<List<JobsResponse>>(
          future: JobsHelper.searchJobs(controller.text),
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
                  return JobVerticalTitle(job: job);
                },
              );
            }
          },
        ),)
      : NoSearchResults(text: 'Start Searching...'),
    );
  }
}
