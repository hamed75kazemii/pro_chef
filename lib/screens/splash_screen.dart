import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_theme.dart';
import '../constants/splash_constants.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _iconController;
  late AnimationController _textController;
  late AnimationController _particleController;

  late Animation<double> _iconAnimation;
  late Animation<double> _textAnimation;
  late Animation<double> _particleAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startAnimations();
  }

  void _initializeAnimations() {
    // Initialize animation controllers
    _iconController = AnimationController(
      duration: SplashConstants.iconAnimationDuration,
      vsync: this,
    );

    _textController = AnimationController(
      duration: SplashConstants.textAnimationDuration,
      vsync: this,
    );

    _particleController = AnimationController(
      duration: SplashConstants.particleAnimationDuration,
      vsync: this,
    );

    // Initialize animations
    _iconAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _iconController, curve: Curves.elasticOut),
    );

    _textAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeOutCubic),
    );

    _particleAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _particleController, curve: Curves.easeInOut),
    );
  }

  void _startAnimations() async {
    // Start particle animation with continuous movement
    _particleController.repeat();

    // Start icon animation
    await Future.delayed(SplashConstants.iconDelay);
    _iconController.forward();

    // Start text animation
    await Future.delayed(SplashConstants.textDelay);
    _textController.forward();

    // Navigate to home screen after animations
    await Future.delayed(SplashConstants.navigationDelay);
    Get.off(() => const HomeScreen());
  }

  @override
  void dispose() {
    _iconController.dispose();
    _textController.dispose();

    _particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const _BackgroundGradient(),
          _FloatingParticles(animation: _particleAnimation),
          _MainContent(
            iconAnimation: _iconAnimation,
            textAnimation: _textAnimation,
          ),
        ],
      ),
    );
  }
}

// Background gradient widget
class _BackgroundGradient extends StatelessWidget {
  const _BackgroundGradient();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.mintGreen.withValues(
              alpha: SplashConstants.backgroundAlpha,
            ),
            AppColors.warmOrange.withValues(
              alpha: SplashConstants.backgroundAlpha,
            ),
            AppColors.pureWhite,
          ],
        ),
      ),
    );
  }
}

// Floating particles widget
class _FloatingParticles extends StatelessWidget {
  final Animation<double> animation;

  const _FloatingParticles({required this.animation});

  Widget _buildParticle(
    double left,
    double top,
    IconData icon,
    Color color,
    Animation<double> animation,
  ) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        // Create variation based on particle position
        final variation = (left + top) % 3;
        final movementDirection =
            variation == 0 ? 1 : (variation == 1 ? -1 : 0.5);

        return Positioned(
          left: left + (animation.value * 10 * movementDirection),
          top:
              top +
              (animation.value *
                  SplashConstants.particleMovement *
                  movementDirection),
          child: Opacity(
            opacity:
                SplashConstants.particleBaseOpacity +
                (SplashConstants.particleMaxOpacity *
                    (0.5 + 0.5 * animation.value)),
            child: Transform.rotate(
              angle: animation.value * 0.5,
              child: Icon(
                icon,
                color: color,
                size:
                    SplashConstants.particleBaseSize +
                    (SplashConstants.particleMaxSize * animation.value),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:
          SplashConstants.particles.map((particle) {
            return _buildParticle(
              particle['left'],
              particle['top'],
              particle['icon'],
              particle['color'],
              animation,
            );
          }).toList(),
    );
  }
}

// Main content widget
class _MainContent extends StatelessWidget {
  final Animation<double> iconAnimation;
  final Animation<double> textAnimation;

  const _MainContent({
    required this.iconAnimation,
    required this.textAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: SplashConstants.topSpacing),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _AnimatedChefIcon(animation: iconAnimation),
                  const SizedBox(height: SplashConstants.titleSpacing),
                  _AnimatedTitle(animation: textAnimation),
                ],
              ),
            ),
          ),
          _LoadingSection(animation: textAnimation),
          const SizedBox(height: SplashConstants.bottomSpacing),
        ],
      ),
    );
  }
}

// Animated chef icon widget
class _AnimatedChefIcon extends StatelessWidget {
  final Animation<double> animation;

  const _AnimatedChefIcon({required this.animation});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.scale(
          scale: animation.value,
          child: Container(
            width: SplashConstants.iconSize,
            height: SplashConstants.iconSize,
            decoration: BoxDecoration(
              gradient: SweepGradient(
                startAngle: 0,
                endAngle: 2 * 3.141592653589793,
                transform: GradientRotation(
                  animation.value * 2 * 3.141592653589793,
                ),
                colors: [
                  AppColors.mintGreen,
                  AppColors.warmOrange,
                  AppColors.mintGreen,
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
              borderRadius: BorderRadius.circular(
                SplashConstants.iconBorderRadius,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.warmOrange.withValues(
                    alpha: SplashConstants.iconShadowAlpha,
                  ),
                  blurRadius: SplashConstants.iconShadowBlur,
                  spreadRadius: SplashConstants.iconShadowSpread,
                ),
                BoxShadow(
                  color: AppColors.mintGreen.withValues(
                    alpha: SplashConstants.iconShadowAlphaSecondary,
                  ),
                  blurRadius: SplashConstants.iconShadowBlurSecondary,
                  spreadRadius: SplashConstants.iconShadowSpreadSecondary,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(SplashConstants.iconPadding),
              child: Image.asset(
                'assets/icon/chef_pro.png',
                color: AppColors.pureWhite,
              ),
            ),
          ),
        );
      },
    );
  }
}

// Animated title widget
class _AnimatedTitle extends StatelessWidget {
  final Animation<double> animation;

  const _AnimatedTitle({required this.animation});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 40 * (1 - animation.value)),
          child: Opacity(
            opacity: animation.value,
            child: Column(
              children: [
                ShaderMask(
                  shaderCallback:
                      (bounds) =>
                          AppColors.primaryGradient.createShader(bounds),
                  child: Text(
                    SplashConstants.appTitle,
                    style: AppTextTheme.splashTitle.copyWith(
                      color: AppColors.pureWhite,
                      shadows: [
                        Shadow(
                          color: AppColors.textPrimary.withValues(
                            alpha: SplashConstants.titleShadowAlpha,
                          ),
                          offset: SplashConstants.titleShadowOffset,
                          blurRadius: SplashConstants.titleShadowBlur,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: SplashConstants.subtitleSpacing),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.warmOrange.withValues(
                      alpha: SplashConstants.subtitleBackgroundAlpha,
                    ),
                    borderRadius: BorderRadius.circular(
                      SplashConstants.subtitleBorderRadius,
                    ),
                    border: Border.all(
                      color: AppColors.warmOrange.withValues(
                        alpha: SplashConstants.subtitleBorderAlpha,
                      ),
                      width: SplashConstants.subtitleBorderWidth,
                    ),
                  ),
                  child: Text(
                    SplashConstants.appSubtitle,
                    style: AppTextTheme.splashSubtitle.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Loading section widget
class _LoadingSection extends StatelessWidget {
  final Animation<double> animation;

  const _LoadingSection({required this.animation});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Opacity(
          opacity: animation.value,
          child: Column(
            children: [
              const SizedBox(height: SplashConstants.loadingSpacing),
              Text(
                SplashConstants.loadingText,
                style: AppTextTheme.loadingText.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                SplashConstants.loadingSubText,
                style: AppTextTheme.loadingSubText.copyWith(
                  color: AppColors.textLight,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
