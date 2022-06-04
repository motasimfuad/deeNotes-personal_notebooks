import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notebooks/all_providers.dart';
import 'dependency_injection.dart' as di;

import 'core/constants/strings.dart';
import 'core/themes/app_theme.dart';
import 'core/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  // await DataRepository.instance.createDatabase();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQueryData.fromWindow(
        WidgetsBinding.instance.window,
      ),
      child: ScreenUtilInit(
        minTextAdapt: true,
        designSize: const Size(392.7, 834.9),
        builder: () => AllProviders(
          child: MaterialApp.router(
            builder: (context, widget) {
              //add this line
              ScreenUtil.setContext(context);
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: widget!,
              );
            },
            title: Strings.appTitle,
            theme: AppTheme.lightTheme,
            // darkTheme: AppTheme.darkTheme,
            debugShowCheckedModeBanner: false,
            routeInformationParser: router.routeInformationParser,
            routerDelegate: router.routerDelegate,
            // initialRoute: AppRouter.home,
            // onGenerateRoute: AppRouter.onGenerateRoute,
          ),
        ),
      ),
    );
  }
}
