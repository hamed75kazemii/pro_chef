import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pro_chef/constants/Screen_utills.dart';
import 'package:pro_chef/screens/processing_screen.dart';
import 'package:pro_chef/usecases/appbar/home_appbar.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_theme.dart';
import '../controllers/recipe_controller.dart';
import '../controllers/root_controller.dart';
import '../widgets/banner_slider.dart';
import 'results_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RecipeController controller = Get.put(RecipeController());
  final RootController rootController = Get.find<RootController>();
  final TextEditingController _ingredientsController = TextEditingController();

  @override
  void dispose() {
    _ingredientsController.dispose();
    super.dispose();
  }

  void _generateRecipes() {
    final ingredientsText = _ingredientsController.text.trim();
    if (ingredientsText.isEmpty) {
      controller.errorMessage.value = 'please_enter_ingredients'.tr;
      return;
    }

    final ingredients =
        ingredientsText
            .split(',')
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty)
            .toList();

    controller.generateRecipes(ingredients).then((_) {
      if (controller.recipes.isNotEmpty) {
        Get.to(() => const ResultsScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.mintGreen.withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).padding.top,
                  horizontal: ScreenUtills.edgePadding,
                ),
                child: Column(
                  children: [
                    HomeAppbar(),
                    SizedBox(height: 20),
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: .2),
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: .3),
                          width: 2,
                        ),
                      ),
                      child: const Icon(
                        Icons.auto_awesome,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'what_ingredients_have'.tr,
                      style: AppTextTheme.headlineSmall.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'enter_ingredients_description'.tr,
                      style: AppTextTheme.bodyMedium.copyWith(
                        color: Colors.white.withOpacity(0.9),
                        height: 1.6,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),

            // Banner Slider
            const BannerSlider(),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton.icon(
                onPressed: () {
                  Get.to(() => const ProcessingScreen());
                },
                icon: const Icon(Icons.restaurant_rounded, color: Colors.white),
                label: Text(
                  'what_to_cook'.tr,
                  style: AppTextTheme.buttonText.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mintGreen,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Welcome Card with enhanced design
                  const SizedBox(height: 16),

                  // Ingredients Input with improved design
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      AppColors.mintGreen.withOpacity(0.1),
                                      AppColors.mintGreen.withOpacity(0.2),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.shopping_basket_rounded,
                                  color: AppColors.mintGreen,
                                  size: 28,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'ingredients'.tr,
                                      style: AppTextTheme.titleMedium.copyWith(
                                        color: AppColors.textSecondary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'separate_ingredients'.tr,
                                      style: AppTextTheme.bodySmall.copyWith(
                                        color: AppColors.textLight,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: TextField(
                              textAlignVertical: TextAlignVertical.top,
                              textAlign:
                                  rootController.currentLanguage == 'fa'
                                      ? TextAlign.right
                                      : TextAlign.left,
                              textDirection:
                                  rootController.currentLanguage == 'fa'
                                      ? TextDirection.rtl
                                      : TextDirection.ltr,
                              controller: _ingredientsController,
                              decoration: InputDecoration(
                                hintText: 'ingredients_hint'.tr,
                                hintStyle: AppTextTheme.bodyMedium.copyWith(
                                  color: AppColors.textLight,
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.all(16),
                              ),
                              maxLines: 4,
                              style: AppTextTheme.bodyMedium.copyWith(
                                color: AppColors.textPrimary,
                              ),
                              onChanged: (_) => controller.clearError(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Filter Dropdown with enhanced design
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      AppColors.warmOrange.withOpacity(0.1),
                                      AppColors.warmOrange.withOpacity(0.2),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.filter_list_rounded,
                                  color: AppColors.warmOrange,
                                  size: 28,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Text(
                                'dietary_preferences'.tr,
                                style: AppTextTheme.titleMedium.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Obx(() {
                            final selected = controller.selectedFilter.value;
                            return GestureDetector(
                              onTap: () async {
                                final value = await showModalBottomSheet<
                                  String
                                >(
                                  context: context,
                                  backgroundColor: Colors.transparent,
                                  isScrollControlled: true,
                                  builder: (context) {
                                    return Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                          0.7,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).cardColor,
                                        borderRadius:
                                            const BorderRadius.vertical(
                                              top: Radius.circular(20),
                                            ),
                                      ),
                                      child: SafeArea(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              width: 40,
                                              height: 4,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 12,
                                                  ),
                                              decoration: BoxDecoration(
                                                color:
                                                    Theme.of(
                                                              context,
                                                            ).brightness ==
                                                            Brightness.dark
                                                        ? Colors.grey[600]
                                                        : AppColors.charcoal,
                                                borderRadius:
                                                    BorderRadius.circular(2),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(16),
                                              child: Text(
                                                'select_dietary_preference'.tr,
                                                style: AppTextTheme.titleMedium
                                                    .copyWith(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color:
                                                          Theme.of(
                                                                    context,
                                                                  ).brightness ==
                                                                  Brightness
                                                                      .dark
                                                              ? Colors.white
                                                              : AppColors
                                                                  .textPrimary,
                                                    ),
                                              ),
                                            ),
                                            Expanded(
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  children:
                                                      controller.availableFiltersTranslated.map((
                                                        filter,
                                                      ) {
                                                        final isSelected =
                                                            selected == filter;
                                                        return ListTile(
                                                          leading: Container(
                                                            padding:
                                                                const EdgeInsets.all(
                                                                  8,
                                                                ),
                                                            decoration: BoxDecoration(
                                                              color:
                                                                  isSelected
                                                                      ? AppColors
                                                                          .warmOrange
                                                                          .withOpacity(
                                                                            0.1,
                                                                          )
                                                                      : (Theme.of(
                                                                                context,
                                                                              ).brightness ==
                                                                              Brightness.dark
                                                                          ? const Color(
                                                                            0xFF2A2A2A,
                                                                          )
                                                                          : AppColors
                                                                              .inputBackground),
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    8,
                                                                  ),
                                                            ),
                                                            child: Icon(
                                                              controller
                                                                  .getFilterIcon(
                                                                    filter,
                                                                  ),
                                                              color:
                                                                  isSelected
                                                                      ? AppColors
                                                                          .warmOrange
                                                                      : (Theme.of(
                                                                                context,
                                                                              ).brightness ==
                                                                              Brightness.dark
                                                                          ? Colors
                                                                              .grey[400]
                                                                          : AppColors
                                                                              .iconLight),
                                                              size: 20,
                                                            ),
                                                          ),
                                                          title: Text(
                                                            filter.isEmpty
                                                                ? 'no_preference'
                                                                    .tr
                                                                : filter,
                                                            style: AppTextTheme.bodyMedium.copyWith(
                                                              fontWeight:
                                                                  isSelected
                                                                      ? FontWeight
                                                                          .bold
                                                                      : FontWeight
                                                                          .normal,
                                                              color:
                                                                  isSelected
                                                                      ? AppColors
                                                                          .warmOrange
                                                                      : (Theme.of(
                                                                                context,
                                                                              ).brightness ==
                                                                              Brightness.dark
                                                                          ? Colors
                                                                              .white
                                                                          : AppColors
                                                                              .textPrimary),
                                                            ),
                                                          ),
                                                          trailing:
                                                              isSelected
                                                                  ? const Icon(
                                                                    Icons
                                                                        .check_circle,
                                                                    color:
                                                                        AppColors
                                                                            .warmOrange,
                                                                  )
                                                                  : null,
                                                          onTap: () {
                                                            Navigator.pop(
                                                              context,
                                                              filter,
                                                            );
                                                          },
                                                        );
                                                      }).toList(),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 20),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                                if (value != null) {
                                  controller.setFilter(value);
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 20,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      Theme.of(context).brightness ==
                                              Brightness.dark
                                          ? const Color(0xFF2A2A2A)
                                          : AppColors.inputBackground,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color:
                                        Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.grey.withOpacity(0.3)
                                            : AppColors.inputBorder.withOpacity(
                                              0.5,
                                            ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: AppColors.warmOrange.withOpacity(
                                          0.1,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Icon(
                                        selected.isEmpty
                                            ? Icons.restaurant_rounded
                                            : controller.getFilterIcon(
                                              selected,
                                            ),
                                        color: AppColors.warmOrange,
                                        size: 20,
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Expanded(
                                      child: Text(
                                        selected.isEmpty
                                            ? 'select_dietary_preference'.tr
                                            : selected,
                                        style: AppTextTheme.bodyMedium.copyWith(
                                          color:
                                              selected.isEmpty
                                                  ? (Theme.of(
                                                            context,
                                                          ).brightness ==
                                                          Brightness.dark
                                                      ? Colors.grey[400]
                                                      : AppColors.textLight)
                                                  : (Theme.of(
                                                            context,
                                                          ).brightness ==
                                                          Brightness.dark
                                                      ? Colors.white
                                                      : AppColors.textPrimary),
                                          fontWeight:
                                              selected.isEmpty
                                                  ? FontWeight.normal
                                                  : AppTextTheme.medium,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_down_rounded,
                                      color:
                                          Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Colors.grey[400]
                                              : AppColors.iconLight,
                                      size: 24,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Generate Button with enhanced design
                  Obx(
                    () => Container(
                      decoration: BoxDecoration(
                        gradient:
                            controller.isLoading.value
                                ? null
                                : const LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    AppColors.mintGreen,
                                    AppColors.warmOrange,
                                  ],
                                ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow:
                            controller.isLoading.value
                                ? null
                                : [
                                  BoxShadow(
                                    color: AppColors.warmOrange.withOpacity(
                                      0.3,
                                    ),
                                    blurRadius: 15,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                      ),
                      child: ElevatedButton(
                        onPressed:
                            controller.isLoading.value
                                ? null
                                : _generateRecipes,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              controller.isLoading.value
                                  ? AppColors.inputBorder
                                  : Colors.transparent,
                          foregroundColor: AppColors.pureWhite,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                          shadowColor: Colors.transparent,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (controller.isLoading.value)
                              const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                            else
                              const Icon(Icons.auto_awesome_rounded, size: 24),
                            const SizedBox(width: 12),
                            Text(
                              controller.isLoading.value
                                  ? 'generating_recipes'.tr
                                  : 'suggest_recipes'.tr,
                              style: AppTextTheme.buttonText.copyWith(
                                color: AppColors.pureWhite,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Error Message with improved design
                  Obx(
                    () =>
                        controller.errorMessage.value.isNotEmpty
                            ? Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: AppColors.error.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: AppColors.error.withOpacity(0.2),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                      color: AppColors.error.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(
                                      Icons.error_outline_rounded,
                                      color: AppColors.error,
                                      size: 20,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Text(
                                      controller.errorMessage.value,
                                      style: AppTextTheme.error.copyWith(
                                        color: AppColors.error,
                                        fontWeight: AppTextTheme.medium,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                            : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
