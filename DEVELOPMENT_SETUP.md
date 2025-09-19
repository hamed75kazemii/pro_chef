# 🚀 راهنمای توسعه Pro Chef

## 🔧 تنظیمات جدید توسعه

در این نسخه، API key به صورت خودکار در `main.dart` تنظیم می‌شود و از طریق `AppConfig` قابل دسترسی است.

## 📱 نحوه کارکرد

### 1. **تنظیم خودکار در main.dart**

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize AppConfig and test API key access
  print('Initializing Pro Chef App...');
  print('App Name: ${AppConfig.appName}');
  print('App Version: ${AppConfig.appVersion}');

  // Test API key access
  try {
    final apiKey = AppConfig.openaiApiKey;
    print('API Key Status: ✅ Available');
  } catch (e) {
    print('API Key Status: ❌ Error - $e');
  }

  await GetStorage.init();
  runApp(const MyApp());
}
```

### 2. **دسترسی از طریق AppConfig**

```dart
import 'package:your_app/constants/app_config.dart';

class RecipeService {
  static const String _apiKey = AppConfig.openaiApiKey;
  static const String _baseUrl = AppConfig.openaiBaseUrl;
  static const String _model = AppConfig.openaiModel;
}
```

## 🔐 امنیت API Key

### **روش فعلی (Development):**

- ✅ API key در `AppConfig` با fallback ذخیره می‌شود
- ✅ برای development مناسب است
- ⚠️ در production باید از environment variables استفاده شود

### **روش Production (توصیه شده):**

```bash
# Set environment variable
export OPENAI_API_KEY="your_api_key_here"

# Run app
flutter run
```

## 🎯 مزایای روش جدید

1. **سادگی توسعه**: نیازی به تنظیم environment variables نیست
2. **تست آسان**: API key همیشه در دسترس است
3. **مدیریت متمرکز**: همه تنظیمات در `AppConfig` قرار دارد
4. **انعطاف‌پذیری**: امکان استفاده از environment variables در production

## ⚠️ نکات مهم

### **برای Development:**

- API key به صورت خودکار تنظیم می‌شود
- نیازی به تنظیم environment variables نیست
- اپ مستقیماً قابل اجرا است

### **برای Production:**

- حتماً از environment variables استفاده کنید
- API key را در کد commit نکنید
- از `.env` files استفاده کنید

## 🚀 اجرای اپ

### **Development (بدون تنظیم اضافی):**

```bash
flutter run
```

### **Production (با environment variable):**

```bash
export OPENAI_API_KEY="your_api_key_here"
flutter run
```

## 🔍 تست تنظیمات

وقتی اپ اجرا می‌شود، در console این اطلاعات نمایش داده می‌شود:

```
Initializing Pro Chef App...
App Name: Pro Chef
App Version: 1.0.0
OpenAI Base URL: https://api.openai.com/v1/chat/completions
OpenAI Model: gpt-3.5-turbo
API Key Status: ✅ Available (sk-proj-_j...)
```

## 🛠️ عیب‌یابی

### **اگر API Key در دسترس نیست:**

1. مطمئن شوید که `AppConfig.openaiApiKey` درست تعریف شده
2. فایل `app_config.dart` را بررسی کنید
3. در صورت نیاز، environment variable تنظیم کنید

### **برای تغییر API Key:**

1. فایل `lib/constants/app_config.dart` را ویرایش کنید
2. مقدار `openaiApiKey` را تغییر دهید
3. اپ را restart کنید

## 📚 فایل‌های مرتبط

- `lib/main.dart` - تنظیمات اولیه و تست API key
- `lib/constants/app_config.dart` - تنظیمات اپ و API
- `lib/services/recipe_service.dart` - استفاده از AppConfig
- `ENVIRONMENT_SETUP.md` - راهنمای environment variables
- `API_SETUP.md` - راهنمای کلی API

---

**نکته**: این روش برای development مناسب است. در production حتماً از environment variables استفاده کنید! 🎯
