import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_theme.dart';
import '../controllers/recipe_controller.dart';
import '../controllers/root_controller.dart';
import 'results_screen.dart';
import 'settings_screen.dart';
import 'saved_recipes_screen.dart';

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
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
        ),

        title: Image.asset('assets/icon/chef_pro.png', width: 60, height: 60),
        actions: [
          // Saved Recipes Button
          Obx(() {
            return Stack(
              children: [
                IconButton(
                  onPressed: () {
                    Get.to(() => const SavedRecipesScreen());
                  },
                  icon: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  tooltip: 'saved_recipes'.tr,
                ),
              ],
            );
          }),
          const SizedBox(width: 8),
          // Settings Button
          IconButton(
            onPressed: () {
              Get.to(() => const SettingsScreen());
            },
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.settings, color: Colors.white, size: 20),
            ),
            tooltip: 'settings'.tr,
          ),
          const SizedBox(width: 8),
        ],
        backgroundColor: AppColors.appBarBackground,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Welcome Card
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          gradient: AppColors.primaryGradient,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: const Icon(
                          Icons.auto_awesome,
                          size: 40,
                          color: AppColors.pureWhite,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'what_ingredients_have'.tr,
                        style: AppTextTheme.headlineSmall.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'enter_ingredients_description'.tr,
                        style: AppTextTheme.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Ingredients Input
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.mintGreen.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.shopping_basket,
                              color: AppColors.mintGreen,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'ingredients'.tr,
                            style: AppTextTheme.titleMedium.copyWith(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      TextField(
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
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          filled: true,
                          fillColor:
                              Theme.of(context).inputDecorationTheme.fillColor,
                        ),
                        maxLines: 5,
                        onChanged: (_) => controller.clearError(),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'separate_ingredients'.tr,
                        style: AppTextTheme.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Filter Dropdown
              Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: AppColors.warmOrange.withValues(
                                alpha: 0.1,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.filter_list,
                              color: AppColors.warmOrange,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'dietary_preferences'.tr,
                            style: AppTextTheme.titleMedium.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Obx(() {
                        final selected = controller.selectedFilter.value;
                        return GestureDetector(
                          onTap: () async {
                            final value = await showModalBottomSheet<String>(
                              context: context,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16),
                                ),
                              ),
                              builder: (context) {
                                return SafeArea(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children:
                                        controller.availableFiltersTranslated
                                            .map((filter) {
                                              final isSelected =
                                                  selected == filter;
                                              return ListTile(
                                                leading: const Icon(
                                                  Icons.restaurant,
                                                ),
                                                title: Text(
                                                  filter.isEmpty
                                                      ? 'no_preference'.tr
                                                      : filter,
                                                ),
                                                selected: isSelected,
                                                onTap: () {
                                                  Navigator.pop(
                                                    context,
                                                    filter,
                                                  );
                                                },
                                              );
                                            })
                                            .toList(),
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
                              horizontal: 16,
                              vertical: 18,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  Theme.of(
                                    context,
                                  ).inputDecorationTheme.fillColor,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: AppColors.inputBorder),
                            ),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.restaurant,
                                  color: AppColors.iconLight,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    selected.isEmpty
                                        ? 'select_dietary_preference'.tr
                                        : selected,
                                    style: AppTextTheme.bodyMedium.copyWith(
                                      color:
                                          selected.isEmpty
                                              ? AppColors.textLight
                                              : AppColors.textPrimary,
                                    ),
                                  ),
                                ),
                                const Icon(
                                  Icons.arrow_drop_down,
                                  color: AppColors.iconLight,
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
              const SizedBox(height: 24),

              // Generate Button
              Obx(
                () => ElevatedButton.icon(
                  onPressed:
                      controller.isLoading.value ? null : _generateRecipes,
                  icon:
                      controller.isLoading.value
                          ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                          : const Icon(Icons.auto_awesome),
                  label: Text(
                    controller.isLoading.value
                        ? 'generating_recipes'.tr
                        : 'suggest_recipes'.tr,
                    style: AppTextTheme.buttonText.copyWith(
                      color: AppColors.pureWhite,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonPrimary,
                    foregroundColor: AppColors.buttonText,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Error Message
              Obx(
                () =>
                    controller.errorMessage.value.isNotEmpty
                        ? Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.error.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: AppColors.error.withValues(alpha: 0.3),
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.error_outline,
                                color: AppColors.error,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  controller.errorMessage.value,
                                  style: AppTextTheme.error.copyWith(
                                    color: AppColors.error,
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
      ),
    );
  }
}
