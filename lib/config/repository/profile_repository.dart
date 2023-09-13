import 'dart:convert';
import 'dart:developer';

import 'package:gostore_app/network_dio/network_dio.dart';
import 'package:gostore_app/utils/base_api.dart';
import 'package:http/http.dart' as http;
class ProfileRepository {
  Future getProfileData(String id) async {
    String url = "${API.customersUrl}/$id";
    var response = await NetworkHttps.getRequest(url);
    log("response===>$response");
    return response;
  }
  Future updateProfileData(String id,Map data) async {
    String endPoint = "${API.customersUrl}/$id";
    String url  =  NetworkHttps.getOAuthURL(endPoint);
    var response = await http.post(Uri.parse(url),
        body: jsonEncode(data), headers: NetworkHttps.headers);
    print("statusCode===> ${response.statusCode}");
    print("response body===> ${response.body}");
    print(
        "response c===> ${response.statusCode == 200 || response.statusCode == 201}");
    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body);
    }    log("response===>$response");
    return response;
  }
}
