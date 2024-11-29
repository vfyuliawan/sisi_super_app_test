// To parse this JSON data, do
//
//     final notificationData = notificationDataFromJson(jsonString);

import 'dart:convert';

NotificationData notificationDataFromJson(String str) =>
    NotificationData.fromJson(json.decode(str));

String notificationDataToJson(NotificationData data) =>
    json.encode(data.toJson());

class NotificationData {
  List<DataNotif> data;
  String message;
  int status;

  NotificationData({
    required this.data,
    required this.message,
    required this.status,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      NotificationData(
        data: List<DataNotif>.from(
            json["data"].map((x) => DataNotif.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class DataNotif {
  String day;
  List<String> infoMessage;

  DataNotif({
    required this.day,
    required this.infoMessage,
  });

  factory DataNotif.fromJson(Map<String, dynamic> json) => DataNotif(
        day: json["day"],
        infoMessage: List<String>.from(json["infoMessage"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "infoMessage": List<dynamic>.from(infoMessage.map((x) => x)),
      };
}
