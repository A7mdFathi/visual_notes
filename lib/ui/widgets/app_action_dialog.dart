import 'package:flutter/material.dart';

class AppActionDialog extends StatelessWidget {
  const AppActionDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Dialog(
      insetAnimationCurve: Curves.easeOut,
    );
  }
}
