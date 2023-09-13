import 'package:get/get.dart';
import 'package:gostore_app/config/repository/order_history_repository.dart';
import 'package:gostore_app/core/model/order_history_model.dart';
import 'package:gostore_app/utils/images.dart';
import 'package:gostore_app/view/widget/loading_widget.dart';

class OrderHistoryController extends GetxController {
  OrderHistoryRepository orderHistoryRepository = OrderHistoryRepository();
  RxInt currantIndex = 0.obs;

  RxList<OrdersHistoryModel> orderHistoryList = <OrdersHistoryModel>[].obs;

  List<OrdersHistoryModel> get orderHistoryResult => orderHistoryList;
  RxList<LineItems> cartList = <LineItems>[].obs;

  OrdersHistoryModel? ordersHistory;

  OrdersHistoryModel? get resultData => ordersHistory;

  set resultData(OrdersHistoryModel? data) {
    ordersHistory = data;
    update();
  }
  RxBool isEmptyHistoryList = false.obs;

  getOrderHistory() async {
    Loader.showLoader();
    var response = await orderHistoryRepository.getOrderHistory();
    orderHistoryList.clear();
    if (response != null) {
      for (int i = 0; i < response.length; i++) {
        orderHistoryResult.add(OrdersHistoryModel.fromJson(response[i]));
      }
      print("orderHistoryList-------------------> ${orderHistoryList.length}");
    }
    if(orderHistoryList.isEmpty){
      isEmptyHistoryList.value=true;
    }
    Get.back();
  }

  getOrderHistoryDetail(String orderId) async {
    Loader.showLoader();
    var response = await orderHistoryRepository.getOrderHistoryDetail(orderId);
    if (response != null) {
      resultData = OrdersHistoryModel.fromJson(response);
      cartList.value=resultData!.lineItems!;
      cartList.refresh();
      print("resultData-------------------> $resultData");
    }
    Get.back();
  }
}
