// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:platform/platform.dart';
import 'package:sisi_super_app/constant/constans.dart';
import 'package:sisi_super_app/core/ErrorHandle.dart';
import 'package:sisi_super_app/utility/Utility.dart';

class APIService {
  static int timeOut = 60000;
  // static String baseUrl = "http://localhost:8000";
  static String baseUrl = "https://mocki.io/v1";
  // static String baseUrl = "https://tight-kora-nviteme-3bdf504d.koyeb.app";
  static String iosVersion = "0.0.1";
  static String androidVersion = "0.0.1";

  static appVersion(Platform platform) {
    return platform.isIOS ? iosVersion : androidVersion;
  }

  static Future<Map<String, String>> header(bool? isAuthHeader) async {
    // const String token =
    //     "Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJnYWxhbmciLCJpYXQiOjE3MjAxNjIyNDcsImV4cCI6MTcyMDE5ODI0N30.JnWyYcktn0IPZvu-dbxSxIdqt8qc2zPP0xdVCzMBS6c";
    final String token =
        await Utility().loadPref(key: Constans.bearerToken) ?? "";
    final String appVersionData = appVersion(LocalPlatform());
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    String deviceId, osVersion, model, brand;

    if (LocalPlatform().isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor ?? "";
      osVersion = iosInfo.systemVersion;
      model = iosInfo.model;
      brand = 'Apple';
    } else {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

      deviceId = androidInfo.id;
      osVersion = androidInfo.version.release;
      model = androidInfo.model;
      brand = androidInfo.brand;
    }

    return {
      'Content-Type': 'application/json',
      'accept': '*/*',
      'channel': 'MOB',
      'device-id': deviceId,
      'device-os': LocalPlatform().isIOS ? 'ios' : 'android',
      'device-model': model,
      'device-brand': brand,
      'app-version': appVersionData,
      'os-version': osVersion,
      'language': 'IDN',
      'latitude': '0.0',
      'longitude': '0.0',
      'Authorization': isAuthHeader == false ? "" : token,
    };
  }

  static Future<http.Response> requestData(
    http.Request request,
    bool isErrorCreate,
    Function? errorMessage,
    bool? dismissable,
  ) async {
    try {
      final response = await http.Response.fromStream(await request.send());
      if (kDebugMode) {
        print('METHOD : ${request.method}');
        print('URL : ${request.url}');
        print('REQUEST HEADER : ${request.headers}');
        print('REQUEST BODY : ${request.body}');
        print('RESPONSE STATUS : ${response.statusCode}');
        print('RESPONSE HEADER : ${response.headers}');
        print('RESPONSE BODY : ${response.body}');
      }

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['code'] == '00' ||
            responseData['code'] == '4301' ||
            responseData['code'] == '5101') {
          return response;
        }
        return response;
      } else if (response.statusCode == 201) {
        return response;
      } else if (response.statusCode == 303) {
        errorHandler.errorResponse(
            message: json.decode(response.body)["messageError"] ?? "",
            dismissable: dismissable,
            errorMessage: json.decode(response.body)["messageError"] ?? "",
            title: "Error");
      } else if (response.statusCode == 400) {
        errorHandler.errorResponse(
            message: json.decode(response.body)["messageError"] ?? "",
            dismissable: dismissable,
            errorMessage: json.decode(response.body)["messageError"] ?? "",
            title: "Error");
      } else if (response.statusCode == 401) {
        errorHandler.errorResponse(
            message: json.decode(response.body)["messageError"] ?? "",
            dismissable: dismissable,
            errorMessage: json.decode(response.body)["messageError"] ?? "",
            title: "Error");
      } else if (response.statusCode == 403) {
        errorHandler.errorResponse(
            message: json.decode(response.body)["messageError"] ?? "",
            dismissable: dismissable,
            errorMessage: json.decode(response.body)["messageError"] ?? "",
            title: "Error");
      } else if (response.statusCode == 404 ||
          response.statusCode == 413 ||
          response.statusCode == 422 ||
          response.statusCode == 409) {
        errorHandler.errorResponse(
            message: json.decode(response.body)["messageError"] ?? "",
            dismissable: dismissable,
            errorMessage: json.decode(response.body)["messageError"],
            title: "Error");
      } else if (response.statusCode == 500) {
        errorHandler.errorResponse(
            message: json.decode(response.body)["messageError"] ?? "",
            dismissable: dismissable,
            errorMessage: json.decode(response.body)["messageError"],
            title: "Error");
      }
      return response;
    } catch (e) {
      errorHandler.errorResponse(
          message: "",
          dismissable: dismissable,
          errorMessage: e.toString(),
          title: "Error");
      print('Error request: $e');
      return http.Response('Error: $e', 500);
    }
  }

  static Future<http.Response> post(FetchInterface props) async {
    final headers = await header(props.isAuthHeader);
    final request = http.Request('POST', Uri.parse(baseUrl + props.path))
      ..headers.addAll(headers)
      ..body = json.encode(props.reqBody);
    return requestData(request, props.isErrorCreate ?? false,
        props.errorMessage, props.dismissable);
  }

  static Future<http.Response> get(FetchInterfaceGet props) async {
    final headers = await header(props.isAuthHeader);
    final request = http.Request('GET', Uri.parse(baseUrl + props.path))
      ..headers.addAll(headers);
    return requestData(request, props.isError ?? false, null, null);
  }

  static Future<http.Response> put(FetchInterface props) async {
    final headers = await header(props.isAuthHeader);
    final request = http.Request('PUT', Uri.parse(baseUrl + props.path))
      ..headers.addAll(headers)
      ..body = json.encode(props.reqBody);
    return requestData(
        request, props.isErrorCreate ?? false, null, props.dismissable);
  }

  Future<http.Response> patch(FetchInterface props) async {
    final headers = await header(props.isAuthHeader);
    final request = http.Request('PATCH', Uri.parse(baseUrl + props.path))
      ..headers.addAll(headers)
      ..body = json.encode(props.reqBody);
    return requestData(
        request, props.isErrorCreate ?? false, null, props.dismissable);
  }

  Future<http.Response> deleted(FetchInterface props) async {
    final headers = await header(props.isAuthHeader);
    final request = http.Request('DELETE', Uri.parse(baseUrl + props.path))
      ..headers.addAll(headers)
      ..body = json.encode(props.reqBody);
    return requestData(
        request, props.isErrorCreate ?? false, null, props.dismissable);
  }
}

class FetchInterface {
  final String path;
  final bool isAuthHeader;
  final bool? isErrorCreate;
  final bool? dismissable;
  final Map<String, dynamic> reqBody;
  final Function? errorMessage;

  FetchInterface({
    required this.path,
    required this.isAuthHeader,
    this.isErrorCreate,
    this.dismissable,
    required this.reqBody,
    this.errorMessage,
  });
}

class FetchInterfaceGet {
  final String path;
  final bool isAuthHeader;
  final Map<String, dynamic>? params;
  final bool? isError;

  FetchInterfaceGet({
    required this.path,
    required this.isAuthHeader,
    this.params,
    this.isError,
  });
}
