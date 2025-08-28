import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import '../constants/app_colors.dart';
import '../constants/app_text_theme.dart';
import '../controllers/root_controller.dart';
import '../screens/processing_screen.dart';

class BannerSlider extends StatefulWidget {
  final bool showCloseButton;
  final VoidCallback? onClose;

  const BannerSlider({super.key, this.showCloseButton = false, this.onClose});

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider>
    with TickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  Timer? _timer;
  late AnimationController _scaleController;
  late Animation<double> _scaleAnimation;
  final RootController rootController = Get.find<RootController>();

  final List<BannerItem> _banners = [
    BannerItem(
      title: 'banner_title_1',
      subtitle: 'banner_subtitle_1',
      icon: Icons.auto_awesome_rounded,
      gradient: LinearGradient(
        colors: [AppColors.mintGreen, AppColors.mintGreen.withOpacity(0.8)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    BannerItem(
      title: 'banner_title_2',
      subtitle: 'banner_subtitle_2',
      icon: Icons.bookmark_border,
      gradient: LinearGradient(
        colors: [AppColors.warmOrange, AppColors.warmOrange.withOpacity(0.8)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    BannerItem(
      title: 'banner_title_3',
      subtitle: 'banner_subtitle_3',
      icon: Icons.restaurant_rounded,
      gradient: LinearGradient(
        colors: [AppColors.info, AppColors.info.withOpacity(0.8)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
    _startAutoScroll();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      if (mounted) {
        if (_currentPage < _banners.length - 1) {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        } else {
          _pageController.animateToPage(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  void _onBannerTap(int index) {
    // Add scale animation
    _scaleController.forward().then((_) {
      _scaleController.reverse();
    });

    // Handle banner tap - you can add navigation or other actions here
    switch (index) {
      case 0:
        // Navigate to AI features or show more info
        final aiTitle =
            rootController.currentLanguage == 'en'
                ? 'AI Features'
                : 'ویژگی‌های هوشمند';
        final aiMessage =
            rootController.currentLanguage == 'en'
                ? 'Discover our advanced AI-powered recipe generation!'
                : 'ویژگی‌های پیشرفته تولید دستور پخت هوشمند ما را کشف کنید!';
        Get.snackbar(
          aiTitle,
          aiMessage,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.mintGreen.withOpacity(0.9),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
        break;
      case 1:
        // Navigate to saved recipes
        final savedTitle =
            rootController.currentLanguage == 'en'
                ? 'Saved Recipes'
                : 'دستور پخت‌های ذخیره شده';
        final savedMessage =
            rootController.currentLanguage == 'en'
                ? 'View and manage your favorite recipes!'
                : 'دستور پخت‌های مورد علاقه خود را مشاهده و مدیریت کنید!';
        Get.snackbar(
          savedTitle,
          savedMessage,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.warmOrange.withOpacity(0.9),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
        break;
      case 2:
        // Navigate to quick meals
        final quickTitle =
            rootController.currentLanguage == 'en'
                ? 'Quick Meals'
                : 'غذاهای سریع';
        final quickMessage =
            rootController.currentLanguage == 'en'
                ? 'Find recipes that fit your busy schedule!'
                : 'دستور پخت‌هایی را پیدا کنید که با برنامه شلوغ شما سازگار باشد!';
        Get.snackbar(
          quickTitle,
          quickMessage,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppColors.info.withOpacity(0.9),
          colorText: Colors.white,
          duration: const Duration(seconds: 3),
        );
        break;
    }
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
      child: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  onPageChanged: _onPageChanged,
                  itemCount: _banners.length,

                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: GestureDetector(
                        onTap: () => _onBannerTap(index),
                        child: ScaleTransition(
                          scale: _scaleAnimation,
                          child: _buildBannerCard(_banners[index]),
                        ),
                      ),
                    );
                  },
                ),
                if (widget.showCloseButton)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: widget.onClose,
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _buildPageIndicator(),
        ],
      ),
    );
  }

  Widget _buildBannerCard(BannerItem banner) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            banner.gradient.colors.first.withOpacity(0.4),
            banner.gradient.colors.last.withOpacity(0.3),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
        boxShadow: [
          BoxShadow(
            color: banner.gradient.colors.first.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Single language title
                  Text(
                    banner.title.tr,
                    style: AppTextTheme.titleLarge.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  // Single language subtitle
                  Text(
                    banner.subtitle.tr,
                    style: AppTextTheme.bodyMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white.withOpacity(0.9),
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: Colors.white.withOpacity(0.3),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Icon(banner.icon, color: Colors.white, size: 30),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageIndicator() {
    final currentBanner = _banners[_currentPage];
    final primaryColor = currentBanner.gradient.colors.first;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _banners.length,
        (index) => Container(
          width: _currentPage == index ? 12 : 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            color:
                _currentPage == index
                    ? primaryColor
                    : primaryColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(4),
            boxShadow:
                _currentPage == index
                    ? [
                      BoxShadow(
                        color: primaryColor.withOpacity(0.4),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ]
                    : null,
          ),
        ),
      ),
    );
  }
}

class BannerItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final LinearGradient gradient;

  BannerItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.gradient,
  });
}
