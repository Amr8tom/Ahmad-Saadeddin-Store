// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:get/get.dart';
import 'package:gostore_app/config/repository/filters_repository.dart';
import 'package:gostore_app/core/model/attributes_model.dart';
import 'package:gostore_app/core/model/categories_model.dart';
import 'package:gostore_app/core/model/tags_model.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class FilterController extends GetxController {
  FiltersRepository filtersRepository = FiltersRepository();
  RxList<CategoriesModel> categoriesList = <CategoriesModel>[].obs;
  RxList<CategoriesModel> subCategoriesList = <CategoriesModel>[].obs;
  RxList<TagsModel> tagList = <TagsModel>[].obs;
  RxList<AllAttributesModel> allAttributesList = <AllAttributesModel>[].obs;
  RxList<AttributesModel> colorList = <AttributesModel>[].obs;
  RxList<AttributesModel> sizeList = <AttributesModel>[].obs;
  RxBool isCategoryAvailable = false.obs;
  RxBool isDataAvailable = false.obs;
  RxString tagsTd = ''.obs;
  RxString attributeTerm = ''.obs;
  RxString attribute = ''.obs;
  RxString categoriesId =''.obs;

  List<CategoriesModel> get categoriesResult => categoriesList;

  List<CategoriesModel> get subCategoriesResult => subCategoriesList;

  List<TagsModel> get tagResult => tagList;

  List<AllAttributesModel> get allAttributesResult => allAttributesList;

  List<AttributesModel> get colorResult => colorList;

  List<AttributesModel> get sizeResult => sizeList;
  var currentRangeValues = SfRangeValues(10, 192).obs;

  Future getAllCategory() async {
    // Loader.showLoader();
    isDataAvailable.value = true;
    var response = await filtersRepository.getCategory("0");
    if (response != null) {
      categoriesList.clear();
      for (int i = 0; i < response.length; i++) {
        categoriesResult.add(CategoriesModel.fromJson(response[i]));
      }
    }
    isDataAvailable.value = false;
    // Get.back();
  }

  Future getSubCategory(String id) async {
    isCategoryAvailable.value = true;
    var response = await filtersRepository.getCategory(id);
    subCategoriesList.clear();
    if (response != null) {
      for (int i = 0; i < response.length; i++) {
        subCategoriesResult.add(CategoriesModel.fromJson(response[i]));
      }
      isCategoryAvailable.value = false;
      print("element-------------------> ${subCategoriesResult.length}");
    }
    isCategoryAvailable.value = false;
  }

  Future getTagData() async {
    isDataAvailable.value = true;
    var response = await filtersRepository.getTagData();
    tagList.clear();
    if (response != null) {
      for (int i = 0; i < response.length; i++) {
        tagResult.add(TagsModel.fromJson(response[i]));
      }
      print("element-------------------> ${tagList.length}");
    }
    isDataAvailable.value = false;
  }

  Future getAllAttributes() async {
    isDataAvailable.value = true;
    var response = await filtersRepository.getAllAttributes();
    allAttributesList.clear();
    if (response != null) {
      for (int i = 0; i < response.length; i++) {
        allAttributesResult.add(AllAttributesModel.fromJson(response[i]));
      }
      print("All attributes-------------------> ${allAttributesList.length}");
    }
    isDataAvailable.value = false;
  }

  Future getColor(id) async {
    isDataAvailable.value = true;
    var response = await filtersRepository.getAttributes(id);
    colorList.clear();
    if (response != null) {
      for (int i = 0; i < response.length; i++) {
        colorResult.add(AttributesModel.fromJson(response[i]));
        print("colorList11-------------------> ${colorList[i].colorCode}");
        print("colorList11-------------------> ${colorList[i].name}");
      }
      print("colorList-------------------> ${colorList.length}");
    }
    isDataAvailable.value = false;
  }

  Future getSize(id) async {
    isDataAvailable.value = true;
    var response = await filtersRepository.getAttributes(id);
    sizeList.clear();
    if (response != null) {
      for (int i = 0; i < response.length; i++) {
        sizeResult.add(AttributesModel.fromJson(response[i]));
        print("sizeList11-------------------> ${sizeList[i].name}");
      }
      print("sizeList-------------------> ${sizeList.length}");
    }
    isDataAvailable.value = false;
  }

  Future getFilterProduct({
    required String categoryId,
    required String minPrice,
    required String maxPrice,
    required String tagID,
    required String attribute,
    required String attributeTerm,
  }) async {
    // isDataAvailable.value = true;
    var response = await filtersRepository.getFilterProduct(
        categoryId: categoryId,
        minPrice: minPrice,
        maxPrice: maxPrice,
        tagID: tagID,
        attribute: attribute,
        attributeTerm: attributeTerm);
    if (response != null) {
      return response;
    }
    // isDataAvailable.value = false;
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tagsTd.value = '';
    attributeTerm.value = '';
    attribute.value = '';
    categoriesId.value ='';
  }
}
