import 'package:flutter/material.dart';

import '../constants/colors.dart';

class KButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color textColor;
  final double? btnHeight;
  final double? btnWidth;
  final double? fontSize;

  const KButton({
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.textColor = Colors.white,
    this.btnHeight,
    this.btnWidth,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    var bgClr = KColors.primary;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: btnHeight,
        width: btnWidth,
        decoration: BoxDecoration(
          color: backgroundColor ?? bgClr,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              text,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: fontSize,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class KPrimaryButton extends KButton {
  const KPrimaryButton({
    required String text,
    required VoidCallback onPressed,
  }) : super(
          onPressed: onPressed,
          text: text,
          fontSize: 18,
          btnHeight: 50,
          btnWidth: double.infinity,
        );
}

class KSmallButton extends KButton {
  KSmallButton({
    required String text,
    required VoidCallback onPressed,
  }) : super(
          onPressed: onPressed,
          text: text,
          fontSize: 18,
          btnHeight: 40,
          textColor: Colors.red,
          backgroundColor: Colors.red.shade100,
        );
}
