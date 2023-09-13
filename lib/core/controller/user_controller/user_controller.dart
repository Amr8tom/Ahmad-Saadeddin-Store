// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gostore_app/config/repository/profile_repository.dart';
import 'package:gostore_app/core/model/userdata_model.dart';
import 'package:gostore_app/utils/base_api.dart';
import 'package:gostore_app/utils/constant.dart';
import 'package:gostore_app/utils/prefer.dart';
import 'package:gostore_app/view/widget/loading_widget.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../../../view/widget/common_snak_bar_widget.dart';

class UserController extends GetxController {
  ProfileRepository profileRepository = ProfileRepository();
  TextEditingController displayNameController = TextEditingController();
  TextEditingController fNameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  File? postImage;
  RxString selectedImagePath = ''.obs;
  RxString sendImagePath = ''.obs;
  RxInt imageId = 0.obs;
  RxString profileImage =
      'https://secure.gravatar.com/avatar/a776a746d8b10244085b13aa7772e55a?s=96&d=mm&r=g'
          .obs;
  UserDetailModel? userDetailModel;

  pickImage(ImageSource imageSource) async {
    XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      print(pickedImage);
      postImage = File(pickedImage.path);
      selectedImagePath.value = File(pickedImage.path).path;
      print("==== f $postImage");
      print("==== uri ${postImage!.uri}");
      print("====  ${selectedImagePath.value}");
      uploadImage();
    } else {
      commonToast('Image Not Pick');
    }
  }

  uploadImage() async {
    Loader.showLoader();
    String accessToken = Prefs.getToken();
    String url = API.baseUrl + API.imageUrl;
    print("========url:: $url");
    print("========accessToken:: $accessToken");
    String fileName = selectedImagePath.value.split("/").last;
    print("========fileName:: $fileName");
    Map<String, String> requestHeaders = {
      "Authorization": "Bearer $accessToken",
      HttpHeaders.contentTypeHeader: "image/jpeg",
      "Content-Disposition": "attachment: filename=$fileName"
    };
    print("========requestHeaders:: $requestHeaders");
    List<int> imageByte = File(selectedImagePath.value).readAsBytesSync();
    print("========imageByte:: $imageByte");
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(requestHeaders);
    request.files.add(http.MultipartFile(
        'file',
        File(selectedImagePath.value).readAsBytes().asStream(),
        File(selectedImagePath.value).lengthSync(),
        filename: selectedImagePath.value.split("/").last));
    var response = await request.send();
    Loader.hideLoader();
    print("========request:: $request");
    print("========response:: ${response}");
    print("========statusCode:: ${response.statusCode}");
    // print("========response:: ${await response.stream.bytesToString()}");
    var decodedResponse = jsonDecode(await response.stream.bytesToString());
    print("========response::1 ${decodedResponse}");
    imageId.value = decodedResponse['id'];
    sendImagePath.value = decodedResponse['guid']['rendered'];
    print("========response::id ${decodedResponse['id']}(${imageId.value})");
  }

  getProfileData() async {
    Loader.showLoader();
    String userId = Prefs.getString(AppConstant.userId);
    print("userId====> $userId");
    var response = await profileRepository.getProfileData(userId);
    if (response != null) {
      userDetailModel = UserDetailModel.fromJson(response);
      displayNameController.text = userDetailModel!.username!;
      fNameController.text = userDetailModel!.firstName!;
      lNameController.text = userDetailModel!.lastName!;
      phoneController.text = userDetailModel!.shipping!.phone!;
      emailController.text = userDetailModel!.email!;
      userDetailModel!.metaData!.forEach((element) {
        if (element.key == "user_profile_img") {
         if( element.value!=""){
           profileImage.value = element.value!;
         }
        }
      });      print("phoneController.text${phoneController.text}");
    }
    Get.back();
  }

  updateProfileData() async {
    Loader.showLoader();
    String userId = Prefs.getString(AppConstant.userId);
    print("userId====> $userId");
    var data = {
      "first_name": fNameController.text,
      "last_name": lNameController.text,
      "email": emailController.text,
      "username": displayNameController.text,
      "billing": {
        "phone": phoneController.text,
        "first_name": fNameController.text,
        "email": emailController.text,
      },
      "shipping": {
        "phone": phoneController.text,
        "first_name": fNameController.text
      },
      "meta_data": [
        {
          "key": 'user_profile_img',
          "value": sendImagePath.value,
        }
      ]
    };
    print("data====> $data");
    var response = await profileRepository.updateProfileData(userId, data);
    if (response != null) {
      userDetailModel = UserDetailModel.fromJson(response);
      displayNameController.text = userDetailModel!.username!;
      fNameController.text = userDetailModel!.firstName!;
      lNameController.text = userDetailModel!.lastName!;
      phoneController.text = userDetailModel!.shipping!.phone!;
      emailController.text = userDetailModel!.email!;
      userDetailModel!.metaData!.forEach((element) {
        if (element.key == "user_profile_img") {
          profileImage.value = element.value!;
        }
      });
    }
    Get.back();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    selectedImagePath.value = '';
  }
}
