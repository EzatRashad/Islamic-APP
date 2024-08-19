import '/core/utiles/utiles.dart';
import '/modules/azkar/azkar_Screen.dart';
import '/modules/chapters_names/chapters_names.dart';
import '/modules/counter_Screen/counter_screen.dart';
import '/modules/home_screen/components/item_Widget.dart';
import '/modules/qiblah/qiblah_main.dart';
import '/modules/quran/quran.dart';
import 'package:flutter/material.dart';

class Items extends StatelessWidget {
  const Items({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 130,
      width: double.infinity,
      child: ListView(
        scrollDirection: Axis.horizontal,
        
        children: [
          const Item(
                  image: "assets/images/koran.png",
                  text: "القران الكريم",
                  screen: ChaptersNames()),
              7.pw,
              const Item(
                  image: "assets/images/praying.png",
                  text: "الاذكار",
                  screen: Azkar_home()),
                  7.pw,
          const Item(
                  image: "assets/images/qibla.png",
                  text: "القبله",
                  screen: Qiblah()),
              7.pw,
              const Item(
                  image: "assets/images/beads.png",
                  text: "السبحه",
                  screen: Count()),
                  7.pw,

        ],
      ),
    );
  }
}
