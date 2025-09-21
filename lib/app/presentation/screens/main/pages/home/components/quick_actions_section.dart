import 'package:corehive_store/app/presentation/screens/main/controllers/nav_controller.dart';
import 'package:flutter/material.dart';
import 'package:corehive_store/app/config/theme/color_extension.dart';
import 'package:corehive_store/app/config/extension/space_extension.dart';
import 'package:corehive_store/app/presentation/widgets/app_text.dart';
import 'package:corehive_store/app/presentation/widgets/app_card.dart';
import 'package:get/instance_manager.dart';

class QuickActionData {
  final String title;
  final IconData icon;
  final Color color;

  QuickActionData({
    required this.title,
    required this.icon,
    required this.color,
  });
}

class QuickActionsSection extends StatelessWidget {
  QuickActionsSection({super.key});

  final List<QuickActionData> actions = [
    QuickActionData(
      title: 'Orders',
      icon: Icons.local_shipping,
      color: Color(0xFF4ECDC4),
      // Will be set in build method
    ),
    QuickActionData(
      title: 'Support',
      icon: Icons.support_agent,
      color: Color(0xFF45B7D1),
    ),
    QuickActionData(
      title: 'Wishlist',
      icon: Icons.favorite_border,
      color: Color(0xFFFF6B6B),
    ),
    QuickActionData(
      title: 'Coupons',
      icon: Icons.local_offer,
      color: Color(0xFFFF9F43),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: 'Quick Actions',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: context.kTextColor,
          ),

          12.ph,

          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 360;
              if (isNarrow) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Expanded(child: _buildActionCard(context, 0)),
                        8.pw,
                        Expanded(child: _buildActionCard(context, 1)),
                      ],
                    ),
                    8.ph,
                    Row(
                      children: [
                        Expanded(child: _buildActionCard(context, 2)),
                        8.pw,
                        Expanded(child: _buildActionCard(context, 3)),
                      ],
                    ),
                  ],
                );
              }
              return Row(
                children: actions.map((action) {
                  return Expanded(
                    child: _buildActionCard(context, actions.indexOf(action)),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(BuildContext context, int index) {
    final action = actions[index];
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: AppCard(
        backgroundColor: Colors.white,
        borderColor: Colors.transparent,
        padding: const EdgeInsets.all(16),
        onTap: () {
          // Handle action tap
          _handleActionTap(context, index);
        },
        child: Column(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: action.color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(action.icon, color: action.color, size: 24),
            ),

            8.ph,

            AppText(
              text: action.title,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: context.kTextColor,
              centerText: true,
            ),
          ],
        ),
      ),
    );
  }

  void _handleActionTap(BuildContext context, int index) {
    // Handle different actions
    switch (index) {
      case 0:
        Get.find<NavController>().changeTab(1);
        break;
      case 1:
        // Open support chat
        break;
      case 2:
        // Navigate to wishlist
        break;
      case 3:
        // Navigate to coupons
        break;
    }
  }
}
