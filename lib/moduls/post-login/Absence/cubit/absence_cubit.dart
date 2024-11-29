import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sisi_super_app/domain/models/model_absence_daily.dart';
import 'package:sisi_super_app/domain/models/model_absence_report.dart';
import 'package:sisi_super_app/domain/repository/UserRepository.dart';

part 'absence_state.dart';

class AbsenceCubit extends Cubit<AbsenceState> {
  AbsenceCubit() : super(AbsenceInitial());

  Future<void> getAbsence(String month) async {
    emit(AbsenceIsLoading());
    try {
      final res = await UserRepository().absenceReport();
      if (res != null) {
        final resDaily = await UserRepository().absenceDaily();
        if (resDaily != null) {
          switch (month.toLowerCase()) {
            case 'february':
              emit(AbsenceMonthly(res.data.february, resDaily.data));
              break;
            case 'march':
              emit(AbsenceMonthly(res.data.march, resDaily.data));
              break;
            case 'april':
              emit(AbsenceMonthly(res.data.april, resDaily.data));
              break;
            default:
              emit(AbsenceMonthly(res.data.january, resDaily.data));
              break;
          }
        }
      }
    } catch (e) {}
  }
}
