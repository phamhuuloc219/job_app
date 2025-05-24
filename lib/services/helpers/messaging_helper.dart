import 'dart:convert';

import 'package:http/http.dart' as https;
import 'package:job_app/models/request/messaging/send_message.dart';
import 'package:job_app/models/response/messaging/messaging_res.dart';
import 'package:job_app/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessagingHelper{
  static var client = https.Client();

  static Future<List<dynamic>> sendMessage(SendMessage model) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('token');
    Map<String, String> requestHeaders = {
      'Content-Type' : 'application/json',
      'authorization' : 'Bearer $token'
    };

    var url = Uri.https(Config.apiUrl, Config.messagingUrl);

    var response = await client.post(
        url,
        headers: requestHeaders,
        body: jsonEncode(model.toJson())
    );

    if (response.statusCode == 200){
      ReceivedMessage message = ReceivedMessage.fromJson(jsonDecode(response.body));
      Map<String, dynamic> responseMap = jsonDecode(response.body);
      return [true, message, responseMap];
    } else{
      return [false];
    }
  }

  static Future<List<ReceivedMessage>> getMessages(String chatId, int offset) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? token = prefs.getString('token');
    Map<String, String> requestHeaders = {
      'Content-Type' : 'application/json',
      'authorization' : 'Bearer $token'
    };

    var url = Uri.https(Config.apiUrl, Config.messagingUrl);

    var response = await client.post(
        url,
        headers: requestHeaders
    );

    if (response.statusCode == 200){
      var messages = receivedMessgeFromJson(response.body);
      return messages;
    } else{
      throw Exception("Failed to load message");
    }
  }
}