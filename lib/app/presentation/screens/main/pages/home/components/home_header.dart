import 'package:flutter/material.dart';
import 'package:corehive_store/app/config/theme/color_extension.dart';
import 'package:corehive_store/app/config/extension/space_extension.dart';
import 'package:corehive_store/app/presentation/widgets/app_text.dart';
import 'package:corehive_store/app/presentation/widgets/app_card.dart';
import 'package:corehive_store/app/presentation/widgets/app_network_image.dart';
import 'package:icons_plus/icons_plus.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      decoration: BoxDecoration(
        color: context.kBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Top row with greeting and actions
          Row(
            children: [
              // User greeting and avatar
              Expanded(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: context.kPrimaryColor.withValues(
                        alpha: 0.1,
                      ),
                      child: const AppNetworkImage(
                        imageUrl:
                            'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e',
                        width: 40,
                        height: 40,
                      ),
                    ),
                    12.pw,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            text: 'Good Morning!',
                            fontSize: 12,
                            color: context.kHintTextColor,
                          ),
                          2.ph,
                          AppText(
                            text: 'John Doe',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: context.kTextColor,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Action buttons
              Row(
                children: [
                  _buildActionButton(
                    context,
                    icon: Iconsax.notification_outline,
                    onTap: () {},
                    badge: true,
                    badgeCount: 10,
                  ),
                  8.pw,
                  _buildActionButton(
                    context,
                    icon: Iconsax.heart_outline,
                    onTap: () {},
                  ),
                  8.pw,
                  _buildActionButton(
                    context,
                    icon: Iconsax.bag_outline,
                    onTap: () {},
                    badge: true,
                    badgeCount: 3,
                  ),
                ],
              ),
            ],
          ),

          16.ph,

          // Modern Search Bar
          Container(
            decoration: BoxDecoration(
              color: context.kTextFieldColor,
              borderRadius: BorderRadius.circular(32),
              // more rounded for pill shape
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  color: context.kHintTextColor.withValues(alpha: 0.7),
                  size: 20,
                ),
                10.pw,
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search products, brands...',
                      hintStyle: TextStyle(
                        color: context.kHintTextColor.withValues(alpha: 0.6),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    style: TextStyle(
                      color: context.kTextColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                12.pw,
                Container(
                  decoration: BoxDecoration(
                    color: context.kPrimaryColor,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: context.kPrimaryColor.withOpacity(0.3),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.qr_code_scanner,
                        color: Colors.white,
                        size: 16,
                      ),
                      6.pw,
                      AppText(
                        text: 'Scan',
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          12.ph,

          // Quick stats row
          Row(
            children: [
              Expanded(
                child: _buildQuickStat(
                  context,
                  icon: Iconsax.location_outline,
                  title: 'Location',
                  subtitle: 'New York, NY',
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 8),
                width: 1,
                height: 30,
                color: context.kHintTextColor.withValues(alpha: 0.2),
              ),
              Expanded(
                child: _buildQuickStat(
                  context,
                  icon: Iconsax.truck_outline,
                  title: 'Free Delivery',
                  subtitle: 'On orders over \$50',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required VoidCallback onTap,
    bool badge = false,
    int badgeCount = 0,
  }) {
    return Stack(
      children: [
        AppCard(
          backgroundColor: context.kTextFieldColor,
          borderColor: Colors.transparent,
          padding: const EdgeInsets.all(8),
          onTap: onTap,
          child: Icon(icon, color: context.kTextColor, size: 20),
        ),
        if (badge)
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: context.kErrorColor,
                shape: BoxShape.circle,
              ),
              constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
              child: AppText(
                text: badgeCount > 0 ? badgeCount.toString() : '',
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildQuickStat(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Row(
      children: [
        Icon(icon, color: context.kPrimaryColor, size: 16),
        8.pw,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppText(
                text: title,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: context.kTextColor,
              ),
              2.ph,
              AppText(
                text: subtitle,
                fontSize: 10,
                color: context.kHintTextColor,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
