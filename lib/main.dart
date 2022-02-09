import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/constants/strings.dart';
import 'core/themes/app_theme.dart';
import 'presentation/router/app_router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
        data: MediaQueryData.fromWindow(WidgetsBinding.instance!
            .window), // like this it works and produces correct font sizes
        child: ScreenUtilInit(
          minTextAdapt: true,
          designSize: const Size(392.7, 834.9),
          builder: () => MaterialApp(
            builder: (context, widget) {
              //add this line
              ScreenUtil.setContext(context);
              return MediaQuery(
                //Setting font does not change with system font size
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: widget!,
              );
            },
            title: Strings.appTitle,
            theme: AppTheme.lightTheme,
            // darkTheme: AppTheme.darkTheme,
            debugShowCheckedModeBanner: false,
            initialRoute: AppRouter.home,
            onGenerateRoute: AppRouter.onGenerateRoute,
          ),
        ));
  }
}
