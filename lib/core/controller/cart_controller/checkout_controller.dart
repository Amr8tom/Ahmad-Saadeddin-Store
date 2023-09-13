// ignore_for_file: avoid_print, prefer_const_constructors

import 'dart:developer';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gostore_app/config/repository/profile_repository.dart';
import 'package:gostore_app/config/repository/save_address_repository.dart';
import 'package:gostore_app/core/controller/cart_controller/cart_controller.dart';
import 'package:gostore_app/core/model/save_address_model.dart';
import 'package:gostore_app/core/model/userdata_model.dart';
import 'package:gostore_app/utils/constant.dart';
import 'package:gostore_app/utils/images.dart';
import 'package:gostore_app/utils/prefer.dart';
import 'package:gostore_app/view/widget/common_snak_bar_widget.dart';
import 'package:gostore_app/view/widget/loading_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gostore_app/config/repository/order_history_repository.dart';
import 'package:gostore_app/view/screen/my_cart/checkout_success_screen.dart';

class CheckoutController extends GetxController {
  CartController cartController = Get.find();
  OrderHistoryRepository orderHistoryRepository = OrderHistoryRepository();
  ProfileRepository profileRepository = ProfileRepository();
  SaveAddressRepository saveAddressRepository = SaveAddressRepository();

  List tabBarList = ['Address'.tr, 'Shipping'.tr, 'Payment'.tr, 'Finalize'.tr];
  RxMap<MarkerId, Marker> markers = <MarkerId, Marker>{}.obs;
  RxString currentAddress = ''.obs;
  RxString address_title = ''.obs;
  RxString address_1 = ''.obs;
  RxString address_2 = ''.obs;
  RxString city = ''.obs;
  RxString state = ''.obs;
  RxString postcode = ''.obs;
  RxString country = ''.obs;
  TextEditingController searchPlace = TextEditingController();
  var titleController = TextEditingController().obs;
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  RxList shippingDataList = [
    {
      "value": true.obs,
      "image": DefaultImages.fedExImage,
      "label": "FedEx",
    }.obs,
    {
      "value": false.obs,
      "image": DefaultImages.dhlImage,
      "label": "DHL",
    }.obs,
    {
      "value": false.obs,
      "image": DefaultImages.upsImage,
      "label": "UPS",
    }.obs,
  ].obs;
  RxList paymentDataList = [
    {
      "value": true.obs,
      "image": DefaultImages.masterCardImage,
      "label": "MasterCard",
    }.obs,
    {
      "value": false.obs,
      "image": DefaultImages.paypalImage,
      "label": "PayPal",
    }.obs,
    {
      "value": false.obs,
      "image": DefaultImages.visaImage,
      "label": "VISA",
    }.obs,
  ].obs;
  RxMap shippingMap = {}.obs;
  RxList<Map> itemsList = <Map>[].obs;
  SaveAddressModel? saveAddressModel;
  RxList<AddressData> addressList = <AddressData>[].obs;

  addToOrder() async {
    Loader.showLoader();
    Map data = {
      "payment_method": "cod",
      "payment_method_title": "Cash on delivery",
      "set_paid": false,
      "billing": shippingMap,
      "line_items": itemsList
    };
    print("data====>$data");
    var response = await orderHistoryRepository.addOrder(data);
    log("response=====>$response");
    if (response != null) {
      cartController.clearCart();
      Get.to(() => CheckoutSuccessScreen(orderId: response["order_key"],));
    }
    // Get.back();
  }

  UserDetailModel? userDetailModel;

  getProfileData() async {
    Loader.showLoader();
    String userId = Prefs.getString(AppConstant.userId);
    print("userId====> $userId");
    var response = await profileRepository.getProfileData(userId);
    if (response != null) {
      userDetailModel = UserDetailModel.fromJson(response);
      fNameController.text = userDetailModel!.firstName!;
      lNameController.text = userDetailModel!.lastName!;
      phoneNoController.text = userDetailModel!.shipping!.phone!;
      emailController.text = userDetailModel!.email!;
      print("phoneController.text${phoneNoController.text}");
    }
    Get.back();
  }

  saveAddress() async {
    String userId = Prefs.getString(AppConstant.userId);

    Loader.showLoader();
    Map data = {
      "user_id": userId,
      "title": titleController.value.text.trim(),
      "address": currentAddress.value
    };
    var response = await saveAddressRepository.saveAddress(data);
    if (response != null) {
      print("saveAddress===>$response");
      commonToast(response['data']);
    }
    Get.back();
  }

  getSaveAddressList() async {
    Loader.showLoader();

    var response = await saveAddressRepository.getAddressData();
    if (response != null) {
      print("saveAddress===>$response");
      saveAddressModel=SaveAddressModel.fromJson(response);
      addressList.value=saveAddressModel!.data!;
      addressList.refresh();
    }
    Get.back();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    titleController.value = TextEditingController()..text = "Home";
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getProfileData();
    });
  }
}
