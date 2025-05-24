import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:job_app/controllers/chat_provider.dart';
import 'package:job_app/controllers/login_provider.dart';
import 'package:job_app/models/response/chat/get_chat.dart';
import 'package:job_app/views/common/app_bar.dart';
import 'package:job_app/views/common/drawer/drawer_widget.dart';
import 'package:job_app/views/common/exports.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:job_app/views/common/loader.dart';
import 'package:job_app/views/common/page_load.dart';
import 'package:job_app/views/screens/auth/non_user.dart';
import 'package:job_app/views/screens/auth/profile_screen.dart';
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
        preferredSize: Size.fromHeight(50.h),
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
              } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                return NoSearchResults(text: "No Chat Available");
              } else {
                final chat = snapshot.data!;
                return ListView.builder(
                  itemCount: chat.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 0.26 * MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      color: Color(kOrange.value),
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
