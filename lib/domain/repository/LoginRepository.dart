import 'dart:convert';

import 'package:sisi_super_app/core/api.dart';
import 'package:sisi_super_app/domain/models/model_login_response.dart';
import 'package:http/http.dart' as http;

class LoginRepository {
  Future<ModelLoginResponse?> login(
      {required String email, required String password}) async {
    FetchInterfaceGet param = FetchInterfaceGet(
      path: "/4675c660-2bcf-448b-830a-5f611831b065",
      isAuthHeader: false,
    );
    http.Response response = await APIService.get(param);
    if (response.statusCode == 200) {
      ModelLoginResponse result =
          ModelLoginResponse.fromJson(jsonDecode(response.body));
      return result;
    } else {
      return null;
    }
  }
}
