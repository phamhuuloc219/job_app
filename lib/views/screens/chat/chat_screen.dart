import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:job_app/constants/app_constants.dart';
import 'package:job_app/controllers/chat_provider.dart';
import 'package:job_app/models/response/chat/get_chat.dart';
import 'package:job_app/models/response/messaging/messaging_res.dart';
import 'package:job_app/views/common/app_bar.dart';
import 'package:job_app/views/common/app_style.dart';
import 'package:job_app/views/common/drawer/drawer_widget.dart';
import 'package:job_app/views/common/height_spacer.dart';
import 'package:job_app/views/common/loader.dart';
import 'package:job_app/views/common/page_load.dart';
import 'package:job_app/views/common/reusable_text.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen(
      {super.key,
      required this.title,
      required this.id,
      required this.profile,
      required this.user});

  final String title;
  final String id;
  final String profile;
  final List<String> user;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(kLight.value),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: CustomAppBar(
          color: Color(kNewBlue.value),
          text: widget.title,
          actions: [
            Padding(
              padding: EdgeInsets.all(8),
              child: Stack(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(widget.profile),
                  ),
                  Positioned(
                      right: 3,
                      child: CircleAvatar(
                        radius: 5,
                        backgroundColor: Colors.green,
                      ))
                ],
              ),
            ),
          ],
          child: Padding(
            padding: EdgeInsets.all(12.0.h),
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(
                MaterialCommunityIcons.arrow_left,
                color: Color(kLight.value),
              ),
            ),
          ),
        ),
      ),
      body: Consumer<ChatNotifier>(
        builder: (context, chatNotifier, child) {
          return SafeArea(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.h),
            child: Column(
              children: [
                Expanded(
                  child: FutureBuilder<List<ReceivedMessage>>(
                    future: chatNotifier.chats,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const PageLoad();
                      } else if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      } else if (snapshot.data == null ||
                          snapshot.data!.isEmpty) {
                        return NoSearchResults(text: "You do not have messgae");
                      } else {
                        final chats = snapshot.data!;
                        return ListView.builder(
                          padding: EdgeInsets.fromLTRB(10.w, 5.h, 10.w, 0),
                          itemCount: chats!.length,
                          itemBuilder: (context, index) {
                            final chat = chats[index];
                            return Container();
                          },
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ));
        },
      ),
    );
  }
}
