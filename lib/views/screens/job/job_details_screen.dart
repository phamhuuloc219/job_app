import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:job_app/constants/app_constants.dart';
import 'package:job_app/controllers/bookmark_provider.dart';
import 'package:job_app/controllers/jobs_provider.dart';
import 'package:job_app/controllers/login_provider.dart';
import 'package:job_app/models/response/bookmarks/book_res.dart';
import 'package:job_app/models/response/jobs/get_job.dart';
import 'package:job_app/services/helpers/jobs_helper.dart';
import 'package:job_app/views/common/BackBtn.dart';
import 'package:job_app/views/common/app_bar.dart';
import 'package:job_app/views/common/custom_outline_btn.dart';
import 'package:job_app/views/common/exports.dart';
import 'package:job_app/views/common/height_spacer.dart';
import 'package:job_app/views/common/page_load.dart';
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
  late Future<GetJobRes> job;


  @override
  void initState() {
    getJob();
    super.initState();
  }

  getJob(){
    job = JobsHelper.getJob(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    var loginNotifier = Provider.of<LoginNotifier>(context);
    return Consumer<JobsNotifier>(
      builder: (context, jobsNotifier, child) {
        jobsNotifier.getJob(widget.id);
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: CustomAppBar(
                actions: [
                  loginNotifier.loggedIn != false
                  ? Consumer<BookNotifier>(
                    builder: (context, bookNotifier, child) {
                      bookNotifier.getBookMark(widget.id);

                      return GestureDetector(
                        onTap: () {
                          if (bookNotifier.bookmark == true) {
                            bookNotifier.deleteBookMark(bookNotifier.bookmarkId);
                          } else {
                            BookMarkReqRes model = BookMarkReqRes(job: widget.id);
                            var newModel = bookMarkReqResToJson(model);
                            bookNotifier.addBookMark(newModel);
                            Get.snackbar(
                                'Bookmark added',
                                'Job has been bookmarked',
                                colorText: Color(kLight.value),
                                backgroundColor: Colors.green,
                                icon: const Icon(Icons.bookmark_added)
                            );
                          }
                        },
                        child: Padding(
                          padding: EdgeInsets.only(right: 12.w),
                          child: Icon(bookNotifier.bookmark == false
                              ? Fontisto.bookmark
                              : Fontisto.bookmark_alt,
                          ),
                        ),
                      );
                    },
                  ) : const SizedBox.shrink(),
                ],
                child: const BackBtn()
            ),
          ),
          body: buildStyleContainer(
              context,
              FutureBuilder<GetJobRes>(
                future: job,
                builder:(context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const PageLoad();
                  } else if(snapshot.hasError){
                    return Text("Error: ${snapshot.error}");
                  } else{
                    final job = snapshot.data;

                    return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Stack(
                          children: [
                            ListView(
                              padding: EdgeInsets.zero,
                              children: [
                                Container(
                                  width: width,
                                  height: height * 0.27,
                                  decoration: BoxDecoration(
                                    color: Color(kLightGrey.value),
                                    // image: const DecorationImage(
                                    //     image: AssetImage(
                                    //         'assets/images/jobs.png',
                                    //
                                    //     ),
                                    //     opacity: 0.35
                                    // ),
                                    borderRadius: BorderRadius.all(Radius.circular(9.w))
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircleAvatar(
                                        radius: 30.w,
                                        backgroundImage: NetworkImage(job!.imageUrl),
                                      ),

                                      const HeightSpacer(size: 10),

                                      ReusableText(
                                          text: job.title,
                                          style: appStyle(
                                              16,
                                              Color(kDark.value),
                                              FontWeight.w600
                                          )
                                      ),

                                      const HeightSpacer(size: 5),

                                      ReusableText(
                                          text: job.location,
                                          style: appStyle(
                                              16,
                                              Color(kDarkGrey.value),
                                              FontWeight.w600
                                          )
                                      ),

                                      const HeightSpacer(size: 15),
                                      
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 50),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomOutlineBtn(
                                                width: width * .26,
                                                height: height * .04,
                                                text: job.contract,
                                                color: Color(kOrange.value)
                                            ),

                                            Row(
                                              children: [
                                                ReusableText(
                                                    text: job.salary,
                                                    style: appStyle(
                                                        14,
                                                        Color(kDark.value),
                                                        FontWeight.w600
                                                    )
                                                ),
                                                ReusableText(
                                                    text: "/${job.period}",
                                                    style: appStyle(
                                                        14,
                                                        Color(kDark.value),
                                                        FontWeight.w600
                                                    )
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                
                                const HeightSpacer(size: 10),

                                ReusableText(
                                    text: "Description",
                                    style: appStyle(
                                        16,
                                        Color(kDark.value),
                                        FontWeight.w600
                                    )
                                ),

                                const HeightSpacer(size: 10),

                                Text(
                                  job.description,
                                  maxLines: 9,
                                  textAlign: TextAlign.justify,
                                  style: appStyle(
                                      12,
                                      Color(kDarkGrey.value),
                                      FontWeight.normal
                                  ),
                                ),

                                const HeightSpacer(size: 10),

                                ReusableText(
                                    text: "Requirements",
                                    style: appStyle(
                                        16,
                                        Color(kDark.value),
                                        FontWeight.w600
                                    )
                                ),

                                const HeightSpacer(size: 10),

                                SizedBox(
                                  height: height * 0.6,
                                  child: ListView.builder(
                                    itemCount: job.requirement.length,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      var requirement = job.requirement[index];
                                      String bullet = '\u2022';
                                      return Padding(
                                        padding: EdgeInsets.only(bottom: 12.w),
                                        child: Text(
                                          '$bullet ${requirement}',
                                          style: appStyle(
                                              12,
                                              Color(kDarkGrey.value),
                                              FontWeight.normal),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 20.0.w),
                                child: CustomOutlineBtn(
                                  onTap: () {},
                                  text: !loginNotifier.loggedIn
                                      ? "Please Login"
                                      : "Apply",
                                  height: height * 0.06,
                                  color: Color(kLight.value),
                                  color2: Color(kOrange.value),
                                ),
                              ),
                            ),
                          ],
                        ),
                    );
                  }
                },
              ),
          ),
        );
      },
    );
  }
}
