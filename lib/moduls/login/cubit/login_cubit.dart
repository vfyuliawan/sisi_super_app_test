import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sisi_super_app/constant/constans.dart';
import 'package:sisi_super_app/domain/models/model_login_response.dart';
import 'package:sisi_super_app/domain/repository/LoginRepository.dart';
import 'package:sisi_super_app/utility/Utility.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  bool isHidePassword = true;
  bool checkSimpanSandi = false;

  void togglePasswordVisibility() {
    isHidePassword = !isHidePassword;
    // emit(LoginInitial());
  }

  void toogleSimpanSandi() {
    checkSimpanSandi = !checkSimpanSandi;
    // emit(LoginInitial());
  }

  Future<void> submit({required String email, required String password}) async {
    if (email.isEmpty || password.isEmpty) {
      emit(LoginFailed("Email and Password cannot be empty"));
      return;
    }

    emit(LoginIsLoading());
    try {
      if (email == "vicky@gmail.com" && password == "password123") {
        final ModelLoginResponse? res =
            await LoginRepository().login(email: email, password: password);
        if (res?.data != null) {
          print("token, ${res?.data?.id}");
          await Utility().savePref(Constans.bearerToken, res?.data!.id ?? "");
          print("dataId, ${res?.data?.id}");
          print("dataName, ${res?.data?.name}");
          emit(LoginSuccess(res?.data ??
              DataLogin(
                  email: res?.data?.email,
                  name: res?.data?.name,
                  token: res?.data?.token,
                  id: res?.data?.id)));
        }
      } else {
        emit(LoginFailed("Invalid email or password"));
      }
    } catch (e) {
      emit(LoginFailed("An error occurred: ${e.toString()}"));
    }
  }
}
