import 'package:corehive_store/app/config/theme/color_extension.dart';
import 'package:flutter/material.dart';
import '../../../../../../data/models/shipping_address_model.dart';
import '../../../../../widgets/app_card.dart';
import '../../../../../widgets/app_text.dart';

class ShippingAddressView extends StatelessWidget {
  final ShippingAddress address;
  final VoidCallback onChange;

  const ShippingAddressView({
    required this.address,
    required this.onChange,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      borderWidth: 1,
      borderColor: context.kPrimaryColor,
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Icon(Icons.star, color: context.kPrimaryColor),
        title: AppText(text: address.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppText(text: address.address),
            AppText(text: address.phone),
          ],
        ),
        trailing: TextButton(
          onPressed: onChange,
          child: const AppText(text: 'Change'),
        ),
      ),
    );
  }
}
