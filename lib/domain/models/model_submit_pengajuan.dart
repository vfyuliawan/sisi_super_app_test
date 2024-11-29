// To parse this JSON data, do
//
//     final modelSubmitPengajuan = modelSubmitPengajuanFromJson(jsonString);

import 'dart:convert';

ModelSubmitPengajuan modelSubmitPengajuanFromJson(String str) =>
    ModelSubmitPengajuan.fromJson(json.decode(str));

String modelSubmitPengajuanToJson(ModelSubmitPengajuan data) =>
    json.encode(data.toJson());

class ModelSubmitPengajuan {
  Data data;
  String message;
  int status;

  ModelSubmitPengajuan({
    required this.data,
    required this.message,
    required this.status,
  });

  factory ModelSubmitPengajuan.fromJson(Map<String, dynamic> json) =>
      ModelSubmitPengajuan(
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
  String status;

  Data({
    required this.message,
    required this.status,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
      };
}
