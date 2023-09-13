import 'package:get/get.dart';

class CurrenciesController extends GetxController {
  RxInt currantIndex = 0.obs;
  RxList currenciesList = [
    "USD (\$)",
    "Euro (€)",
    "Pound sterling (£)",
  ].obs;
}
