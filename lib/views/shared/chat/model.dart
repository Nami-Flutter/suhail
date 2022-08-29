import 'dart:convert';

ChatModel chatModelFromJson(String str) => ChatModel.fromJson(json.decode(str));

String chatModelToJson(ChatModel data) => json.encode(data.toJson());

class ChatModel {
  ChatModel({
    this.chatDetails,
  });

  List<ChatDetail>? chatDetails;

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
    chatDetails: List<ChatDetail>.from(json["chat_details"].map((x) => ChatDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "chat_details": List<dynamic>.from(chatDetails!.map((x) => x.toJson())),
  };
}

class ChatDetail {
  ChatDetail({
    this.messageId,
    this.fromId,
    this.toId,
    this.messageTxt,
    this.messageFile,
    this.messageType,
  });

  String? messageId;
  String? fromId;
  String? toId;
  String? messageTxt;
  String? messageFile;
  String? messageType;

  factory ChatDetail.fromJson(Map<String, dynamic> json) => ChatDetail(
    messageId: json["message_id"],
    fromId: json["from_id"],
    toId: json["to_id"],
    messageTxt: json["message_txt"],
    messageFile: json["message_file"],
    messageType: json["message_type"],
  );

  Map<String, dynamic> toJson() => {
    "message_id": messageId,
    "from_id": fromId,
    "to_id": toId,
    "message_txt": messageTxt,
    "message_file": messageFile,
    "message_type": messageType,
  };
}
