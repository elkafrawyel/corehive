import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:corehive_store/app/config/theme/color_extension.dart';
import 'package:corehive_store/app/config/extension/space_extension.dart';
import 'package:corehive_store/app/presentation/widgets/app_text.dart';
import 'package:corehive_store/app/presentation/widgets/app_button.dart';
import 'package:corehive_store/app/presentation/widgets/app_network_image.dart';

class BannerData {
  final String imageUrl;
  final String title;
  final String subtitle;
  final String buttonText;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  BannerData({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    this.backgroundColor,
    this.onTap,
  });
}

class HomeBanner extends StatefulWidget {
  const HomeBanner({super.key});

  @override
  State<HomeBanner> createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<BannerData> banners = [
    BannerData(
      imageUrl: "https://images.unsplash.com/photo-1607082349566-187342175e2f",
      title: "Summer Sale",
      subtitle: "Up to 70% off on all items",
      buttonText: "Shop Now",
      backgroundColor: const Color(0xFFFF6B6B),
    ),
    BannerData(
      imageUrl: "https://images.unsplash.com/photo-1603899122634-f86d7a2d94da",
      title: "New Collection",
      subtitle: "Fresh styles for this season",
      buttonText: "Explore",
      backgroundColor: const Color(0xFF4ECDC4),
    ),
    BannerData(
      imageUrl: "https://images.unsplash.com/photo-1600488994374-4f67f34d8d61",
      title: "Free Shipping",
      subtitle: "On orders over \$50",
      buttonText: "Learn More",
      backgroundColor: const Color(0xFF45B7D1),
    ),
    BannerData(
      imageUrl: "https://images.unsplash.com/photo-1603993097397-89d1b50b2b2d",
      title: "Limited Time",
      subtitle: "Flash deals ending soon",
      buttonText: "Grab Deal",
      backgroundColor: const Color(0xFFFF9F43),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.page != null) {
        setState(() {
          _currentIndex = _controller.page!.round();
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final bannerHeight = width > 400 ? 200.0 : 160.0;
    return Container(
      height: bannerHeight,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        children: [
          // Banner carousel
          PageView.builder(
            controller: _controller,
            itemCount: banners.length,
            itemBuilder: (context, index) => _buildBannerCard(context, banners[index]),
          ),
          
          // Page indicators
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _controller,
                count: banners.length,
                effect: ExpandingDotsEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  activeDotColor: context.kPrimaryColor,
                  dotColor: Colors.white.withValues(alpha: 0.5),
                  spacing: 8,
                ),
              ),
            ),
          ),
          
          // Navigation arrows
          Positioned(
            left: 8,
            top: 0,
            bottom: 0,
            child: Center(
              child: _buildNavButton(
                context,
                icon: Icons.arrow_back_ios,
                onTap: () {
                  if (_currentIndex > 0) {
                    _controller.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
              ),
            ),
          ),
          
          Positioned(
            right: 8,
            top: 0,
            bottom: 0,
            child: Center(
              child: _buildNavButton(
                context,
                icon: Icons.arrow_forward_ios,
                onTap: () {
                  if (_currentIndex < banners.length - 1) {
                    _controller.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBannerCard(BuildContext context, BannerData banner) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Background image
            Positioned.fill(
              child: AppNetworkImage(
                imageUrl: banner.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            
            // Gradient overlay
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.black.withValues(alpha: 0.3),
                      Colors.black.withValues(alpha: 0.1),
                    ],
                  ),
                ),
              ),
            ),
            
            // Content
            Positioned(
              left: 20,
              right: 20,
              bottom: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    text: banner.title,
                    fontSize: MediaQuery.sizeOf(context).width > 400 ? 24 : 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  8.ph,
                  AppText(
                    text: banner.subtitle,
                    fontSize: MediaQuery.sizeOf(context).width > 400 ? 14 : 12,
                    color: Colors.white.withValues(alpha: 0.9),
                    maxLines: 2,
                  ),
                  16.ph,
                  SizedBox(
                    width: 120,
                    child: AppButton(
                      text: banner.buttonText,
                      fontSize: MediaQuery.sizeOf(context).width > 400 ? 14 : 12,
                      backgroundColor: context.kPrimaryColor,
                      textColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      onPressed: banner.onTap ?? () {},
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavButton(
    BuildContext context, {
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Icon(
            icon,
            color: context.kTextColor,
            size: 18,
          ),
        ),
      ),
    );
  }
}
