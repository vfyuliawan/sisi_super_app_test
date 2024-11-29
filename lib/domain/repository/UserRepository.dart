import 'dart:convert';

import 'package:sisi_super_app/core/api.dart';
import 'package:sisi_super_app/domain/models/model_absence_daily.dart';
import 'package:sisi_super_app/domain/models/model_absence_report.dart';
import 'package:sisi_super_app/domain/models/model_absence_response.dart';
import 'package:sisi_super_app/domain/models/model_detail_response.dart';
import 'package:http/http.dart' as http;
import 'package:sisi_super_app/domain/models/model_notificatioon_data.dart';
import 'package:sisi_super_app/domain/models/model_request_pengajuan.dart';
import 'package:sisi_super_app/domain/models/model_submit_pengajuan.dart';

class UserRepository {
  Future<ModelGetDetailResponse?> getUserDetail({required String id}) async {
    FetchInterfaceGet param = FetchInterfaceGet(
      path: "/$id",
      isAuthHeader: false,
    );
    http.Response response = await APIService.get(param);
    if (response.statusCode == 200) {
      ModelGetDetailResponse result =
          ModelGetDetailResponse.fromJson(jsonDecode(response.body));
      return result;
    } else {
      return null;
    }
  }

  Future<ModelGetAbsenceResponse?> getAbsence() async {
    FetchInterfaceGet param = FetchInterfaceGet(
      path: "/23d00513-83e8-4c66-bf80-9f724ca33010",
      isAuthHeader: false,
    );
    http.Response response = await APIService.get(param);
    if (response.statusCode == 200) {
      ModelGetAbsenceResponse result =
          ModelGetAbsenceResponse.fromJson(jsonDecode(response.body));
      return result;
    } else {
      return null;
    }
  }

  Future<ModelSubmitPengajuan?> submitPengajuan(
      ModelRequestPengajuan props) async {
    FetchInterfaceGet param = FetchInterfaceGet(
      path: "/6064a424-8fdb-4a52-aab5-11b490c91935",
      isAuthHeader: false,
    );
    http.Response response = await APIService.get(param);
    if (response.statusCode == 200) {
      ModelSubmitPengajuan result =
          ModelSubmitPengajuan.fromJson(jsonDecode(response.body));
      return result;
    } else {
      return null;
    }
  }

  Future<ModelAbsensiReport?> absenceReport() async {
    FetchInterfaceGet param = FetchInterfaceGet(
      path: "/f330f631-7582-40ec-9324-2ff98aab3c17",
      isAuthHeader: false,
    );
    http.Response response = await APIService.get(param);
    if (response.statusCode == 200) {
      ModelAbsensiReport result =
          ModelAbsensiReport.fromJson(jsonDecode(response.body));
      return result;
    } else {
      return null;
    }
  }

  Future<ModelAbsensiDaily?> absenceDaily() async {
    FetchInterfaceGet param = FetchInterfaceGet(
      path: "/ad8338f0-42ad-48e2-933d-fe7e60e67b9a",
      isAuthHeader: false,
    );
    http.Response response = await APIService.get(param);
    if (response.statusCode == 200) {
      ModelAbsensiDaily result =
          ModelAbsensiDaily.fromJson(jsonDecode(response.body));
      return result;
    } else {
      return null;
    }
  }

  Future<NotificationData?> notificationGet() async {
    FetchInterfaceGet param = FetchInterfaceGet(
      path: "/5156eb80-3678-495d-8cc4-07cad909bd76",
      isAuthHeader: false,
    );
    http.Response response = await APIService.get(param);
    if (response.statusCode == 200) {
      NotificationData result =
          NotificationData.fromJson(jsonDecode(response.body));
      return result;
    } else {
      return null;
    }
  }
}
