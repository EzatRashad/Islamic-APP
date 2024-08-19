import '/cubit/get_azkar/state.dart';
import '/models/azkar_model.dart';
import '/modules/azkar/second_azkar/second_page.dart';
import '/widgets/loading.dart';
import '/widgets/my_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../cubit/get_azkar/cubit.dart';
import '../../cubit/mode_cubit/mood_cubit.dart';
import '../../widgets/error.dart';

class Azkar_home extends StatefulWidget {
  const Azkar_home({Key? key}) : super(key: key);

  @override
  State<Azkar_home> createState() => _Azkar_homeState();
}

class _Azkar_homeState extends State<Azkar_home> {
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CounterCubit, CounterStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return FutureBuilder(
          future: CounterCubit.get(context).getAzkarData(),
          builder:
              (BuildContext context, AsyncSnapshot<List<AzkarM>> snapshot) {
            if (snapshot.hasData) {
              return MyScaffold(
                title: "الأذكار",
                body: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: MoodCubit.get(context).isdark
                          ? const AssetImage("assets/images/bdark-web.png")
                          : const AssetImage("assets/images/blight-web.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    child: ListView.builder(
                      controller: _scrollController,
                      cacheExtent: 200.0,
                      physics: const BouncingScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 0.0),
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.only(top: 0.0),
                                  child: Text(
                                    snapshot.data![index].category!,
                                    textAlign: TextAlign.end,
                                    style:
                                        Theme.of(context).textTheme.titleMedium!,
                                  ),
                                ),
                                trailing: Image(
                                  image:
                                      const AssetImage('assets/images/sta.png'),
                                  height: 30.h,
                                  width: 30.w,
                                  fit: BoxFit.contain,
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Zkr(
                                          azkar:
                                              (snapshot.data?[index].array) ??
                                                  [],
                                          title:
                                              snapshot.data![index].category!,
                                        ),
                                      ));
                                },
                              ),
                              const Divider(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else if (snapshot.hasError) {
              print("Errrrorr ${snapshot.error.toString()}");
              return const ErrorW();
            } else {
              return const Center(child: Loading());
            }
          },
        );
      },
    );
  }
}
