import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../widgets/app_network_image.dart';

class HomeBanner extends StatefulWidget {
  const HomeBanner({super.key});

  @override
  State<HomeBanner> createState() => _HomeBannerState();
}

class _HomeBannerState extends State<HomeBanner> {
  final PageController _controller = PageController();
  final List<String> banners = [
    "https://images.unsplash.com/photo-1607082349566-187342175e2f",
    // iPhone 12 Pro flatlay
    "https://images.unsplash.com/photo-1603899122634-f86d7a2d94da",
    // iPhone on desk
    "https://images.unsplash.com/photo-1600488994374-4f67f34d8d61",
    // iPhone close-up
    "https://images.unsplash.com/photo-1603993097397-89d1b50b2b2d",
    // iPhone with gradient background
    "https://images.unsplash.com/photo-1606813907291-1f9a51d0c8d2",
    // iPhone night mode
    "https://images.unsplash.com/photo-1612444530582-f92ef2e2c57d",
    // iPhone flat design
    "https://images.unsplash.com/photo-1598327105666-5b89351aff97",
    // iPhone on table
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: banners.length,
            itemBuilder: (context, index) => _banner(banners[index]),
          ),
          Positioned(
            bottom: 12,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _controller,
                count: banners.length,
                effect: ExpandingDotsEffect(
                  dotHeight: 8,
                  dotWidth: 8,
                  activeDotColor: Theme.of(context).primaryColor,
                  dotColor: Colors.white.withOpacity(0.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _banner(String url) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: AppNetworkImage(
          imageUrl: url,
          width: double.infinity,
          height: 160,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
