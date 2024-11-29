part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginSuccess extends LoginState {
  final DataLogin dataLogin;

  LoginSuccess(this.dataLogin);
}

final class LoginFailed extends LoginState {
  final String message;

  LoginFailed(this.message);
}

final class LoginIsLoading extends LoginState {}
