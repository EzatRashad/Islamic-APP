import 'dart:io';

import '/widgets/loading.dart';
import 'package:flutter/cupertino.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final widget =
        (Platform.isAndroid) ? const Loading() : const CupertinoActivityIndicator();
    return Container(
      alignment: Alignment.center,
      child: widget,
    );
  }
}
