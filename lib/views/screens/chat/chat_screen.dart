// import 'package:flutter/material.dart';
// import 'package:flutter_chat_bubble/chat_bubble.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_vector_icons/flutter_vector_icons.dart';
// import 'package:get/get.dart';
// import 'package:job_app/constants/app_constants.dart';
// import 'package:job_app/controllers/chat_provider.dart';
// import 'package:job_app/models/request/messaging/send_message.dart';
// import 'package:job_app/models/response/messaging/messaging_res.dart';
// import 'package:job_app/services/helpers/messaging_helper.dart';
// import 'package:job_app/views/common/app_bar.dart';
// import 'package:job_app/views/common/app_style.dart';
// import 'package:job_app/views/common/height_spacer.dart';
// import 'package:job_app/views/common/loader.dart';
// import 'package:job_app/views/common/page_load.dart';
// import 'package:job_app/views/common/reusable_text.dart';
// import 'package:job_app/views/screens/chat/widget/text_field_chat.dart';
// import 'package:job_app/views/screens/main_screen.dart';
// import 'package:provider/provider.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;
//
// class ChatScreen extends StatefulWidget {
//   const ChatScreen(
//       {super.key,
//       required this.title,
//       required this.id,
//       required this.profile,
//       required this.user});
//
//   final String title;
//   final String id;
//   final String profile;
//   final List<String> user;
//
//   @override
//   State<ChatScreen> createState() => _ChatScreenState();
// }
//
// class _ChatScreenState extends State<ChatScreen> {
//   int offset = 1;
//   IO.Socket? socket;
//   late Future<List<ReceivedMessage>> msgList;
//   TextEditingController messageController = TextEditingController();
//   late List<ReceivedMessage> messages = [];
//   String receiver = '';
//   final ScrollController _scrollController = ScrollController();
//
//   @override
//   void initState() {
//     getMessages(offset);
//     connect();
//     joinChat();
//     handlerNext();
//     super.initState();
//   }
//
//   void getMessages(int offset) {
//     msgList = MessagingHelper.getMessages(widget.id, offset);
//   }
//
//   void handlerNext() {
//     _scrollController.addListener(
//       () async {
//         if (_scrollController.hasClients) {
//           if (_scrollController.position.maxScrollExtent ==
//               _scrollController.position.pixels) {
//             if (messages.length >= 12) {
//               getMessages(offset++);
//               setState(() {});
//             }
//           }
//         }
//       },
//     );
//   }
//
//   void connect() {
//     var chatNotifier = Provider.of<ChatNotifier>(context, listen: false);
//     socket = IO
//         .io('https://job-app-production-a950.up.railway.app', <String, dynamic>{
//       "transports": ['websocket'],
//       "autoConnect": false
//     });
//     socket!.emit("setup", chatNotifier.userId);
//     socket!.connect();
//     socket!.onConnect((_) {
//       socket!.on('online-users', (userId) {
//         chatNotifier.online
//             .replaceRange(0, chatNotifier.online.length, [userId]);
//       });
//       socket!.on('typing', (status) {
//         chatNotifier.typingStatus = false;
//       });
//       socket!.on('stop typing', (status) {
//         chatNotifier.typingStatus = true;
//       });
//       socket!.on('message received', (newMessageReceived) {
//         sendStopTypingEvent(widget.id);
//         ReceivedMessage receivedMessage =
//             ReceivedMessage.fromJson(newMessageReceived);
//
//         if (receivedMessage.sender.id != chatNotifier.userId) {
//           setState(() {
//             messages.insert(0, receivedMessage);
//           });
//         }
//       });
//     });
//   }
//
//   void sendMessage(String content, String chatId, String receiver) {
//     SendMessage model =
//         SendMessage(content: content, chatId: chatId, receiver: receiver);
//
//     MessagingHelper.sendMessage(model).then((response) {
//       var emmission = response[2];
//       socket!.emit('new message', emmission);
//       sendStopTypingEvent(widget.id);
//       setState(() {
//         messageController.clear();
//         messages.insert(0, response[1]);
//       });
//     });
//   }
//
//   void sendTypingEvent(String status) {
//     socket!.emit('typing', status);
//   }
//
//   void sendStopTypingEvent(String status) {
//     socket!.emit('stop typing', status);
//   }
//
//   void joinChat() {
//     socket!.emit('join chat', widget.id);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ChatNotifier>(
//       builder: (context, chatNotifier, child) {
//         receiver = widget.user.firstWhere(
//           (id) => id != chatNotifier.userId,
//         );
//         return Scaffold(
//           backgroundColor: Color(kLight.value),
//           appBar: PreferredSize(
//             preferredSize: Size.fromHeight(50.h),
//             child: CustomAppBar(
//               color: Color(kNewBlue.value),
//               text: !chatNotifier.typing ? widget.title : "typing...",
//               actions: [
//                 Padding(
//                   padding: EdgeInsets.all(8),
//                   child: Stack(
//                     children: [
//                       CircleAvatar(
//                         backgroundImage: NetworkImage(widget.profile),
//                       ),
//                       Positioned(
//                           right: 3,
//                           child: CircleAvatar(
//                             radius: 5,
//                             backgroundColor:
//                                 chatNotifier.online.contains(receiver)
//                                     ? Colors.green
//                                     : Colors.grey,
//                           ))
//                     ],
//                   ),
//                 ),
//               ],
//               child: Padding(
//                 padding: EdgeInsets.all(12.0.h),
//                 child: GestureDetector(
//                   onTap: () {
//                     Get.to(() => const Mainscreen());
//                   },
//                   child: Icon(
//                     MaterialCommunityIcons.arrow_left,
//                     color: Color(kLight.value),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           body: SafeArea(
//               child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 12.h),
//             child: Column(
//               children: [
//                 Expanded(
//                   child: FutureBuilder<List<ReceivedMessage>>(
//                     future: msgList,
//                     builder: (context, snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return const PageLoad();
//                       } else if (snapshot.hasError) {
//                         return Text("Error: ${snapshot.error}");
//                       } else if (snapshot.data == null ||
//                           snapshot.data!.isEmpty) {
//                         return NoSearchResults(text: "You do not have messgae");
//                       } else {
//                         if (messages.isEmpty) {
//                           messages = List.from(snapshot.data!);
//                         }
//
//                         return ListView.builder(
//                           padding: EdgeInsets.fromLTRB(10.w, 5.h, 10.w, 0),
//                           itemCount: messages.length,
//                           reverse: true,
//                           controller: _scrollController,
//                           itemBuilder: (context, index) {
//                             final data = messages[index];
//                             return Padding(
//                               padding: EdgeInsets.only(top: 8, bottom: 12.h),
//                               child: Column(
//                                 children: [
//                                   ReusableText(
//                                     text: chatNotifier.msgTime(
//                                         data.chat.updatedAt.toString()),
//                                     style: appStyle(10, Color(kDark.value),
//                                         FontWeight.normal),
//                                   ),
//                                   const HeightSpacer(size: 15),
//                                   ChatBubble(
//                                     alignment:
//                                         data.sender.id == chatNotifier.userId
//                                             ? Alignment.centerRight
//                                             : Alignment.centerLeft,
//                                     backGroundColor:
//                                         data.sender.id == chatNotifier.userId
//                                             ? Color(kOrange.value)
//                                             : Color(kLightBlue.value),
//                                     elevation: 0,
//                                     clipper: ChatBubbleClipper4(
//                                         radius: 8,
//                                         type: data.sender.id ==
//                                                 chatNotifier.userId
//                                             ? BubbleType.sendBubble
//                                             : BubbleType.receiverBubble),
//                                     child: Container(
//                                       constraints: BoxConstraints(
//                                         maxWidth: width * 0.8,
//                                       ),
//                                       child: Text(
//                                         data.content,
//                                         style: appStyle(14, Color(kLight.value),
//                                             FontWeight.normal),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                         );
//                       }
//                     },
//                   ),
//                 ),
//                 Container(
//                   padding: EdgeInsets.all(12.h),
//                   alignment: Alignment.bottomCenter,
//                   child: TextFieldChat(
//                       onSubmitted: (_) {
//                         String msg = messageController.text;
//                         sendMessage(msg, widget.id, receiver);
//                       },
//                       suffixIcon: GestureDetector(
//                         onTap: () {
//                           String msg = messageController.text;
//                           sendMessage(msg, widget.id, receiver);
//                         },
//                         child: Icon(
//                           Icons.send,
//                           size: 24,
//                           color: Color(kLightBlue.value),
//                         ),
//                       ),
//                       onChanged: (_) {
//                         sendTypingEvent(widget.id);
//                       },
//                       onEditingComplete: () {
//                         String msg = messageController.text;
//                         sendMessage(msg, widget.id, receiver);
//                       },
//                       onTapOutside: (_) {
//                         sendStopTypingEvent(widget.id);
//                       },
//                       messageController: messageController),
//                 )
//               ],
//             ),
//           )),
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:get/get.dart';
import 'package:job_app/constants/app_constants.dart';
import 'package:job_app/controllers/chat_provider.dart';
import 'package:job_app/models/request/messaging/send_message.dart';
import 'package:job_app/models/response/messaging/messaging_res.dart';
import 'package:job_app/services/helpers/messaging_helper.dart';
import 'package:job_app/views/common/app_bar.dart';
import 'package:job_app/views/common/app_style.dart';
import 'package:job_app/views/common/height_spacer.dart';
import 'package:job_app/views/common/loader.dart';
import 'package:job_app/views/common/page_load.dart';
import 'package:job_app/views/common/reusable_text.dart';
import 'package:job_app/views/screens/chat/widget/text_field_chat.dart';
import 'package:job_app/views/screens/main_screen.dart';
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
  TextEditingController messageController = TextEditingController();
  List<ReceivedMessage> messages = [];
  String receiver = '';
  final ScrollController _scrollController = ScrollController();

  bool isLoadingMessages = true;
  bool hasMoreMessages = true;

  @override
  void initState() {
    super.initState();
    loadMessages();
    connect();
    joinChat();
    handlerNext();
  }

  Future<void> loadMessages() async {
    try {
      final initialMessages =
          await MessagingHelper.getMessages(widget.id, offset);
      setState(() {
        messages = initialMessages;
        isLoadingMessages = false;
        if (initialMessages.length < 12) {
          hasMoreMessages = false;
        }
      });
    } catch (e) {
      setState(() {
        isLoadingMessages = false;
      });
    }
  }

  Future<void> getMoreMessages() async {
    if (!hasMoreMessages) return;

    offset++;

    try {
      final moreMessages = await MessagingHelper.getMessages(widget.id, offset);

      if (moreMessages.isEmpty) {
        setState(() {
          hasMoreMessages = false;
        });
      } else {
        setState(() {
          messages.addAll(moreMessages);
        });
      }
    } catch (e) {
      print("$e");
    }
  }

  // void getMoreMessages() async {
  //   if (!hasMoreMessages) return;
  //   offset++;
  //   final moreMessages = await MessagingHelper.getMessages(widget.id, offset);
  //   if (moreMessages.isEmpty) {
  //     hasMoreMessages = false;
  //   } else {
  //     setState(() {
  //       messages.addAll(moreMessages);
  //     });
  //   }
  // }

  void handlerNext() {
    _scrollController.addListener(() async {
      if (_scrollController.hasClients) {
        if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 100) {
          if (hasMoreMessages) {
            await getMoreMessages();
          }
        }
      }
    });
  }

  void connect() {
    var chatNotifier = Provider.of<ChatNotifier>(context, listen: false);
    socket = IO
        .io('https://job-app-production-a950.up.railway.app', <String, dynamic>{
      "transports": ['websocket'],
      "autoConnect": false
    });
    socket!.emit("setup", chatNotifier.userId);
    socket!.connect();
    socket!.onConnect((_) {
      socket!.on('online-users', (userId) {
        chatNotifier.online
            .replaceRange(0, chatNotifier.online.length, [userId]);
      });
      socket!.on('typing', (status) {
        chatNotifier.typingStatus = false;
      });
      socket!.on('stop typing', (status) {
        chatNotifier.typingStatus = true;
      });
      socket!.on('message received', (newMessageReceived) {
        sendStopTypingEvent(widget.id);
        ReceivedMessage receivedMessage =
            ReceivedMessage.fromJson(newMessageReceived);

        if (receivedMessage.sender.id != chatNotifier.userId) {
          setState(() {
            messages.insert(0, receivedMessage);
          });
        }
      });
    });
  }

  void sendMessage(String content, String chatId, String receiver) {
    SendMessage model =
        SendMessage(content: content, chatId: chatId, receiver: receiver);

    MessagingHelper.sendMessage(model).then((response) {
      var emmission = response[2];
      socket!.emit('new message', emmission);
      sendStopTypingEvent(widget.id);
      setState(() {
        messageController.clear();
        messages.insert(0, response[1]);
      });
    });
  }

  void sendTypingEvent(String status) {
    socket!.emit('typing', status);
  }

  void sendStopTypingEvent(String status) {
    socket!.emit('stop typing', status);
  }

  void joinChat() {
    socket!.emit('join chat', widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Consumer<ChatNotifier>(
      builder: (context, chatNotifier, child) {
        receiver = widget.user.firstWhere(
          (id) => id != chatNotifier.userId,
        );
        return Scaffold(
          backgroundColor: Color(kLight.value),
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(50.h),
            child: CustomAppBar(
              color: Color(kNewBlue.value),
              text: !chatNotifier.typing ? widget.title : "typing...",
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
                          backgroundColor:
                              chatNotifier.online.contains(receiver)
                                  ? Colors.green
                                  : Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
              ],
              child: Padding(
                padding: EdgeInsets.all(12.0.h),
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => const Mainscreen());
                  },
                  child: Icon(
                    MaterialCommunityIcons.arrow_left,
                    color: Color(kLight.value),
                  ),
                ),
              ),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.h),
              child: Column(
                children: [
                  Expanded(
                    child: isLoadingMessages
                        ? const PageLoad()
                        : messages.isEmpty
                            ? NoSearchResults(text: "You do not have message")
                            : ListView.builder(
                                padding:
                                    EdgeInsets.fromLTRB(10.w, 5.h, 10.w, 0),
                                itemCount: messages.length,
                                reverse: true,
                                controller: _scrollController,
                                itemBuilder: (context, index) {
                                  final data = messages[index];
                                  return Padding(
                                    padding:
                                        EdgeInsets.only(top: 8, bottom: 12.h),
                                    child: Column(
                                      children: [
                                        ReusableText(
                                          text: chatNotifier.msgTime(
                                              data.chat.updatedAt.toString()),
                                          style: appStyle(
                                              10,
                                              Color(kDark.value),
                                              FontWeight.normal),
                                        ),
                                        const HeightSpacer(size: 15),
                                        ChatBubble(
                                          alignment: data.sender.id ==
                                                  chatNotifier.userId
                                              ? Alignment.centerRight
                                              : Alignment.centerLeft,
                                          backGroundColor: data.sender.id ==
                                                  chatNotifier.userId
                                              ? Color(kOrange.value)
                                              : Color(kLightBlue.value),
                                          elevation: 0,
                                          clipper: ChatBubbleClipper4(
                                            radius: 8,
                                            type: data.sender.id ==
                                                    chatNotifier.userId
                                                ? BubbleType.sendBubble
                                                : BubbleType.receiverBubble,
                                          ),
                                          child: Container(
                                            constraints: BoxConstraints(
                                              maxWidth: width * 0.8,
                                            ),
                                            child: Text(
                                              data.content,
                                              style: appStyle(
                                                  14,
                                                  Color(kLight.value),
                                                  FontWeight.normal),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                  ),
                  Container(
                    padding: EdgeInsets.all(12.h),
                    alignment: Alignment.bottomCenter,
                    child: TextFieldChat(
                      onSubmitted: (_) {
                        String msg = messageController.text;
                        if (msg.trim().isNotEmpty) {
                          sendMessage(msg.trim(), widget.id, receiver);
                        }
                      },
                      suffixIcon: GestureDetector(
                        onTap: () {
                          String msg = messageController.text;
                          if (msg.trim().isNotEmpty) {
                            sendMessage(msg.trim(), widget.id, receiver);
                          }
                        },
                        child: Icon(
                          Icons.send,
                          size: 24,
                          color: Color(kLightBlue.value),
                        ),
                      ),
                      onChanged: (_) {
                        sendTypingEvent(widget.id);
                      },
                      onEditingComplete: () {
                        String msg = messageController.text;
                        if (msg.trim().isNotEmpty) {
                          sendMessage(msg.trim(), widget.id, receiver);
                        }
                      },
                      onTapOutside: (_) {
                        sendStopTypingEvent(widget.id);
                      },
                      messageController: messageController,
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
