import 'controller/orders_controller.dart';
import 'package:get/get.dart';
import 'components/orders_empty_view.dart';
import 'package:corehive_store/app/presentation/widgets/app_modal_bottom_sheet.dart';

import 'components/order_filter_bottom_sheet.dart';
import 'package:corehive_store/app/presentation/widgets/app_card.dart';
import 'package:flutter/material.dart';
import 'package:corehive_store/app/config/theme/color_extension.dart';
import 'package:intl/intl.dart';
import 'package:corehive_store/app/presentation/widgets/app_network_image.dart';
import '../../../../widgets/app_text.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  // State handled by OrdersController

  @override
  Widget build(BuildContext context) {
    const String globalCurrency = 'USD';
    return GetBuilder<OrdersController>(
      builder: (controller) {
        if (controller.isNoOrders) {
          return OrdersEmptyView(
            showButton: true,
            message: 'You have not placed any orders yet.',
            onButtonPressed: () {
              //todo redirect to home
            },
          );
        }
        if (controller.isNoFilterResult) {
          return OrdersEmptyView(
            showButton: false,
            message: 'No orders match your filter.',
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: AppText(
              text: 'My Orders',
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: context.kTextColor,
            ),
            centerTitle: true,
            backgroundColor: context.kBackgroundColor,
            elevation: 0,
            actions: [
              IconButton(
                icon: Icon(Icons.filter_list, color: context.kPrimaryColor),
                onPressed: () {
                  showAppModalBottomSheet(
                    context: context,
                    isDismissible: true,
                    child: OrderFilterBottomSheet(
                      selectedStatus: controller.selectedStatus.value.isEmpty
                          ? null
                          : controller.selectedStatus.value,
                      selectedYear: controller.selectedYear.value == 0
                          ? null
                          : controller.selectedYear.value,
                      statuses: controller.statuses,
                      years: controller.years,
                      onStatusSelected: (status) {
                        controller.setStatus(status);
                      },
                      onYearSelected: (year) {
                        controller.setYear(year);
                      },
                    ),
                  );
                },
              ),
            ],
          ),
          body: Column(
            children: [
              if (controller.selectedStatus.value.isNotEmpty ||
                  controller.selectedYear.value != 0)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      if (controller.selectedStatus.value.isNotEmpty)
                        Chip(
                          label: Text(
                            'Status: ${controller.selectedStatus.value}',
                          ),
                          onDeleted: controller.clearStatus,
                        ),
                      if (controller.selectedYear.value != 0)
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Chip(
                            label: Text(
                              'Year: ${controller.selectedYear.value}',
                            ),
                            onDeleted: controller.clearYear,
                          ),
                        ),
                    ],
                  ),
                ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.filteredOrders.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final order = controller.filteredOrders[index];
                    final orderDate = DateTime.parse(order.date);
                    final formattedDate = DateFormat.yMMMMd().format(orderDate);
                    return AppCard(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            AppNetworkImage(
                              imageUrl: order.productImage,
                              width: 60,
                              height: 60,
                              radius: 12,
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AppText(
                                    text: order.productName,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: context.kTextColor,
                                  ),
                                  const SizedBox(height: 4),
                                  AppText(
                                    text: 'Qty: ${order.quantity}',
                                    fontSize: 13,
                                    color: context.kHintTextColor,
                                  ),
                                  const SizedBox(height: 4),
                                  AppText(
                                    text: formattedDate,
                                    fontSize: 13,
                                    color: context.kHintTextColor,
                                  ),
                                  const SizedBox(height: 4),
                                  AppText(
                                    text: 'Status: ${order.status}',
                                    fontSize: 13,
                                    color: order.status == 'Delivered'
                                        ? Colors.green
                                        : order.status == 'Cancelled'
                                        ? Colors.red
                                        : context.kPrimaryColor,
                                  ),
                                ],
                              ),
                            ),
                            AppText(
                              text: '${order.total} $globalCurrency',
                              fontWeight: FontWeight.w600,
                              color: context.kPrimaryColor,
                              fontSize: 15,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
