// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, avoid_print
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gostore_app/utils/prefer.dart';
import 'package:gostore_app/view/screen/onboarding_screen/onboarding_screen.dart';
import 'core/controller/gostore_controller.dart';
import 'package:gostore_app/utils/locale_string.dart';
import 'utils/constant.dart';
import 'view/screen/dashboard_manager/dashboard_manager.dart';

class GoStoreApp extends StatelessWidget {
  GoStoreApp({Key? key}) : super(key: key);

  getToken() {
    String id = Prefs.getString(AppConstant.userId) ?? '';
    String accessToken = Prefs.getToken();
    print("id===> $id");
    print("accessToken===> $accessToken");
    return accessToken;
  }
  getDeviceToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print('fcmToken------>($fcmToken)');
  }

  @override
  Widget build(BuildContext context) {
    getDeviceToken();
    String languageCode = Prefs.getString(AppConstant.LANGUAGE_CODE) ?? 'en';
    String countryCode = Prefs.getString(AppConstant.COUNTRY_CODE) ?? 'US';
    Locale locale = Locale(languageCode, countryCode);
    return GetBuilder(
        init: GoStoreAppController(),
        builder: (goStoreAppController) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            translations: LocaleString(),
            locale: locale,
            fallbackLocale: locale,
            theme: ThemeData(fontFamily: 'Inter'),
            home: FutureBuilder(
              initialData: getToken(),
              builder: (context, AsyncSnapshot snapshot) {
                bool getStarted = Prefs.getBool(AppConstant.getStarted);
                print("getStarted===>> $getStarted");
                print("111 ${snapshot.hasData}");
                print("222 ${snapshot.data}");
                if (snapshot.hasData && snapshot.data != '' ||
                    getStarted == true) {
                  print("===>> true");
                  return DashBoardManagerScreen();
                } else {
                  print("===false");
                  return OnBoardingScreen();
                }
              }, future: null,
            ),
          );
        });
  }
}
