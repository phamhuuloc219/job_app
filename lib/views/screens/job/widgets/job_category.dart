import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:job_app/constants/app_constants.dart';
import 'package:job_app/models/response/jobs/jobs_response.dart';
import 'package:job_app/models/response/jobs/job_categories_response.dart';
import 'package:job_app/services/helpers/jobs_helper.dart';
import 'package:job_app/views/common/app_style.dart';
import 'package:job_app/views/common/custom_outline_btn.dart';
import 'package:job_app/views/common/page_load.dart';
import 'package:job_app/views/common/reusable_text.dart';
import 'package:job_app/views/screens/job/job_details_screen.dart';

class JobCategory extends StatefulWidget {
  const JobCategory({super.key, required List<JobsResponse> allJobs});

  @override
  _JobCategoryState createState() => _JobCategoryState();
}

class _JobCategoryState extends State<JobCategory> {
  String selectedCategoryId = "All";
  List<JobCategoriesResponse> categories = [];
  List<JobsResponse> jobs = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCategoriesFromAPI();
    fetchJobsFromAPI();
  }

  Future<void> fetchCategoriesFromAPI() async {
    try {
      List<JobCategoriesResponse> fetchedCategories =
          await JobsHelper.getJobCategories();
      setState(() {
        categories = [
          JobCategoriesResponse(id: "All", title: "All", description: "", v: 1),
          ...fetchedCategories,
        ];
      });
    } catch (error) {
      print("$error");
    }
  }

  Future<void> fetchJobsFromAPI() async {
    try {
      setState(() => isLoading = true);

      List<JobsResponse> fetchedJobs = selectedCategoryId == "All"
          ? await JobsHelper.getJobs()
          : await JobsHelper.getJobsByCategory(selectedCategoryId);

      setState(() {
        jobs = fetchedJobs;
        isLoading = false;
      });
    } catch (error) {
      print(error);
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 5,
        ),
        SizedBox(
          height: 30.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      selectedCategoryId = categories[index].id;
                    });
                    fetchJobsFromAPI();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      selectedCategoryId == categories[index].id
                          ? Color(kLightBlue.value)
                          : Color(kLightGrey.value),
                    ),
                  ),
                  child: Text(categories[index].title,
                      style: TextStyle(color: Color(kLight.value))),
                ),
              );
            },
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Expanded(
          child: isLoading
              ? const PageLoad()
              : ListView.builder(
                  itemCount: jobs.length,
                  itemBuilder: (context, index) {
                    JobsResponse job = jobs[index];
                    return FittedBox(
                      child: GestureDetector(
                        onTap: () {
                          Get.to(() => JobDetailsScreen(
                              id: job.id,
                              title: job.title,
                              companyName: job.companyName));
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 10.w),
                            height: height * 0.11,
                            width: width,
                            decoration: BoxDecoration(
                              color: const Color(0x09000000),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(9.w)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 30,
                                          backgroundImage:
                                              NetworkImage(job.imageUrl),
                                        ),
                                        SizedBox(width: 10.w),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ReusableText(
                                              text: job.companyName,
                                              style: appStyle(
                                                  12.5,
                                                  Color(kDark.value),
                                                  FontWeight.w500),
                                            ),
                                            SizedBox(
                                              width: width * 0.5,
                                              child: ReusableText(
                                                text: job.title,
                                                style: appStyle(
                                                    12.5,
                                                    Color(kDarkGrey.value),
                                                    FontWeight.w500),
                                              ),
                                            ),
                                            ReusableText(
                                              text:
                                                  "${job.salary} per ${job.period}",
                                              style: appStyle(
                                                  12.5,
                                                  Color(kDarkGrey.value),
                                                  FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        job.hiring
                                            ? CustomOutlineBtn(
                                                width: 90.w,
                                                height: 36.h,
                                                text: "Apply",
                                                color: Color(kLightBlue.value),
                                              )
                                            : CustomOutlineBtn(
                                                width: 90.w,
                                                height: 36.h,
                                                text: "View",
                                                color: Color(kLightBlue.value),
                                              )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
