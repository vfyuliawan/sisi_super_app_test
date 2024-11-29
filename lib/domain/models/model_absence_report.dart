// To parse this JSON data, do
//
//     final modelAbsensiReport = modelAbsensiReportFromJson(jsonString);

import 'dart:convert';

ModelAbsensiReport modelAbsensiReportFromJson(String str) =>
    ModelAbsensiReport.fromJson(json.decode(str));

String modelAbsensiReportToJson(ModelAbsensiReport data) =>
    json.encode(data.toJson());

class ModelAbsensiReport {
  Data data;
  String message;
  int status;

  ModelAbsensiReport({
    required this.data,
    required this.message,
    required this.status,
  });

  factory ModelAbsensiReport.fromJson(Map<String, dynamic> json) =>
      ModelAbsensiReport(
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
  Month january;
  Month february;
  Month march;
  Month april;

  Data({
    required this.january,
    required this.february,
    required this.march,
    required this.april,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        january: Month.fromJson(json["january"]),
        february: Month.fromJson(json["february"]),
        march: Month.fromJson(json["march"]),
        april: Month.fromJson(json["april"]),
      );

  Map<String, dynamic> toJson() => {
        "january": january.toJson(),
        "february": february.toJson(),
        "march": march.toJson(),
        "april": april.toJson(),
      };
}

class Month {
  int normal;
  int wfh;
  int cuti;
  int overtime;
  int spd;
  int terlambat;

  Month({
    required this.normal,
    required this.wfh,
    required this.cuti,
    required this.overtime,
    required this.spd,
    required this.terlambat,
  });

  factory Month.fromJson(Map<String, dynamic> json) => Month(
        normal: json["normal"],
        wfh: json["wfh"],
        cuti: json["cuti"],
        overtime: json["overtime"],
        spd: json["spd"],
        terlambat: json["terlambat"],
      );

  Map<String, dynamic> toJson() => {
        "normal": normal,
        "wfh": wfh,
        "cuti": cuti,
        "overtime": overtime,
        "spd": spd,
        "terlambat": terlambat,
      };
}
