import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KFab extends StatelessWidget {
  IconData? icon;
  String label;
  VoidCallback onPressed;
  KFab({
    Key? key,
    this.icon,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      elevation: 3.5,
      onPressed: onPressed,
      tooltip: label,
      icon: icon != null ? Icon(icon) : const SizedBox.shrink(),
      label: Text(label),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(13.r),
        ),
      ),
    );
  }
}