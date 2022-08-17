import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:notebooks/core/constants/constants.dart';
import 'package:notebooks/core/router/app_router.dart';
import 'package:notebooks/features/settings/presentation/bloc/settings_bloc.dart';

class IntroductionScreenPage extends StatefulWidget {
  const IntroductionScreenPage({Key? key}) : super(key: key);

  @override
  State<IntroductionScreenPage> createState() => _IntroductionScreenPageState();
}

class _IntroductionScreenPageState extends State<IntroductionScreenPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  Widget _buildLottie(String assetName, [double? width]) {
    return Lottie.asset(
      'assets/$assetName',
      fit: BoxFit.cover,
      width: width,
    );
  }

  void _onIntroEnd(context) {
    BlocProvider.of<SettingsBloc>(context).add(const MakeIntroWatchedEvent());
    router.goNamed(AppRouters.homePage);
  }

  @override
  Widget build(BuildContext context) {
    var bodyStyle = TextStyle(fontSize: 19.sp);

    var pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.symmetric(horizontal: 20.w),
      pageColor: Colors.white,
      bodyAlignment: Alignment.topCenter,
      imageAlignment: Alignment.center,
      titlePadding: EdgeInsets.only(top: 0, bottom: 16.h),
      imagePadding: EdgeInsets.only(
        top: 50.h,
        bottom: 20.h,
        left: 30.w,
        right: 30.w,
      ),
      imageFlex: 3,
    );

    return Scaffold(
        body: SafeArea(
      child: IntroductionScreen(
        key: introKey,
        globalBackgroundColor: Colors.white,
        pages: [
          PageViewModel(
            title: Strings.appTitle,
            body:
                "It's a simple, yet powerful, app that\nallows you to create and share your\nown personal notes.\n\nA great way to keep track of your\nideas, thoughts, and more.",
            image: _buildLottie('animations/onboarding-first.json', 200.w),
            decoration: pageDecoration.copyWith(
              imagePadding: EdgeInsets.symmetric(
                horizontal: 30.w,
                vertical: 50.h,
              ),
              imageAlignment: Alignment.bottomCenter,
              titleTextStyle: TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.w700,
                color: KColors.primary,
              ),
              imageFlex: 3,
              bodyFlex: 2,
            ),
          ),
          PageViewModel(
            title: "Create Notebooks",
            body: "You can create different notebooks to\norganize your notes.",
            image: _buildLottie('animations/onboarding-notebooks.json'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Create Notes",
            body:
                "Create and customize notes with beautiful colors as you wish.",
            image: _buildLottie('animations/onboarding-note.json'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Safe and Secure",
            body:
                "Your notes are stored in your device.\nNo need to worry about losing them.\nSo, your notes are safe with you.",
            image: _buildLottie('animations/onboarding-safe.json'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Let's get started!",
            body: "Welcome to ${Strings.appTitle}.",
            image: _buildLottie('animations/onboarding-done.json'),
            decoration: pageDecoration,
          ),
        ],
        onDone: () => _onIntroEnd(context),
        //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
        showSkipButton: false,
        skipOrBackFlex: 0,
        nextFlex: 0,
        showBackButton: true,
        nextStyle: const ButtonStyle().copyWith(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
        ),
        backStyle: const ButtonStyle().copyWith(
          overlayColor: MaterialStateProperty.all(Colors.transparent),
        ),

        //rtl: true, // Display as right-to-left
        back: const Icon(Icons.arrow_back_ios_rounded),
        skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
        next: const Icon(Icons.arrow_forward_ios_rounded),
        done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
        // scrollPhysics: const BouncingScrollPhysics(),
        curve: Curves.fastLinearToSlowEaseIn,
        controlsMargin: EdgeInsets.symmetric(
          horizontal: 25.w,
          vertical: 20.h,
        ),
        controlsPadding: kIsWeb
            ? EdgeInsets.all(12.w)
            : EdgeInsets.fromLTRB(8.w, 4.h, 8.w, 4.h),
        dotsDecorator: DotsDecorator(
          size: Size(10.w, 10.w),
          color: Colors.grey.shade300,
          activeSize: Size(22.w, 10.h),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.w)),
          ),
        ),
        dotsContainerDecorator: ShapeDecoration(
          color: Colors.grey.shade100,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.w)),
          ),
        ),
      ),
    ));
  }
}
