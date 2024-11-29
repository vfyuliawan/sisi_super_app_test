part of 'perizinan_cubit.dart';

@immutable
sealed class PerizinanState {}

final class PerizinanInitial extends PerizinanState {}

class PerizinanFormValid extends PerizinanState {}

class PerizinanFormInvalid extends PerizinanState {}

final class PerizinanIsLoading extends PerizinanState {}

final class PerizinanInPogress extends PerizinanState {
  final int isActive;
  final String message;

  PerizinanInPogress(this.isActive, this.message);
}

final class PerizinanWaitingApproval extends PerizinanState {
  final String message;

  PerizinanWaitingApproval(this.message);
}
