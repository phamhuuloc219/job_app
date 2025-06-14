import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:job_app/constants/app_constants.dart';
import 'package:job_app/controllers/bookmark_provider.dart';
import 'package:job_app/controllers/jobs_provider.dart';
import 'package:job_app/controllers/login_provider.dart';
import 'package:job_app/models/request/chat/create_chat.dart';
import 'package:job_app/models/request/messaging/send_message.dart';
import 'package:job_app/models/response/bookmarks/book_res.dart';
import 'package:job_app/models/response/jobs/get_job.dart';
import 'package:job_app/services/helpers/chat_helper.dart';
import 'package:job_app/services/helpers/jobs_helper.dart';
import 'package:job_app/services/helpers/messaging_helper.dart';
import 'package:job_app/views/common/BackBtn.dart';
import 'package:job_app/views/common/app_bar.dart';
import 'package:job_app/views/common/custom_outline_btn.dart';
import 'package:job_app/views/common/disconnect.dart';
import 'package:job_app/views/common/exports.dart';
import 'package:job_app/views/common/height_spacer.dart';
import 'package:job_app/views/common/page_load.dart';
import 'package:job_app/views/common/styled_container.dart';
import 'package:job_app/views/screens/auth/login_screen.dart';
import 'package:job_app/views/screens/bookmark/bookmarks_screen.dart';
import 'package:job_app/views/screens/chat/chat_list.dart';
import 'package:provider/provider.dart';

class JobDetailsScreen extends StatefulWidget {
  const JobDetailsScreen(
      {super.key,
      required this.title,
      required this.id,
      required this.companyName});

  final String title;
  final String id;
  final String companyName;

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  late Future<GetJobRes> job;
  bool _isApplying = false;

  @override
  void initState() {
    getJob();
    super.initState();
  }

  getJob() {
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
            child: CustomAppBar(actions: [
              loginNotifier.loggedIn != false
                  ? Consumer<BookNotifier>(
                      builder: (context, bookNotifier, child) {
                        bookNotifier.getBookMark(widget.id);

                        return GestureDetector(
                          onTap: () {
                            if (bookNotifier.bookmark == true) {
                              bookNotifier
                                  .deleteBookMark(bookNotifier.bookmarkId);
                            } else {
                              BookMarkReqRes model =
                                  BookMarkReqRes(job: widget.id);
                              var newModel = bookMarkReqResToJson(model);
                              bookNotifier.addBookMark(newModel);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      const Text('Bookmark added successfully'),
                                  backgroundColor: Color(kDark.value),
                                  behavior: SnackBarBehavior.floating,
                                  duration: const Duration(seconds: 3),
                                  action: SnackBarAction(
                                    label: 'View',
                                    textColor: Color(kLight.value),
                                    onPressed: () {
                                      Get.to(() => BookmarksScreen());
                                    },
                                  ),
                                ),
                              );
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: 12.w),
                            child: Icon(
                              bookNotifier.bookmark == false
                                  ? Fontisto.bookmark
                                  : Fontisto.bookmark_alt,
                            ),
                          ),
                        );
                      },
                    )
                  : const SizedBox.shrink(),
            ], child: const BackBtn()),
          ),
          body: buildStyleContainer(
            context,
            FutureBuilder<GetJobRes>(
              future: job,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const PageLoad();
                } else if (snapshot.hasError) {
                  return DisconnectScreen(text: "Disconnect",);
                } else {
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(9.w))),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 30.w,
                                    backgroundImage:
                                        NetworkImage(job!.imageUrl),
                                  ),
                                  const HeightSpacer(size: 10),
                                  ReusableText(
                                      text: job.title,
                                      style: appStyle(16, Color(kDark.value),
                                          FontWeight.w600)),
                                  const HeightSpacer(size: 5),
                                  ReusableText(
                                      text: job.location,
                                      style: appStyle(
                                          16,
                                          Color(kDarkGrey.value),
                                          FontWeight.w600)),
                                  const HeightSpacer(size: 15),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 50),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomOutlineBtn(
                                            width: width * .26,
                                            height: height * .04,
                                            text: job.contract,
                                            color: Color(kOrange.value)),
                                        Row(
                                          children: [
                                            ReusableText(
                                                text: job.salary,
                                                style: appStyle(
                                                    14,
                                                    Color(kDark.value),
                                                    FontWeight.w600)),
                                            ReusableText(
                                                text: "/${job.period}",
                                                style: appStyle(
                                                    14,
                                                    Color(kDark.value),
                                                    FontWeight.w600)),
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
                                    16, Color(kDark.value), FontWeight.w600)),
                            const HeightSpacer(size: 10),
                            Text(
                              job.description,
                              maxLines: 9,
                              textAlign: TextAlign.justify,
                              style: appStyle(12, Color(kDarkGrey.value),
                                  FontWeight.normal),
                            ),
                            const HeightSpacer(size: 10),
                            ReusableText(
                                text: "Requirements",
                                style: appStyle(
                                    16, Color(kDark.value), FontWeight.w600)),
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
                                      '$bullet $requirement',
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
                            child: loginNotifier.loggedIn == false
                                ? CustomOutlineBtn(
                                    onTap: () {
                                      Get.to(() => LoginScreen());
                                    },
                                    text: "Please Login",
                                    height: height * 0.06,
                                    color: Color(kLight.value),
                                    color2: Color(kOrange.value),
                                  )
                                : CustomOutlineBtn(
                                    onTap: () async {
                                      setState(() => _isApplying = true);

                                      final createChat = CreateChat(
                                          userId: job.companyId.userId);
                                      final response =
                                          await ChatHelper.apply(createChat);

                                      if (response[0]) {
                                        final chatId = response[1];

                                        final message = SendMessage(
                                          content:
                                              "Hello, I'm interested in ${job.title} job in ${job.location}",
                                          chatId: chatId,
                                          receiver: job.companyId.userId,
                                        );

                                        await MessagingHelper.sendMessage(
                                            message);

                                        Get.to(() => ChatList());
                                      }

                                      setState(() => _isApplying = false);
                                    },
                                    text: _isApplying ? "Applying..." : "Apply",
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
