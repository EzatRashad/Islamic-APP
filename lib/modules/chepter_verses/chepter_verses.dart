import '/core/utiles/utiles.dart';
import '/modules/chepter_verses/verse_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../cubit/get_Quran/get_quran_cubit.dart';
import '../../cubit/get_Quran/get_quran_state.dart';
import '../../widgets/error.dart';
import '../../widgets/loading.dart';
import '../../widgets/my_scaffold.dart';

class ChapterVerses extends StatefulWidget {
  const ChapterVerses({
    super.key,
    required this.title,
    required this.id,
    required this.count,
    required this.notftha,
  });
  final String title;
  final int id;
  final int count;
  final bool notftha;

  @override
  State<ChapterVerses> createState() => _ChapterVersesState();
}

class _ChapterVersesState extends State<ChapterVerses> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetQuranCubit()
        ..getSurahData(translationKey: 'arabic_moyassar', chapterId: widget.id),
      child: BlocBuilder<GetQuranCubit, GetQuranState>(
        builder: (context, state) {
          var cubit = GetQuranCubit.get(context);

          return MyScaffold(
            title: widget.title,
            body: state is VersesLoadingStates
                ? const Loading()
                : state is VersesGetErrorDataStates
                    ? const ErrorW()
                    : Container(
                        padding: EdgeInsets.all(10.r),
                        width: double.infinity,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              if (widget.notftha)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image(
                                      image: const AssetImage(
                                          'assets/images/l.png'),
                                      width: 30.w,
                                      fit: BoxFit.cover,
                                    ),
                                    Text(
                                      "بِسۡمِ اللهِ الرَّحۡمٰنِ الرَّحِيۡمِ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge!
                                          .copyWith(fontFamily: "quranFont"),
                                    ),
                                    Image(
                                      image: const AssetImage(
                                          'assets/images/r.png'),
                                      width: 30.w,
                                      fit: BoxFit.cover,
                                    ),
                                  ],
                                ),
                              10.ph,
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) => VerseWidget(
                                  cubit: cubit,
                                  index: index,
                                ),
                                itemCount:
                                    cubit.surahModel?.result?.length ?? 0,
                              ),
                            ],
                          ),
                        ),
                      ),
          );
        },
      ),
    );
  }
}
