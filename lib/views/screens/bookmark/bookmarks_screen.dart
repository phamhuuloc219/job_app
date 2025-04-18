import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_app/constants/app_constants.dart';
import 'package:job_app/controllers/bookmark_provider.dart';
import 'package:job_app/controllers/login_provider.dart';
import 'package:job_app/models/response/bookmarks/all_bookmarks.dart';
import 'package:job_app/views/common/app_bar.dart';
import 'package:job_app/views/common/drawer/drawer_widget.dart';
import 'package:job_app/views/common/page_load.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_app/views/common/styled_container.dart';
import 'package:job_app/views/screens/auth/non_user.dart';
import 'package:job_app/views/screens/auth/profile_screen.dart';
import 'package:job_app/views/screens/bookmark/widgets/bookmark_title.dart';
import 'package:provider/provider.dart';

class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key});

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen> {
  @override
  Widget build(BuildContext context) {
    var loginNotifier = Provider.of<LoginNotifier>(context);
    return Scaffold(
      backgroundColor: Color(kNewBlue.value),
      appBar:PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          color: Color(kNewBlue.value),
          text: !loginNotifier.loggedIn ? "" : "Bookmarks",
            actions: [
              Padding(
                padding: EdgeInsets.all(12.0.h),
                child: GestureDetector(
                  onTap: () {
                    Get.to(()=> ProfileScreen(drawer: false));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    child: CachedNetworkImage(
                      height: 30.w,
                      width: 30.w,
                      imageUrl: 'https://raw.githubusercontent.com/phamhuuloc219/job_app/refs/heads/main/assets/images/user.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              )
            ],
            child: Padding(
              padding: EdgeInsets.all(12.0.h),
              child: DrawerWidget(color: Color(kLight.value)),
            )
        ),
      ),
      body: loginNotifier.loggedIn == false
          ? const NonUser()
          : Consumer<BookNotifier>(
          builder: (context, bookNotifier, child) {
            bookNotifier.getBookMarks();
            var bookmarks = bookNotifier.getBookMarks();
            return Stack(
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.w),
                        topLeft: Radius.circular(20.w),
                      ),
                      color: const Color(0xFFEFFFFC)
                    ),
                    child: buildStyleContainer(
                        context,
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: FutureBuilder<List<AllBookMarks>>(
                            future: bookmarks,
                            builder: (context, snapshot) {
                              if(snapshot.connectionState == ConnectionState.waiting){
                                return const PageLoad();
                              } else if (snapshot.hasError){
                                return Text("Error: ${snapshot.error}");
                              } else{
                                var proccessedBooks = snapshot.data;
                                return ListView.builder(
                                  itemCount: proccessedBooks!.length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    final bookmark = proccessedBooks[index];

                                    return BookmarkTitle(
                                      bookmark: bookmark,
                                    );
                                  },
                                );
                              }
                            },
                          ),
                        ),
                    ),
                  )
                )
              ],
            );
          },
          )
    );
  }
}
