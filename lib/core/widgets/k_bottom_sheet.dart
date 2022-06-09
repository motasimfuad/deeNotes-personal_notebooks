import 'package:flutter/material.dart';
import 'package:notebooks/core/constants/constants.dart';

KBottomSheet({
  required BuildContext context,
  required Widget child,
  double? height,
  double? top,
}) {
  showModalBottomSheet(
    context: context,
    builder: (context) => SizedBox(
      height: height ?? 340.h,
      child: child,
    ),
    isDismissible: false,
    isScrollControlled: false,
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(top?.r ?? 20.r),
      ),
    ),
  );
}
