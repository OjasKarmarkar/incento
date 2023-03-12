import 'package:animations/animations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:incento_demo/Screens/Auth/login.dart';
import 'package:incento_demo/Screens/Mainscreen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Const/colors.dart';
import 'Utils/languages.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final String? uid = GetStorage().read('uid') ?? null;
    return GetMaterialApp(
        translations: Languages(),
        locale: Get.deviceLocale,
        fallbackLocale: const Locale('en', 'US'),
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        themeMode: ThemeMode.system,
        // darkTheme: ThemeData.dark(),
        theme: ThemeData(
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.android: SharedAxisPageTransitionsBuilder(
                transitionType: SharedAxisTransitionType.horizontal,
              ),
              TargetPlatform.iOS: SharedAxisPageTransitionsBuilder(
                transitionType: SharedAxisTransitionType.horizontal,
              ),
            },
          ),
          textSelectionTheme:
              const TextSelectionThemeData(cursorColor: accentColor),
          colorScheme: ThemeData().colorScheme.copyWith(primary: accentColor),
          textTheme: GoogleFonts.spaceGroteskTextTheme(
            Theme.of(context).textTheme,
          ),
          appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.dark,
                  systemNavigationBarColor: Colors.white)),
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.blue,
        ),
        //home: Login(),
        routes: {
          '/': (context) => MainScreen()
          // '/forgot':(context)=>  ForgotPwd(),
          // When navigating to the "/second" route, build the SecondScreen widget.
        });
  }
}
