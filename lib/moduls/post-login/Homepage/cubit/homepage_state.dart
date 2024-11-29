part of 'homepage_cubit.dart';

@immutable
sealed class HomepageState {}

final class HomepageInitial extends HomepageState {}

final class HomePageIsLoading extends HomepageState {}

final class HomePageIsFailed extends HomepageState {
  final String message;

  HomePageIsFailed(this.message);
}

final class HomepageIsSuccess extends HomepageState {
  final DataUser? dataUser;

  HomepageIsSuccess(this.dataUser);
}

final class HomePageIsCheckinPhoto extends HomepageState {
  final String photo;
  final String message;

  HomePageIsCheckinPhoto(this.photo, this.message);
}
