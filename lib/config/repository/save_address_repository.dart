// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:gostore_app/network_dio/network_dio.dart';
import 'package:gostore_app/utils/base_api.dart';
import 'package:gostore_app/utils/constant.dart';
import 'package:gostore_app/utils/prefer.dart';
import 'package:http/http.dart' as http;

class SaveAddressRepository {

  Future saveAddress(Map data) async {
    String postUrl = API.baseUrl + API.userAddressUrl + API.saveAddressUrl;
    print("POST API URL===> $postUrl");
    print("data===> ${jsonEncode(data)}");
    var response = await http.post(Uri.parse(postUrl),
        body: jsonEncode(data), headers: NetworkHttps.authHeaders);
    print("statusCode===> ${response.statusCode}");
    print("response body===> ${response.body}");

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
  }

  Future getAddressData() async {
    String id = Prefs.getString(AppConstant.userId) ?? '';

    String url = API.baseUrl +
        API.userAddressUrl +
        API.listAddressUrl +
        API.userIdUrl +
        id;
    print("GEZT API URL===> $url");
    print("accessToken===> ${NetworkHttps.authHeaders}");
    var response = await http.get(Uri.parse(url), headers: NetworkHttps.authHeaders);
    print("statusCode===> ${response.statusCode}");
    print("response body===> ${response.body}");

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
  }
}
