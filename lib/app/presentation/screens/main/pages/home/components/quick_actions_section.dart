import 'package:flutter/material.dart';
import 'package:corehive_store/app/config/theme/color_extension.dart';
import 'package:corehive_store/app/config/extension/space_extension.dart';
import 'package:corehive_store/app/presentation/widgets/app_text.dart';
import 'package:corehive_store/app/presentation/widgets/app_card.dart';

class QuickActionData {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  QuickActionData({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });
}

class QuickActionsSection extends StatelessWidget {
  QuickActionsSection({super.key});

  final List<QuickActionData> actions = [
    QuickActionData(
      title: 'Orders',
      icon: Icons.local_shipping,
      color: Color(0xFF4ECDC4),
      onTap: () {}, // Will be set in build method
    ),
    QuickActionData(
      title: 'Support',
      icon: Icons.support_agent,
      color: Color(0xFF45B7D1),
      onTap: () {},
    ),
    QuickActionData(
      title: 'Wishlist',
      icon: Icons.favorite_border,
      color: Color(0xFFFF6B6B),
      onTap: () {},
    ),
    QuickActionData(
      title: 'Coupons',
      icon: Icons.local_offer,
      color: Color(0xFFFF9F43),
      onTap: () {},
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
                        Expanded(child: _buildActionCard(context, actions[0])),
                        8.pw,
                        Expanded(child: _buildActionCard(context, actions[1])),
                      ],
                    ),
                    8.ph,
                    Row(
                      children: [
                        Expanded(child: _buildActionCard(context, actions[2])),
                        8.pw,
                        Expanded(child: _buildActionCard(context, actions[3])),
                      ],
                    ),
                  ],
                );
              }
              return Row(
                children: actions.map((action) {
                  return Expanded(
                    child: _buildActionCard(context, action),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard(BuildContext context, QuickActionData action) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: AppCard(
        backgroundColor: Colors.white,
        borderColor: Colors.transparent,
        padding: const EdgeInsets.all(16),
        onTap: () {
          // Handle action tap
          _handleActionTap(context, action.title);
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
              child: Icon(
                action.icon,
                color: action.color,
                size: 24,
              ),
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

  void _handleActionTap(BuildContext context, String actionTitle) {
    // Handle different actions
    switch (actionTitle) {
      case 'Orders':
        // Navigate to order tracking
        break;
      case 'Support':
        // Open support chat
        break;
      case 'Wishlist':
        // Navigate to wishlist
        break;
      case 'Coupons':
        // Navigate to coupons
        break;
    }
  }
}
