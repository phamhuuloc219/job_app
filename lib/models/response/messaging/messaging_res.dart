// import 'dart:convert';
//
// List<ReceivedMessage> receivedMessgeFromJson(String str) => List<ReceivedMessage>.from(json.decode(str).map((x) => ReceivedMessage.fromJson(x)));
//
//
// class ReceivedMessage {
//     final String id;
//     final Sender sender;
//     final String content;
//     final Chat chat;
//     final DateTime updatedAt;
//     final List<dynamic> readBy;
//     final int v;
//
//     ReceivedMessage({
//         required this.id,
//         required this.sender,
//         required this.content,
//         required this.chat,
//         required this.readBy,
//         required this.updatedAt,
//         required this.v,
//     });
//
//     factory ReceivedMessage.fromJson(Map<String, dynamic> json) => ReceivedMessage(
//         id: json["_id"],
//         sender: Sender.fromJson(json["sender"]),
//         content: json["content"],
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         chat: Chat.fromJson(json["chat"]),
//         readBy: List<dynamic>.from(json["readBy"].map((x) => x)),
//         v: json["__v"],
//     );
//
// }
//
// class Chat {
//     final String id;
//     final String chatName;
//     final bool isGroupChat;
//     final List<Sender> users;
//     final DateTime createdAt;
//     final DateTime updatedAt;
//     final int v;
//     final String? latestMessage;
//
//     Chat({
//         required this.id,
//         required this.chatName,
//         required this.isGroupChat,
//         required this.users,
//         required this.createdAt,
//         required this.updatedAt,
//         required this.v,
//         required this.latestMessage,
//     });
//
//     factory Chat.fromJson(Map<String, dynamic> json) => Chat(
//         id: json["_id"],
//         chatName: json["chatName"],
//         isGroupChat: json["isGroupChat"],
//         users: List<Sender>.from(json["users"].map((x) => Sender.fromJson(x))),
//         createdAt: DateTime.parse(json["createdAt"]),
//         updatedAt: DateTime.parse(json["updatedAt"]),
//         v: json["__v"],
//         latestMessage: json["latestMessage"],
//     );
//
//
// }
//
// class Sender {
//     final String id;
//     final String username;
//     final String email;
//     final String? profile;
//
//     Sender({
//         required this.id,
//         required this.username,
//         required this.email,
//         required this.profile,
//     });
//
//     factory Sender.fromJson(Map<String, dynamic> json) => Sender(
//         id: json["_id"],
//         username: json["username"],
//         email: json["email"],
//         profile: json["profile"],
//     );
//
// }

import 'dart:convert';

List<ReceivedMessage> receivedMessageFromJson(String str) {
    final jsonData = json.decode(str);
    if (jsonData is! List) throw FormatException("Expected a List at top level");
    return jsonData
        .map((e) => ReceivedMessage.fromJson(e as Map<String, dynamic>))
        .toList();
}

class ReceivedMessage {
    final String id;
    final Sender sender;
    final String content;
    final Chat chat;
    final DateTime updatedAt;
    final List<dynamic> readBy;
    final int v;

    ReceivedMessage({
        required this.id,
        required this.sender,
        required this.content,
        required this.chat,
        required this.readBy,
        required this.updatedAt,
        required this.v,
    });

    factory ReceivedMessage.fromJson(Map<String, dynamic> json) {
        return ReceivedMessage(
            id: json["_id"] as String? ?? "",
            sender: json["sender"] != null
                ? Sender.fromJson(json["sender"] as Map<String, dynamic>)
                : (throw FormatException("Missing sender")),
            content: json["content"] as String? ?? "",
            chat: json["chat"] != null
                ? Chat.fromJson(json["chat"] as Map<String, dynamic>)
                : (throw FormatException("Missing chat")),
            updatedAt: json["updatedAt"] != null
                ? DateTime.parse(json["updatedAt"] as String)
                : DateTime.now(),
            readBy: json["readBy"] != null
                ? List<dynamic>.from(json["readBy"] as List)
                : <dynamic>[],
            v: json["__v"] as int? ?? 0,
        );
    }
}

class Chat {
    final String id;
    final String chatName;
    final bool isGroupChat;
    final List<Sender> users;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;
    final String latestMessage;

    Chat({
        required this.id,
        required this.chatName,
        required this.isGroupChat,
        required this.users,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
        required this.latestMessage,
    });

    factory Chat.fromJson(Map<String, dynamic> json) {
        return Chat(
            id: json["_id"] as String? ?? "",
            chatName: json["chatName"] as String? ?? "",
            isGroupChat: json["isGroupChat"] as bool? ?? false,
            users: (json["users"] as List?)
                ?.map((e) => Sender.fromJson(e as Map<String, dynamic>))
                .toList() ??
                <Sender>[],
            createdAt: json["createdAt"] != null
                ? DateTime.parse(json["createdAt"] as String)
                : DateTime.now(),
            updatedAt: json["updatedAt"] != null
                ? DateTime.parse(json["updatedAt"] as String)
                : DateTime.now(),
            v: json["__v"] as int? ?? 0,
            latestMessage: json["latestMessage"] as String? ?? "",
        );
    }
}

class Sender {
    final String id;
    final String username;
    final String email;
    final String profile;

    Sender({
        required this.id,
        required this.username,
        required this.email,
        required this.profile,
    });

    factory Sender.fromJson(Map<String, dynamic> json) {
        return Sender(
            id: json["_id"] as String? ?? "",
            username: json["username"] as String? ?? "",
            email: json["email"] as String? ?? "",
            profile: json["profile"] as String? ?? "",
        );
    }
}

