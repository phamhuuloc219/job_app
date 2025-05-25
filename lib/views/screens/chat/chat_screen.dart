import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:job_app/constants/app_constants.dart';
import 'package:job_app/controllers/chat_provider.dart';
import 'package:job_app/models/response/chat/get_chat.dart';
import 'package:job_app/models/response/messaging/messaging_res.dart';
import 'package:job_app/services/helpers/chat_helper.dart';
import 'package:job_app/services/helpers/messaging_helper.dart';
import 'package:job_app/views/common/app_bar.dart';
import 'package:job_app/views/common/app_style.dart';
import 'package:job_app/views/common/drawer/drawer_widget.dart';
import 'package:job_app/views/common/height_spacer.dart';
import 'package:job_app/views/common/loader.dart';
import 'package:job_app/views/common/page_load.dart';
import 'package:job_app/views/common/reusable_text.dart';
import 'package:job_app/views/screens/chat/widget/text_field_chat.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

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
  int offset = 1;
  IO.Socket? socket;
  late Future<List<ReceivedMessage>> msgList;
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    getMessages();
    connect();
    joinChat();
    super.initState();
  }

  void getMessages() {
    msgList = MessagingHelper.getMessages(widget.id, offset);
  }

  void connect(){
    var chatNotifier = Provider.of<ChatNotifier>(context, listen: false);
    socket = IO.io('https://job-app-production-a950.up.railway.app', <String, dynamic>{
      "transports" : ['websocket'],
      "autoConnect" : false
    });
    socket!.emit("setup", chatNotifier.userId);
    socket!.connect();
    socket!.onConnect((_) {
      socket!.on('online-users', (userId){
        chatNotifier.online.replaceRange(0, chatNotifier.online.length, [userId]);
      });
      socket!.on('typing', (status) {
        chatNotifier.typingStatus = true;
      });
      socket!.on('stop typing', (status) {
        chatNotifier.typingStatus = true;
      });
      socket!.on('message received', (newMessageReceived) {
        chatNotifier.typingStatus = true;
      });
    });
  }

  void sendTypingEvent(String status){
    socket!.emit('typing', status);
  }

  void joinChat(){
    socket!.emit('join chat', widget.id);
  }

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
                    future: msgList,
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
                            final data = chats[index];
                            return Padding(
                              padding: EdgeInsets.only(top: 8, bottom: 12.h),
                              child: Column(
                                children: [
                                  ReusableText(
                                    text: chatNotifier.msgTime(
                                        data.chat.updatedAt.toString()),
                                    style: appStyle(10, Color(kDark.value),
                                        FontWeight.normal),
                                  ),
                                  const HeightSpacer(size: 15),
                                  ChatBubble(
                                    alignment:
                                        data.sender.id == chatNotifier.userId
                                            ? Alignment.centerRight
                                            : Alignment.centerLeft,
                                    backGroundColor:
                                        data.sender.id == chatNotifier.userId
                                            ? Color(kOrange.value)
                                            : Color(kLightBlue.value),
                                    elevation: 0,
                                    clipper: ChatBubbleClipper4(
                                        radius: 8,
                                        type: data.sender.id ==
                                                chatNotifier.userId
                                            ? BubbleType.sendBubble
                                            : BubbleType.receiverBubble),
                                    child: Container(
                                      constraints: BoxConstraints(
                                        maxWidth: width * 0.8,
                                      ),
                                      child: ReusableText(
                                        text: data.content,
                                        style: appStyle(14, Color(kLight.value),
                                            FontWeight.normal),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(12.h),
                  alignment: Alignment.bottomCenter,
                  child: TextFieldChat(
                      suffixIcon: GestureDetector(
                        onTap: () {},
                        child: Icon(
                          Icons.send,
                          size: 24,
                          color: Color(kLightBlue.value),
                        ),
                      ),
                      messageController: messageController),
                )
              ],
            ),
          ));
        },
      ),
    );
  }
}
