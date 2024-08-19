import '/core/themes/colors.dart';
import '/core/utiles/utiles.dart';
import '/cubit/get_Quran/get_quran_cubit.dart';
import '/modules/chepter_verses/tafsser.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerseWidget extends StatelessWidget {
  const VerseWidget({super.key, required this.cubit, required this.index});

  final GetQuranCubit cubit;
  final int index;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        showLangBottomSheet(context);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 3),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child:  IconButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(
                    text:
                        "${cubit.surahModel?.result![index].arabicText} "));
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('تم النسخ بنجاح'),
                  ),
                );
              },
              icon: const Icon(
                Icons.copy_rounded,
                color: AppColors.primaryLight,
              ),
            ), 
            ),
          
            
            
            Text(
              "${cubit.surahModel?.result![index].arabicText} ",
              textAlign: TextAlign.right,
                          textDirection:TextDirection.rtl,

              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontFamily: "qalam",
                    fontSize: 25.sp,
                    height: 1.5.h,
                  ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Text(
              "\uFD3E ${(index + 1).toString().toFarsi()} \uFD3f ",
              textAlign: TextAlign.right,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontSize: 23.sp,
                    height: 1.5.h,
                  ),
            ),
            )
            
          ],
        ),
      ),
    );
  }
  void showLangBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (context) =>  Tafsser(cubit:cubit, index: index ,),
    );
  }
}
