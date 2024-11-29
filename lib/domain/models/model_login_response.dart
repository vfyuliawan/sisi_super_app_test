// To parse this JSON data, do
//
//     final modelLoginResponse = modelLoginResponseFromJson(jsonString);

import 'dart:convert';

ModelLoginResponse modelLoginResponseFromJson(String str) =>
    ModelLoginResponse.fromJson(json.decode(str));

String modelLoginResponseToJson(ModelLoginResponse data) =>
    json.encode(data.toJson());

class ModelLoginResponse {
  DataLogin? data;
  String? message;
  int? status;

  ModelLoginResponse({
    this.data,
    this.message,
    this.status,
  });

  factory ModelLoginResponse.fromJson(Map<String, dynamic> json) =>
      ModelLoginResponse(
        data: DataLogin.fromJson(json["data"]),
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data?.toJson(),
        "message": message,
        "status": status,
      };
}

class DataLogin {
  String? id;
  String? name;
  String? email;
  String? token;

  DataLogin({
    this.id,
    this.name,
    this.email,
    this.token,
  });

  factory DataLogin.fromJson(Map<String, dynamic> json) => DataLogin(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "token": token,
      };
}
