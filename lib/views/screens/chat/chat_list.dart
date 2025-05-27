import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:job_app/controllers/chat_provider.dart';
import 'package:job_app/controllers/login_provider.dart';
import 'package:job_app/models/response/chat/get_chat.dart';
import 'package:job_app/views/common/app_bar.dart';
import 'package:job_app/views/common/drawer/drawer_widget.dart';
import 'package:job_app/views/common/exports.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_app/views/common/height_spacer.dart';
import 'package:job_app/views/common/loader.dart';
import 'package:job_app/views/common/page_load.dart';
import 'package:job_app/views/screens/auth/non_user.dart';
import 'package:job_app/views/screens/auth/profile_screen.dart';
import 'package:job_app/views/screens/chat/chat_screen.dart';
import 'package:provider/provider.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  @override
  Widget build(BuildContext context) {
    var loginNotifier = Provider.of<LoginNotifier>(context);
    return Scaffold(
      backgroundColor: Color(kNewBlue.value),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: CustomAppBar(
          color: Color(kNewBlue.value),
          text: !loginNotifier.loggedIn ? "" : "Chat",
          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child: DrawerWidget(color: Color(kLight.value)),
          ),
        ),
      ),
      body: loginNotifier.loggedIn == false
          ? const NonUser()
          : Consumer<ChatNotifier>(
              builder: (context, chatNotifier, child) {
                return FutureBuilder<List<GetChats>>(
                  future: chatNotifier.chats,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const PageLoad();
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else if (snapshot.data == null ||
                        snapshot.data!.isEmpty) {
                      return NoSearchResults(text: "No Chat Available");
                    } else {
                      final chats = snapshot.data!;
                      return ListView.builder(
                        padding: EdgeInsets.fromLTRB(10.w, 5.h, 10.w, 0),
                        itemCount: chats!.length,
                        itemBuilder: (context, index) {
                           final chat = chats[index];
                           var user = chat.users.where((user) => user.id != chatNotifier.userId);
                          // final userList = chat.users.where((u) => u.id != chatNotifier.userId).toList();
                          //
                          // if (userList.isEmpty) {
                          //   return SizedBox();
                          // }
                          //
                          // final user = userList.first;

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: GestureDetector(
                              onTap: () {
                                Get.to(()=> ChatScreen(
                                  id: chat.id,
                                  title: user.first.username,
                                  profile: user.first.profile,
                                  user: [chat.users[0].id,chat.users[1].id],
                                ));
                              },
                              child: Container(
                                height: 0.11 * MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Color(kLightGrey.value),
                                  borderRadius: const BorderRadius.all(Radius.circular(12))
                                ),
                                child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 4.w),
                                  minLeadingWidth: 0,
                                  minVerticalPadding: 0,
                                  leading: CircleAvatar(
                                    radius: 40,
                                     backgroundImage: NetworkImage(user.first.profile),
                                  ),
                                   title: Column(
                                     mainAxisAlignment: MainAxisAlignment.center,
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       ReusableText(
                                           text: user.first.username,
                                           style: appStyle(
                                               16,
                                               Color(kDark.value),
                                               FontWeight.w600
                                           ),
                                       ),
                                       const HeightSpacer(size: 5),
                                       ReusableText(
                                         text: chat.latestMessage.content,
                                         style: appStyle(
                                             16,
                                             Color(kDarkGrey.value),
                                             FontWeight.normal
                                         ),
                                       ),
                                     ],
                                   ),
                                  trailing: Padding(
                                    padding: EdgeInsets.only(right: 4.h),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                        ReusableText(
                                          text: chatNotifier.msgTime(chat.updatedAt.toString()),
                                          style: appStyle(
                                              12,
                                              Color(kDark.value),
                                              FontWeight.normal
                                          ),
                                        ),
                                        Icon(
                                          chat.chatName == chatNotifier.userId
                                              ?
                                            Ionicons.arrow_forward_circle_outline
                                              :
                                            Ionicons.arrow_back_circle_outline)
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                );
              },
            ),
    );
  }
}
