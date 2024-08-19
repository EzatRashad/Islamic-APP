import '/core/utiles/utiles.dart';
import '/data/adhan_time_api.dart';
import '/data/cashe_helper.dart';
import '/models/adhan_time.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'get_adhan_time_state.dart';

class GetAdhanTimeCubit extends Cubit<GetAdhanTimeState> {
  GetAdhanTimeCubit() : super(GetQuranInitial());

  static GetAdhanTimeCubit get(context) => BlocProvider.of(context);

  AdhanTimeModel? adhanTimeModel;
  List<String> adhanTimes = [];

  void getAdhanTime() async {
    emit(GetAdhanTimeLoadingStates());
    try {
      final response = await AdhanDioHelper.getData(
        url: '/${DateFormat('dd-MM-yyyy').format(DateTime.now())}',
        query: {
          'city': 'cairo',
          'country': 'egypt',
        },
      );

      adhanTimeModel = AdhanTimeModel.fromJson(response.data);
/*
      // Save each prayer time in shared preferences and add to the list
      _saveAndAddTime('hjri', "${adhanTimeModel?.data?.date?.hijri?.day.toString().toFarsi()} - ${adhanTimeModel?.data?.date?.hijri?.month?.ar} - ${adhanTimeModel?.data?.date?.hijri?.year.toString().toFarsi()}");
      _saveAndAddTime('fajr', adhanTimeModel?.data?.timings?.fajr);
      _saveAndAddTime('sunrise', adhanTimeModel?.data?.timings?.sunrise);
      _saveAndAddTime('dhuhr', adhanTimeModel?.data?.timings?.dhuhr);
      _saveAndAddTime('asr', adhanTimeModel?.data?.timings?.asr);
      _saveAndAddTime('sunset', adhanTimeModel?.data?.timings?.sunset);
      _saveAndAddTime('maghrib', adhanTimeModel?.data?.timings?.maghrib);
      _saveAndAddTime('isha', adhanTimeModel?.data?.timings?.isha);
      _saveAndAddTime('midnight', adhanTimeModel?.data?.timings?.midnight);
      _saveAndAddTime('firstthird', adhanTimeModel?.data?.timings?.firstthird);
      _saveAndAddTime('lastthird', adhanTimeModel?.data?.timings?.lastthird);
      */
      adhanTimes = [
        adhanTimeModel?.data?.timings?.fajr ?? '',
        adhanTimeModel?.data?.timings?.dhuhr ?? '',
        adhanTimeModel?.data?.timings?.asr ?? '',
        adhanTimeModel?.data?.timings?.maghrib ?? '',
        adhanTimeModel?.data?.timings?.isha ?? '',
      ];

      print("---------------------- ${adhanTimeModel?.data?.timings?.asr}");

      emit(GetAdhanTimeSuccessDataStates());
    } catch (error) {
      print("------------------------ ${error.toString()}");
      emit(GetAdhanTimeErrorDataStates(error.toString()));
    }
  }

  /*
  String hijri = CasheHelper.getData(key: 'hjri') ?? '';
  List<String> adhanTimes = [
    CasheHelper.getData(key: 'fajr') ?? '',
    CasheHelper.getData(key: 'dhuhr') ?? '',
    CasheHelper.getData(key: 'asr') ?? '',
    CasheHelper.getData(key: 'maghrib') ?? '',
    CasheHelper.getData(key: 'isha') ?? '',
  ];

  */

  List<String> labels = [
    'الفجر',
    'الظهر',
    'العصر',
    'المغرب',
    'العشاء',
  ];

  void _saveAndAddTime(String key, String? time) {
    if (time != null) {
      CasheHelper.saveData(key: key, value: time);
    }
  }
}
