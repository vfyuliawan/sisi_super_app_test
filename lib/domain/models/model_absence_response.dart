// To parse this JSON data, do
//
//     final modelGetAbsenceResponse = modelGetAbsenceResponseFromJson(jsonString);

import 'dart:convert';

ModelGetAbsenceResponse modelGetAbsenceResponseFromJson(String str) =>
    ModelGetAbsenceResponse.fromJson(json.decode(str));

String modelGetAbsenceResponseToJson(ModelGetAbsenceResponse data) =>
    json.encode(data.toJson());

class ModelGetAbsenceResponse {
  Data data;
  String message;
  int status;

  ModelGetAbsenceResponse({
    required this.data,
    required this.message,
    required this.status,
  });

  factory ModelGetAbsenceResponse.fromJson(Map<String, dynamic> json) =>
      ModelGetAbsenceResponse(
        data: Data.fromJson(json["data"]),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
        "status": status,
      };
}

class Data {
  String message;
  String date;

  Data({
    required this.message,
    required this.date,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: json["message"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "date": date,
      };
}
