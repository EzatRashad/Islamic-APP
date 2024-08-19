import '/core/utiles/utiles.dart';
import '/data/adhan_time_api.dart';
import '/data/local_data.dart';
import '/data/surah_api.dart';
import '/models/adhan_time.dart';
import '/models/suraModel.dart';
import '/models/verses_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/quran_api.dart';
import '../../models/quran_model.dart';
import 'get_quran_state.dart';

class GetQuranCubit extends Cubit<GetQuranState> {
  GetQuranCubit() : super(GetQuranInitial());
  static GetQuranCubit get(context) => BlocProvider.of(context);

  ChapterModel? cm;
  void getChapterData() async {
    emit(QuranLoadingStates());
    await DioHelper.getData(
      url: 'chapters',
      query: {
        'language': 'ar',
      },
    ).then((value) {
      cm = ChapterModel.fromJson(value.data);

      emit(QuranGetSuccessDataStates());
    }).catchError((error) {
      //print("ErrorChapter is : $error");
      emit(QuranGetErrorDataStates(error.toString()));
    });
  }

  VersesModel? versesModel;
  String? t;

  List v = [];
  getVersesData({required int chapterId, required int versesCount}) async {
    emit(VersesLoadingStates());
    final localSura = await DataManager.getData(chapterId.toString());
    if (localSura != null) {
      t = localSura;
      emit(VersesGetSuccessDataStates());
      return;
    }

    await DioHelper.getData(
      url: 'quran/verses/indopak',
      query: {'language': 'ar', 'chapter_number': chapterId},
    ).then((value) async {
      versesModel = VersesModel.fromJson(value.data);

      for (int i = 0; i < versesCount; i++) {
        final num = (i + 1).toString().toFarsi();
        v.add('${versesModel!.verses![i].textIndopak}\uFD3f$num\uFD3E');
      }
      t = v.join('');
      await DataManager.saveData(chapterId.toString(), t);
      emit(VersesGetSuccessDataStates());
    }).catchError((error) {
      //print("ErrorVerse is : $error");

      emit(VersesGetErrorDataStates(error.toString()));
    });
  }

  AdhanTimeModel? adhanTimeModel;
  void getAdhanTime() async {
    emit(GetAdhanTimeLoadingStates());
    await AdhanDioHelper.getData(
      url: '/05-08-2024',
      query: {
        'city': 'cairo',
        'country': 'egypt',
      },
    ).then((value) {
      adhanTimeModel = AdhanTimeModel.fromJson(value.data);
      print("---------------------- ${adhanTimeModel?.data?.timings?.asr}");

      emit(GetAdhanTimeSuccessDataStates());
    }).catchError((error) {
      //print("ErrorChapter is : $error");
      print("------------------------ ${error.toString()}");
      emit(GetAdhanTimeErrorDataStates(error.toString()));
    });
  }

  SurahModel? surahModel;

  List<Result> verses = [];

  getSurahData({required String translationKey, required int chapterId}) async {
    emit(VersesLoadingStates());

    await SurahDioHelper.getData(
      translationKey: translationKey,
      suraNumber: chapterId,
    ).then((value) async {
      surahModel = SurahModel.fromJson(value.data);
      emit(VersesGetSuccessDataStates());
    }).catchError((error) {
      print("--------------${error.toString()}-------");
      emit(VersesGetErrorDataStates(error.toString()));
    });
  }
}
