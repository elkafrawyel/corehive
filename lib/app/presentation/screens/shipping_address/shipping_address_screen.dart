import 'package:corehive_store/app/config/extension/space_extension.dart';
import 'package:corehive_store/app/presentation/widgets/app_button.dart';
import 'package:flutter/material.dart';
import '../../../data/models/shipping_address_model.dart';
import '../../widgets/app_card.dart';
import 'controller/shipping_address_controller.dart';
import 'package:corehive_store/app/presentation/widgets/app_text_field/app_text_field.dart';
import 'package:get/get.dart';
import 'package:corehive_store/app/config/theme/color_extension.dart';
import 'package:corehive_store/app/presentation/widgets/app_modal_bottom_sheet.dart';
import 'package:corehive_store/app/presentation/widgets/app_text.dart';

class ShippingAddressScreen extends StatelessWidget {
  const ShippingAddressScreen({super.key});

  static Future<void> show(BuildContext context) async {
    await showAppModalBottomSheet(
      context: context,
      child: const ShippingAddressScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText(
          text: 'Shipping Addresses',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: context.kTextColor,
        ),
        backgroundColor: context.kBackgroundColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          color: context.kBackgroundColor,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() {
              final controller = Get.find<ShippingAddressController>();
              return controller.addresses.isEmpty
                  ? Column(
                      children: [
                        AppText(
                          text: 'No addresses added yet.',
                          color: context.kHintTextColor,
                          fontSize: 16,
                        ),
                        const SizedBox(height: 24),
                      ],
                    )
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.addresses.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (ctx, i) {
                        final address = controller.addresses[i];
                        return AppCard(
                          elevation: 2.0,
                          child: ListTile(
                            leading: Icon(
                              address.isPrimary ? Icons.star : Icons.home,
                              color: address.isPrimary
                                  ? Colors.amber
                                  : Colors.blue,
                            ),
                            title: AppText(
                              text: address.name,
                              fontWeight: FontWeight.w600,
                              color: context.kTextColor,
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  text: address.address,
                                  color: context.kTextColor,
                                  maxLines: 3,
                                ),
                                AppText(
                                  text: address.phone,
                                  color: context.kHintTextColor,
                                ),
                              ],
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () async {
                                    final nameController =
                                        TextEditingController(
                                          text: address.name,
                                        );
                                    final addrController =
                                        TextEditingController(
                                          text: address.address,
                                        );
                                    final phoneController =
                                        TextEditingController(
                                          text: address.phone,
                                        );
                                    await showAppModalBottomSheet(
                                      context: context,
                                      isDismissible: true,
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                AppText(
                                                  text: 'Edit Address',
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: context.kTextColor,
                                                ),
                                                Spacer(),
                                                IconButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  icon: Icon(Icons.close),
                                                ),
                                              ],
                                            ),
                                            16.ph,
                                            AppTextFormField(
                                              controller: nameController,
                                              labelText: 'Name',
                                              textInputAction:
                                                  TextInputAction.next,
                                            ),
                                            16.ph,

                                            AppTextFormField(
                                              controller: addrController,
                                              labelText: 'Address',

                                              textInputAction:
                                                  TextInputAction.next,
                                            ),
                                            16.ph,

                                            AppTextFormField(
                                              controller: phoneController,
                                              labelText: 'Phone',
                                              keyboardType: TextInputType.phone,
                                              textInputAction:
                                                  TextInputAction.done,
                                            ),
                                            26.ph,
                                            AppButton(
                                              onPressed: () {
                                                controller.editAddress(
                                                  address,
                                                  ShippingAddress(
                                                    id: address.id,
                                                    name: nameController.text,
                                                    address:
                                                        addrController.text,
                                                    phone: phoneController.text,
                                                    isPrimary:
                                                        address.isPrimary,
                                                  ),
                                                );
                                                Navigator.of(context).pop();
                                              },
                                              text: 'Save',
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () =>
                                      controller.deleteAddress(address),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.check_circle,
                                    color: address.isPrimary
                                        ? Colors.green
                                        : Colors.grey,
                                  ),
                                  tooltip: 'Set as Primary',
                                  onPressed: () =>
                                      controller.selectPrimaryAddress(address),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
            }),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Add Address'),
              style: ElevatedButton.styleFrom(
                backgroundColor: context.kPrimaryColor,
                foregroundColor: context.kColorOnPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 14,
                ),
                textStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () async {
                final nameController = TextEditingController();
                final addrController = TextEditingController();
                final phoneController = TextEditingController();
                await showAppModalBottomSheet(
                  context: context,
                  isDismissible: true,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            AppText(
                              text: 'Add Address',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: context.kTextColor,
                            ),
                            Spacer(),
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: Icon(Icons.close),
                            ),
                          ],
                        ),
                        20.ph,
                        AppTextFormField(
                          controller: nameController,
                          labelText: 'Name',
                          textInputAction: TextInputAction.next,
                        ),
                        20.ph,
                        AppTextFormField(
                          controller: addrController,
                          labelText: 'Address',
                          textInputAction: TextInputAction.next,
                        ),
                        20.ph,
                        AppTextFormField(
                          controller: phoneController,
                          labelText: 'Phone',
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.done,
                        ),
                        28.ph,
                        AppButton(
                          onPressed: () {
                            Get.find<ShippingAddressController>().addAddress(
                              ShippingAddress(
                                id: DateTime.now().millisecondsSinceEpoch
                                    .toString(),
                                name: nameController.text,
                                address: addrController.text,
                                phone: phoneController.text,
                                isPrimary: false,
                              ),
                            );
                            Navigator.of(context).pop();
                          },
                          text: 'Add',
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
