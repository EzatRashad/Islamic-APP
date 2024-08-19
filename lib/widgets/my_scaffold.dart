import 'package:flutter/material.dart';

import '../cubit/mode_cubit/mood_cubit.dart';

class MyScaffold extends StatefulWidget {
  const MyScaffold(
      {super.key, required this.title, required this.body, this.mode = false});
  final String title;
  final Widget body;
  final bool mode;

  @override
  State<MyScaffold> createState() => _MyScaffoldState();
}

class _MyScaffoldState extends State<MyScaffold> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: FittedBox(
            fit: BoxFit.contain,
            child: Text(
              widget.title,
              
            ),
          ),
          centerTitle: true,
          actions: [
            widget.mode
                ? IconButton(
                    onPressed: () {
                      MoodCubit.get(context).changeMood();
                    },
                    icon: const Icon(
                      Icons.brightness_4_outlined,
                      size: 45,
                    ),
                  )
                : const Text(''),
            const SizedBox(
              width: 15,
            )
          ],
        ),
        body: widget.body,
      ),
    );
  }
}
