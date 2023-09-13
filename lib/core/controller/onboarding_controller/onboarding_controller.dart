// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gostore_app/utils/constant.dart';
import 'package:gostore_app/utils/images.dart';
import 'package:gostore_app/utils/prefer.dart';


class OnBodingController extends GetxController {
  RxInt currantIndex=0.obs;
  RxInt selectedLanguageIndex=0.obs;
  RxString selectedLanguage="English".obs;
  RxList languageList = [
    {'image': DefaultImages.englishImg, 'title': "English",      "local":Locale("en","US"),"languageCode":"en","countryCode":"US"}.obs, //en_US
    {'image': DefaultImages.indonesianImg, 'title': "Indonesian","local":Locale("id","ID"),"languageCode":"id","countryCode":"ID"}.obs, //id_ID
    {'image': DefaultImages.greeceImg, 'title': "Greece",        "local":Locale("el","GR"),"languageCode":"el","countryCode":"GR"}.obs, //el_GR
    {'image': DefaultImages.polishImg, 'title': "Polish",        "local":Locale("pl","PL"),"languageCode":"pl","countryCode":"PL"}.obs, //pl_PL
    {'image': DefaultImages.ukrainianImg, 'title': "Ukrainian",  "local":Locale("uk","UA"),"languageCode":"uk","countryCode":"UA"}.obs, //uk_UA
    {'image': DefaultImages.espanyolImg, 'title': "Espanyol",    "local":Locale("es","ES"),"languageCode":"es","countryCode":"ES"}.obs, //es_ES //Spanish
  ].obs;
  updateLanguage(Locale locale) {
    print("================$locale");
    Get.updateLocale(locale);
    Prefs.setString(AppConstant.LANGUAGE_CODE, locale.languageCode);
    Prefs.setString(AppConstant.COUNTRY_CODE, locale.countryCode.toString());
  }
}
