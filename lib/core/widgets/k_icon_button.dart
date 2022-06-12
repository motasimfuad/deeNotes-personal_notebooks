import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum IconType { topNav, bottomBar }

// ignore: must_be_immutable
class KIconButton extends StatelessWidget {
  VoidCallback onPressed;
  double? size;
  Color? bgColor;
  Color? iconColor;
  IconData? icon;
  IconType iconType;
  String? tooltip;
  KIconButton({
    Key? key,
    required this.onPressed,
    this.size = 35,
    this.bgColor,
    this.iconColor,
    this.icon,
    this.tooltip,
    this.iconType = IconType.topNav,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var clr = Theme.of(context).buttonTheme.colorScheme?.primary;

    return GestureDetector(
        onTap: onPressed,
        child: Tooltip(
          triggerMode: TooltipTriggerMode.longPress,
          message: tooltip ?? '',
          decoration: BoxDecoration(
            color: iconColor,
            borderRadius: BorderRadius.circular(10.r),
          ),
          enableFeedback: true,
          child: _buildIconButtonBody(clr),
        ));
  }

  Container _buildIconButtonBody(Color? clr) {
    return Container(
      height: size?.h,
      width: size?.w,
      decoration: BoxDecoration(
        // color: bgColor ?? Colors.grey.shade200,
        color: _iconBgColor(iconType, iconColor, bgColor: bgColor),
        borderRadius: BorderRadius.all(
          Radius.circular(10.r),
        ),
      ),
      child: Icon(
        icon ?? Icons.arrow_back_ios_new_rounded,
        color: iconColor ?? clr,
        size: _buildIconSize(iconType),
      ),
    );
  }
}

_buildIconSize(IconType iconType) {
  switch (iconType) {
    case IconType.topNav:
      return 18.w;
    case IconType.bottomBar:
      return 23.w;
    default:
      18.w;
  }
}

Color? _iconBgColor(IconType iconType, Color? iconColor, {Color? bgColor}) {
  switch (iconType) {
    case IconType.topNav:
      return bgColor ?? Colors.grey.shade100;
    case IconType.bottomBar:
      return iconColor?.withOpacity(0.1) ?? Colors.grey.shade100;

    default:
      return Colors.grey.shade100;
  }
}
