import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:notebooks/core/constants/constants.dart';
import 'package:notebooks/features/notebook/presentation/pages/all_notebooks_page.dart';

class IntroductionScreenPage extends StatefulWidget {
  const IntroductionScreenPage({Key? key}) : super(key: key);

  @override
  State<IntroductionScreenPage> createState() => _IntroductionScreenPageState();
}

class _IntroductionScreenPageState extends State<IntroductionScreenPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  Widget _buildImage(
    String assetName,
    // [
    // double width = 350,
    // ]
  ) {
    return Image.asset('assets/$assetName', fit: BoxFit.cover
        // width: width,
        );
  }

  Widget _buildLottie(String assetName, [double? width]) {
    return Lottie.asset(
      'assets/$assetName',
      fit: BoxFit.cover,
      width: width,
    );
  }

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const AllNotebooksPage()),
    );
  }

  Widget _buildFullscreenImage() {
    return Image.asset(
      'assets/fullscreen.jpg',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
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
        // globalHeader: Align(
        //   alignment: Alignment.topRight,
        //   child: SafeArea(
        //     child: Padding(
        //       padding: const EdgeInsets.only(top: 16, right: 16),
        //       child: _buildImage('flutter.png', 100),
        //     ),
        //   ),
        // ),
        // globalFooter: SizedBox(
        //   width: double.infinity,
        //   height: 60,
        //   child: ElevatedButton(
        //     child: const Text(
        //       'Let\'s go right away!',
        //       style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
        //     ),
        //     onPressed: () {},
        //   ),
        // ),
        pages: [
          PageViewModel(
            title: "Notebooks",
            body:
                "Notebooks is a simple, yet powerful, app that allows you to create and share your own personal notes.",
            image: _buildLottie('animations/onboarding-first.json', 220.w),
            decoration: pageDecoration.copyWith(
              imagePadding: EdgeInsets.symmetric(horizontal: 30.w),
              imageFlex: 2,
            ),
          ),
          PageViewModel(
            title: "Create Notebooks",
            body:
                "Create notebooks for different topics and store notes categorically.",
            image: _buildLottie('animations/onboarding-notebooks.json'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Create Notes",
            body:
                "Create and customize notes as you wish with beautiful colors.",
            image: _buildLottie('animations/onboarding-note.json'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Safe and Secure",
            body:
                "Your notes are stored in your device. No need to worry about losing them. Also, your notes are safe with you.",
            image: _buildLottie('animations/onboarding-safe.json'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Let's get started!",
            body: "Tap on the done button below to start using Notebooks.",
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
        //rtl: true, // Display as right-to-left
        back: const Icon(Icons.arrow_back_ios_rounded),
        skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
        next: const Icon(Icons.arrow_forward_ios_rounded),
        done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
        // scrollPhysics: const BouncingScrollPhysics(),
        curve: Curves.fastLinearToSlowEaseIn,
        controlsMargin: EdgeInsets.all(16.w),
        controlsPadding: kIsWeb
            ? EdgeInsets.all(12.w)
            : EdgeInsets.fromLTRB(8.w, 4.h, 8.w, 4.h),
        dotsDecorator: DotsDecorator(
          size: Size(10.w, 10.w),
          // color: const Color(0xFFBDBDBD),
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
