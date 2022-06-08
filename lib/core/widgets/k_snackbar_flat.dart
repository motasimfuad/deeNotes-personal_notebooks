import 'package:flutter/material.dart';

import '../constants/colors.dart';

KSnackbarFlat({
  required BuildContext context,
  required String? message,
  Color? bgColor,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(milliseconds: 700),
      backgroundColor: bgColor ?? KColors.primary,
      content: Text(message ?? ''),
    ),
  );
}
