import 'package:flutter/material.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    Key? key,
    required this.child,
    this.onClicked,
    this.background,
    this.buttonShape,
    this.padding,
  }) : super(key: key);
  final VoidCallback? onClicked;
  final Widget child;
  final Color? background;
  final OutlinedBorder? buttonShape;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClicked,
      child: child,
      style: ElevatedButton.styleFrom(
        padding: padding,
        // animationDuration: AppConstants.animationDuration,
        // shape: buttonShape ?? AppStyles.roundedRectangleBorder12,
        // primary: AppColors.LIGHT_GREEN,
        elevation: 1,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        enableFeedback: true,
        // textStyle: AppTextStyles.regular_14,
      ),
    );
  }
}
