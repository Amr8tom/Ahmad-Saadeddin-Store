import 'package:gostore_app/network_dio/network_dio.dart';
import 'package:gostore_app/utils/base_api.dart';

class OrderHistoryRepository {
  Future addOrder(Map data) async {
    String url = API.ordersUrl;
    var response = await NetworkHttps.postRequest(url,data);
    return response;
  }
  Future getOrderHistory() async {
    String url = API.ordersUrl;
    var response = await NetworkHttps.getRequest(url);
    return response;
  }
  Future getOrderHistoryDetail(String orderId) async {
    String url = '${API.ordersUrl}/$orderId';
    var response = await NetworkHttps.getRequest(url);
    return response;
  }
}
