import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sisi_super_app/domain/models/model_request_pengajuan.dart';
import 'package:sisi_super_app/domain/repository/UserRepository.dart';

part 'perizinan_state.dart';

class PerizinanCubit extends Cubit<PerizinanState> {
  bool isFormValid = false;

  PerizinanCubit() : super(PerizinanInitial());

  void validateForm(ModelRequestPengajuan form) {
    isFormValid = form.keperluan.isNotEmpty && form.tanggal.isNotEmpty;
    print("$isFormValid ${form.toMap()} isValid");
    emit(isFormValid ? PerizinanFormValid() : PerizinanFormInvalid());
  }

  void submitPengajuan(ModelRequestPengajuan body) async {
    emit(PerizinanIsLoading());
    final res = await UserRepository().submitPengajuan(body);
    if (res != null) {
      emit(PerizinanInPogress(1, res.data.message));
    }
  }
}
