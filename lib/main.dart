import 'package:shared_preferences/shared_preferences.dart';

import '/core/themes/theme.dart';
import '/cubit/get_azkar/cubit.dart';
import '/cubit/mode_cubit/mood_cubit.dart';
import '/cubit/mode_cubit/state.dart';
import '/data/adhan_time_api.dart';
import '/data/local_data.dart';
import '/data/surah_api.dart';
import '/modules/splash_sccreen/splash_sccreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'cubit/blockObserver.dart';
import 'data/cashe.dart';
import 'data/cashe_helper.dart';
import 'data/quran_api.dart';
 
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  SurahDioHelper.init();
   await CasheHelper.init();
  AdhanDioHelper.init();
  await CashHelper.init();
  bool? isdark =false; //CashHelper.getData(key: 'isdark');
   runApp(MyApp(isdark));
}

class MyApp extends StatelessWidget {
  final bool? isdark;
  const MyApp(this.isdark, {super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => CounterCubit()),
          BlocProvider(
            create: (context) => MoodCubit()..changeMood(fromshared: isdark),
          ),
        ],
        child: BlocConsumer<MoodCubit, ModeStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return ScreenUtilInit(
              designSize: const Size(360, 690),
              minTextAdapt: true,
              splitScreenMode: true,
              // Use builder only if you need to use library outside ScreenUtilInit context
              builder: (_, child) {
                return MaterialApp(
                    debugShowCheckedModeBanner: false,
                    theme: MyTheme.lightTheme,
                    darkTheme: MyTheme.darkTheme,
                    themeMode: MoodCubit.get(context).isdark
                        ? ThemeMode.dark
                        : ThemeMode.light,
                    home: const SplasgScreen());
              },
            );
          },
        ));
  }
}
