import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en': {
      // App
      'app_title': 'Pro Chef - AI Recipe Generator',

      // Home Screen
      'what_ingredients_have': 'What ingredients do you have?',
      'enter_ingredients_description':
          'Enter your available ingredients and let AI create delicious recipes for you!',
      'ingredients': 'Ingredients',
      'ingredients_hint': '🖊️ e.g., chicken, rice, tomatoes, onions',
      'separate_ingredients': 'Separate ingredients with commas',
      'dietary_preferences': 'Dietary Preferences',
      'select_dietary_preference': 'Select dietary preference',
      'no_preference': 'No preference',
      'suggest_recipes': 'Suggest Recipes',
      'generating_recipes': 'Generating Recipes...',
      'please_enter_ingredients': 'Please enter at least one ingredient',

      // Recipe Details
      'cooking_time': 'Cooking Time',
      'servings': 'Servings',
      'difficulty': 'Difficulty',
      'ingredients_list': 'Ingredients',
      'instructions': 'Instructions',
      'nutrition_info': 'Nutrition Information',
      'calories': 'Calories',
      'protein': 'Protein',
      'carbs': 'Carbs',
      'fat': 'Fat',
      'fiber': 'Fiber',
      'minutes': 'minutes',
      'people': 'people',
      'easy': 'Easy',
      'medium': 'Medium',
      'hard': 'Hard',

      // Results Screen
      'recipes_found': 'Recipes Found',
      'no_recipes_found': 'No recipes found',
      'try_different_ingredients': 'Try different ingredients',
      'loading_recipes': 'Loading recipes...',

      // Common
      'error': 'Error',
      'success': 'Success',
      'loading': 'Loading...',
      'cancel': 'Cancel',
      'save': 'Save',
      'delete': 'Delete',
      'edit': 'Edit',
      'close': 'Close',
      'back': 'Back',
      'next': 'Next',
      'previous': 'Previous',
      'done': 'Done',
      'ok': 'OK',
      'yes': 'Yes',
      'no': 'No',

      // Settings
      'settings': 'Settings',
      'language': 'Language',
      'theme': 'Theme',
      'light_theme': 'Light Theme',
      'dark_theme': 'Dark Theme',
      'system_theme': 'System Theme',

      // AI Service
      'ai_generating': 'AI is generating your recipes...',
      'ai_error': 'Error generating recipes. Please try again.',
      'ai_no_ingredients':
          'Please provide some ingredients to generate recipes.',
    },
    'fa': {
      // App
      'app_title': 'پرو شیف - تولید کننده دستور پخت هوشمند',

      // Home Screen
      'what_ingredients_have': 'چه مواد اولیه‌ای دارید؟',
      'enter_ingredients_description':
          'مواد اولیه موجود خود را وارد کنید و بگذارید هوش مصنوعی دستور پخت‌های خوشمزه برایتان بسازد!',
      'ingredients': 'مواد اولیه',
      'ingredients_hint': '🖊️ مثال: مرغ، برنج، گوجه فرنگی، پیاز',
      'separate_ingredients': 'مواد اولیه را با کاما جدا کنید',
      'dietary_preferences': 'ترجیحات غذایی',
      'select_dietary_preference': 'ترجیح غذایی را انتخاب کنید',
      'no_preference': 'بدون ترجیح',
      'suggest_recipes': 'پیشنهاد دستور پخت',
      'generating_recipes': 'در حال تولید دستور پخت...',
      'please_enter_ingredients': 'لطفاً حداقل یک ماده اولیه وارد کنید',

      // Recipe Details
      'cooking_time': 'زمان پخت',
      'servings': 'تعداد نفرات',
      'difficulty': 'سطح دشواری',
      'ingredients_list': 'مواد اولیه',
      'instructions': 'دستورالعمل',
      'nutrition_info': 'اطلاعات تغذیه‌ای',
      'calories': 'کالری',
      'protein': 'پروتئین',
      'carbs': 'کربوهیدرات',
      'fat': 'چربی',
      'fiber': 'فیبر',
      'minutes': 'دقیقه',
      'people': 'نفر',
      'easy': 'آسان',
      'medium': 'متوسط',
      'hard': 'سخت',

      // Results Screen
      'recipes_found': 'دستور پخت‌های یافت شده',
      'no_recipes_found': 'دستور پختی یافت نشد',
      'try_different_ingredients': 'مواد اولیه متفاوتی امتحان کنید',
      'loading_recipes': 'در حال بارگذاری دستور پخت‌ها...',

      // Common
      'error': 'خطا',
      'success': 'موفقیت',
      'loading': 'در حال بارگذاری...',
      'cancel': 'لغو',
      'save': 'ذخیره',
      'delete': 'حذف',
      'edit': 'ویرایش',
      'close': 'بستن',
      'back': 'بازگشت',
      'next': 'بعدی',
      'previous': 'قبلی',
      'done': 'تمام',
      'ok': 'تأیید',
      'yes': 'بله',
      'no': 'خیر',

      // Settings
      'settings': 'تنظیمات',
      'language': 'زبان',
      'theme': 'تم',
      'light_theme': 'تم روشن',
      'dark_theme': 'تم تاریک',
      'system_theme': 'تم سیستم',

      // AI Service
      'ai_generating': 'هوش مصنوعی در حال تولید دستور پخت‌های شماست...',
      'ai_error': 'خطا در تولید دستور پخت. لطفاً دوباره تلاش کنید.',
      'ai_no_ingredients':
          'لطفاً مواد اولیه‌ای برای تولید دستور پخت ارائه دهید.',
    },
  };
}
