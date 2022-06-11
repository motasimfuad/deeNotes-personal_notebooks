import 'package:flutter/material.dart';
import 'package:notebooks/core/constants/constants.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(50.w),
        child: Center(
          child: Image.asset(
            'assets/images/app/deeNotes_logo_icon.png',
            fit: BoxFit.cover,
            width: 80.w,
          ),
        ),
      ),
    );
  }
}
