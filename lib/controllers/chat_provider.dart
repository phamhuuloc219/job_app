import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:job_app/models/response/chat/get_chat.dart';
import 'package:job_app/services/helpers/chat_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatNotifier extends ChangeNotifier {
  late Future<List<GetChats>> chats;
  String? userId;
  bool _typing = false;

  bool get typing => _typing;

  set typingStatus(bool newState){
    _typing = newState;
    notifyListeners();
  }

  List<String> _online = [];

  List<String> get online => _online;

  set onlineUser(List<String> newList){
    _online = newList;
    notifyListeners();
  }

  ChatNotifier() {
    _init();
  }

  void _init() async {
    await _getPrefs();
    chats = ChatHelper.getConversations();
    notifyListeners();
  }

  Future<void> _getPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    userId = prefs.getString('userId');
  }

  String msgTime(String timestamp){
    DateTime now = DateTime.now();
    DateTime messageTime = DateTime.parse(timestamp);
    if(now.year == messageTime.year && now.month == messageTime.month && now.day == messageTime.day){
      return DateFormat.Hm().format(messageTime);
    } else if(now.year == messageTime.year && now.month == messageTime.month && now.day - messageTime.day == 1){
      return "Yesterday";
    } else{
      return DateFormat.yMd().format(messageTime);
    }
  }
}
