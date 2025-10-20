import 'package:get/get.dart';
import '../data/order_data.dart';
import '../../../../../../data/models/order_model.dart';

class OrdersController extends GetxController {
  RxString selectedStatus = RxString('');
  RxInt selectedYear = RxInt(0);
  final orders = ordersData.obs;

  List<OrderModel> get filteredOrders {
    return orders.where((order) {
      final orderDate = DateTime.parse(order.date);
      final matchesStatus =
          selectedStatus.value.isEmpty || order.status == selectedStatus.value;
      final matchesYear =
          selectedYear.value == 0 || orderDate.year == selectedYear.value;
      return matchesStatus && matchesYear;
    }).toList();
  }

  List<int> get years {
    final now = DateTime.now();
    return List.generate(5, (i) => now.year - i);
  }

  List<String> get statuses {
    return orders.map((o) => o.status).toSet().toList();
  }

  bool get isNoOrders => orders.isEmpty;
  bool get isNoFilterResult => orders.isNotEmpty && filteredOrders.isEmpty;

  void setStatus(String? status) {
    selectedStatus.value = status ?? '';
    update();
  }

  void setYear(int? year) {
    selectedYear.value = year ?? 0;
    update();
  }

  void clearStatus() {
    selectedStatus.value = '';
    update();
  }

  void clearYear() {
    selectedYear.value = 0;
    update();
  }
}
