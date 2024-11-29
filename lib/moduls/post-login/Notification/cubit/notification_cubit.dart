import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sisi_super_app/domain/models/model_notificatioon_data.dart';
import 'package:sisi_super_app/domain/repository/UserRepository.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  Future<void> getDataNotif() async {
    emit(NotificationIsLoading());
    final res = await UserRepository().notificationGet();
    if (res != null) {
      emit(NotificationIsSuccess(res.data));
    }
  }
}
