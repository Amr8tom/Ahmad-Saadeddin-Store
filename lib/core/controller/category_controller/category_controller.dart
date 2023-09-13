// ignore_for_file: prefer_const_constructors

import 'package:get/get.dart';
import 'package:gostore_app/config/repository/filters_repository.dart';
import 'package:gostore_app/core/model/categories_model.dart';
import 'package:gostore_app/utils/images.dart';

import '../home_controller/home_controller.dart';

class CategoryController extends GetxController {
  RxInt popupMenuItemIndex = 0.obs;
  List popupList = [
    {'icon': DefaultImages.calendarIcn, 'title': 'Date'.tr},
    {'icon': DefaultImages.starIcn, 'title': 'Featured'.tr},
    {'icon': DefaultImages.percentIcn, 'title': 'On Sale'.tr},
  ];
  RxString startDate = ''.obs;
  RxString endDate = ''.obs;
  FiltersRepository filtersRepository = FiltersRepository();
  RxBool isDataAvailable = false.obs;
  RxList<CategoriesModel> subCategoriesList = <CategoriesModel>[].obs;

  List<CategoriesModel> get subCategoriesResult => subCategoriesList;

  List<DateTime?> dialogCalendarPickerValue = [
    DateTime.now(),
    DateTime.now().add(Duration(days: 3)),
  ];

  Future getSubCategory(String id) async {
    var response = await filtersRepository.getCategory(id);
    subCategoriesList.clear();
    if (response != null) {
      for (int i = 0; i < response.length; i++) {
        subCategoriesResult.add(CategoriesModel.fromJson(response[i]));
      }
      subCategoriesList.insert(
          0, CategoriesModel(name: "All", isExpand: true, id: 33));
      print("element-------------------> ${subCategoriesResult.length}");
    }
  }

  Future getDateFilter(String endPoint) async {
    isDataAvailable.value = true;

    var response = await filtersRepository.getDateFilter(endPoint);
    if (response != null) {
      isDataAvailable.value = false;
      return response;
    }
    isDataAvailable.value = false;
  }
}
