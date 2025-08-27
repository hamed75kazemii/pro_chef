import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

void shareApp() {
  final String shareText = '''
👨‍🍳 ${'app_title'.tr}

🍽️ ${'enter_ingredients_description'.tr}

✨ ${'features'.tr}:
• ${'ai_powered_suggestions'.tr}
• ${'dietary_preferences'.tr}
• ${'save_favorite_recipes'.tr}
• ${'easy_instructions'.tr}

📱 ${'download_now'.tr}!

#ProChef #RecipeGenerator #CookingApp
''';

  Share.share(shareText, subject: 'check_out_pro_chef'.tr);
}
