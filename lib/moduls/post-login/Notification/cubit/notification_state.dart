part of 'notification_cubit.dart';

@immutable
sealed class NotificationState {}

final class NotificationInitial extends NotificationState {}

final class NotificationIsLoading extends NotificationState {}

final class NotificationIsSuccess extends NotificationState {
  final List<DataNotif> listNotfi;

  NotificationIsSuccess(this.listNotfi);
}
