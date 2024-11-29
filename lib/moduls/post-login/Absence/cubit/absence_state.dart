part of 'absence_cubit.dart';

@immutable
sealed class AbsenceState {}

final class AbsenceInitial extends AbsenceState {}

final class AbsenceIsLoading extends AbsenceState {}

final class AbsenceMonthly extends AbsenceState {
  final Month month;
  final List<DataDaily> daily;

  AbsenceMonthly(this.month, this.daily);
}
