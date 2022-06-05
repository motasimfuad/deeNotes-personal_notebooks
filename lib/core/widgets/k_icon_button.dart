import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class KIconButton extends StatelessWidget {
  VoidCallback onPressed;
  double? size;
  Color? bgColor;
  Color? iconColor;
  IconData? icon;
  KIconButton({
    Key? key,
    required this.onPressed,
    this.size = 35,
    this.bgColor,
    this.iconColor,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var clr = Theme.of(context).buttonTheme.colorScheme?.primary;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: size?.h,
        width: size?.w,
        decoration: BoxDecoration(
          color: bgColor ?? Colors.grey.shade200,
          borderRadius: BorderRadius.all(
            Radius.circular(10.r),
          ),
        ),
        child: Icon(
          icon ?? Icons.arrow_back_ios_new_rounded,
          color: iconColor ?? clr,
          size: 18.w,
        ),
      ),
    );
  }
}
