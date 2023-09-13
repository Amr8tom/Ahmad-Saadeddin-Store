// ignore_for_file: avoid_print
import 'dart:convert';
import 'package:gostore_app/utils/base_api.dart';
import 'package:http/http.dart' as http;

class BlogRepository {
  // String bearerToken = 'Bearer ${NetworkHttps.accessToken}';

  Future getBlogData(perPage) async {
    String url = API.baseUrl + API.blogUrl + API.perPageUrl + perPage;
    print("-blogUrl----------->$url");
    var response = await http.get(Uri.parse(url));
    print("statusCode=======> ${response.statusCode}");
    print("body=======> ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.reasonPhrase);
    }
  }

  Future getArticleData() async {
    String url = API.baseUrl + API.blogUrl;
    print("-blogUrl----------->$url");
    var response = await http.get(Uri.parse(url));
    print("statusCode=======> ${response.statusCode}");
    print("body=======> ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.reasonPhrase);
    }
  }

  Future getPostDetailData(id) async {
    String url = "${API.baseUrl}${API.blogUrl}/$id";
    print("-blogUrl----------->$url");
    var response = await http.get(Uri.parse(url));
    print("statusCode=======> ${response.statusCode}");
    print("body=======> ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print(response.reasonPhrase);
    }
  }
}
