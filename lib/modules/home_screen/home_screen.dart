import '/core/utiles/utiles.dart';
import '/modules/home_screen/components/aya.dart';
import '/modules/home_screen/components/banner.dart';
import '/modules/home_screen/components/items.dart';
import '/widgets/my_scaffold.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      mode: true,
      title: "السلام عليكم",
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeBanner(),
              25.ph,
              const Items(),
              10.ph,
               Aya(),
            ],
          ),
        ],
      ),
    );
  }
}
