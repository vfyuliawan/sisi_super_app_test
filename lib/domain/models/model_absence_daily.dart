// To parse this JSON data, do
//
//     final modelAbsensiDaily = modelAbsensiDailyFromJson(jsonString);

import 'dart:convert';

ModelAbsensiDaily modelAbsensiDailyFromJson(String str) =>
    ModelAbsensiDaily.fromJson(json.decode(str));

String modelAbsensiDailyToJson(ModelAbsensiDaily data) =>
    json.encode(data.toJson());

class ModelAbsensiDaily {
  List<DataDaily> data;
  String message;
  int status;

  ModelAbsensiDaily({
    required this.data,
    required this.message,
    required this.status,
  });

  factory ModelAbsensiDaily.fromJson(Map<String, dynamic> json) =>
      ModelAbsensiDaily(
        data: List<DataDaily>.from(
            json["data"].map((x) => DataDaily.fromJson(x))),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
        "status": status,
      };
}

class DataDaily {
  String month;
  String enter;
  String exit;

  DataDaily({
    required this.month,
    required this.enter,
    required this.exit,
  });

  factory DataDaily.fromJson(Map<String, dynamic> json) => DataDaily(
        month: json["month"],
        enter: json["enter"],
        exit: json["exit"],
      );

  Map<String, dynamic> toJson() => {
        "month": month,
        "enter": enter,
        "exit": exit,
      };
}
