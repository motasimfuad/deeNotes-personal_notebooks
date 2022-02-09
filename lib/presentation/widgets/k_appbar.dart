import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:notebooks/presentation/widgets/k_icon_button.dart';

class KAppbar extends StatelessWidget {
  String label;
  BuildContext context;
  VoidCallback onPressed;
  IconData? actionIcon;
  VoidCallback? actionOnPressed;
  Color? textColor;
  Color? iconBgColor;
  Color? iconColor;
  KAppbar({
    Key? key,
    required this.label,
    required this.context,
    required this.onPressed,
    this.actionIcon,
    this.actionOnPressed,
    this.textColor,
    this.iconBgColor,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                KIconButton(
                  onPressed: onPressed,
                  bgColor: iconBgColor,
                  iconColor: iconColor,
                ),
                SizedBox(width: 15.w),
                Text(
                  label,
                  style: TextStyle(
                    color: textColor ??
                        Theme.of(context).textTheme.bodyText1?.color,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            actionIcon != null
                ? KIconButton(
                    bgColor: iconBgColor,
                    iconColor: iconColor,
                    icon: actionIcon,
                    onPressed: actionOnPressed ?? () {},
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
