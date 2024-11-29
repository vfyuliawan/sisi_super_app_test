// To parse this JSON data, do
//
//     final modelGetDetailResponse = modelGetDetailResponseFromJson(jsonString);

import 'dart:convert';

ModelGetDetailResponse modelGetDetailResponseFromJson(String str) =>
    ModelGetDetailResponse.fromJson(json.decode(str));

String modelGetDetailResponseToJson(ModelGetDetailResponse data) =>
    json.encode(data.toJson());

class ModelGetDetailResponse {
  DataUser data;
  String message;
  int status;

  ModelGetDetailResponse({
    required this.data,
    required this.message,
    required this.status,
  });

  factory ModelGetDetailResponse.fromJson(Map<String, dynamic> json) =>
      ModelGetDetailResponse(
        data: DataUser.fromJson(json["data"]),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "message": message,
        "status": status,
      };
}

class DataUser {
  String id;
  String name;
  String email;
  String position;

  DataUser({
    required this.id,
    required this.name,
    required this.email,
    required this.position,
  });

  factory DataUser.fromJson(Map<String, dynamic> json) => DataUser(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        position: json["position"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "position": position,
      };
}
