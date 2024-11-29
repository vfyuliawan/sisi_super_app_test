import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sisi_super_app/domain/models/model_detail_response.dart';
import 'package:sisi_super_app/domain/repository/UserRepository.dart';
import 'package:sisi_super_app/utility/Utility.dart';

part 'homepage_state.dart';

class HomepageCubit extends Cubit<HomepageState> {
  HomepageCubit() : super(HomepageInitial());
  String? idDetail;
  int selectedIndex = 0;

  Future<void> getDetailUser(String id) async {
    idDetail = id;
    emit(HomePageIsLoading());
    ModelGetDetailResponse? res = await UserRepository().getUserDetail(id: id);
    if (res != null) {
      emit(HomepageIsSuccess(res.data));
    } else {
      emit(HomePageIsFailed("failed Get Data"));
    }
  }

  void submitPhoto(String photo) async {
    final res = await UserRepository().getAbsence();
    if (res != null) {
      emit(HomePageIsCheckinPhoto(
        photo,
        res.data.message,
      ));
    }
  }

  Future<void> submitSuccess(String imageBase64) async {
    getDetailUser(idDetail!);
  }

  Future<void> downloadImage(String imageBase64) async {
    String downloadName = DateTime.now().toString();
    await Utility().downloadBase64Image(imageBase64, downloadName);
  }
}
