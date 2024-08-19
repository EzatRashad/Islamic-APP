import '/models/azkar_model.dart';
import '/modules/azkar/second_azkar/zekr_widget.dart';
import '/widgets/my_scaffold.dart';
import 'package:flutter/material.dart';

class Zkr extends StatefulWidget {
  const Zkr({Key? key, required this.azkar, required this.title})
      : super(key: key);
  final List<Array> azkar;
  final String title;
  @override
  State<Zkr> createState() => _ZkrState();
}

class _ZkrState extends State<Zkr> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      title: widget.title,
      body: ListView.builder(
        controller: _scrollController,
        cacheExtent: 500.0,
        physics: const BouncingScrollPhysics(),
        itemCount: widget.azkar.length,
        itemBuilder: (context, index) => ZekrWidget(
          zekr: widget.azkar[index],
        ),
      ),
    );
  }
}

