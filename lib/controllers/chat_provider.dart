import 'package:flutter/material.dart';
import 'package:job_app/models/response/chat/get_chat.dart';
import 'package:job_app/services/helpers/chat_helper.dart';
class ChatNotifier extends ChangeNotifier {
  late Future<List<GetChats>> chats;

  ChatNotifier() {
    loadChats();
  }

  void loadChats() {
    chats = ChatHelper.getConversations();
    notifyListeners();
  }
}
