import 'package:islamy/core/utiles/utiles.dart';

import '/core/themes/colors.dart';
import '/cubit/get_adhan_time.dart/get_adhan_time_cubit.dart';
import '/cubit/get_adhan_time.dart/get_adhan_time_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeBanner extends StatefulWidget {
  const HomeBanner({super.key});

  @override
  _HomeBannerState createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetAdhanTimeCubit()..getAdhanTime(),
      child: BlocConsumer<GetAdhanTimeCubit, GetAdhanTimeState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = GetAdhanTimeCubit.get(context);

          return Container(
            width: double.infinity,
            height: 230.h,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/images/time.jpg",
                ),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            child: state is GetAdhanTimeLoadingStates
                ? const Center(
                    child: CircularProgressIndicator(
                    color: AppColors.white,
                  ))
                : state is GetAdhanTimeSuccessDataStates
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "${cubit.adhanTimeModel?.data?.date?.hijri?.day.toString().toFarsi()} - ${cubit.adhanTimeModel?.data?.date?.hijri?.month?.ar} - ${cubit.adhanTimeModel?.data?.date?.hijri?.year.toString().toFarsi()}",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(color: AppColors.white),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            height: 80.h,
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: ListView.builder(
                              itemCount: 5, // Number of prayer times
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 80.h,
                                    width: 60.w,
                                    decoration: BoxDecoration(
                                      color: AppColors.white.withOpacity(.3),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text(
                                        '${cubit.labels[index]}\n${cubit.adhanTimes[index]}',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall
                                            ?.copyWith(color: AppColors.white),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      )
                    : const Center(
                        child: Text(
                          'Failed to load Adhan times',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
          );
        },
      ),
    );
  }
}
