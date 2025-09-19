# 🔐 راهنمای استفاده از Dotenv در Pro Chef

## 📦 پکیج flutter_dotenv

این اپ از پکیج `flutter_dotenv` برای مدیریت environment variables استفاده می‌کند.

## 🚀 نصب و راه‌اندازی

### 1. **پکیج اضافه شده**

پکیج `flutter_dotenv` در `pubspec.yaml` اضافه شده است:

```yaml
dependencies:
  flutter_dotenv: ^5.1.0
```

### 2. **فایل‌های محیطی**

- `.env` - فایل اصلی با مقادیر واقعی (در .gitignore قرار دارد)
- `.env.example` - فایل نمونه برای توسعه‌دهندگان

## 🔧 نحوه استفاده

### **در main.dart:**

```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables from .env file
  try {
    await dotenv.load(fileName: ".env");
    print('Environment file loaded successfully');
  } catch (e) {
    print('Warning: Could not load .env file: $e');
    print('Using fallback configuration...');
  }

  // ... rest of the code
}
```

### **در AppConfig:**

```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConfig {
  static String get openaiApiKey {
    // Try to get from .env file first
    try {
      final dotenvKey = dotenv.env['OPENAI_API_KEY'];
      if (dotenvKey != null && dotenvKey.isNotEmpty) {
        return dotenvKey;
      }
    } catch (e) {
      print('Warning: Could not access .env file: $e');
    }

    // Fallback to system environment variable
    final envKey = Platform.environment['OPENAI_API_KEY'];
    if (envKey != null && envKey.isNotEmpty) {
      return envKey;
    }

    // Final fallback for development
    return 'fallback_api_key_here';
  }
}
```

## 📁 ساختار فایل‌ها

```
pro_chef/
├── .env                    # فایل اصلی (در .gitignore)
├── .env.example           # فایل نمونه
├── lib/
│   ├── constants/
│   │   └── app_config.dart
│   └── main.dart
└── pubspec.yaml
```

## 🎯 اولویت‌بندی API Key

1. **اولویت اول**: فایل `.env`
2. **اولویت دوم**: System environment variable
3. **اولویت سوم**: Fallback value (برای development)

## 🔒 امنیت

### **فایل .env:**

- در `.gitignore` قرار دارد
- حاوی مقادیر واقعی است
- هرگز commit نمی‌شود

### **فایل .env.example:**

- در repository قرار دارد
- حاوی مقادیر نمونه است
- برای راهنمایی توسعه‌دهندگان

## 🚀 اجرای اپ

### **Development (با فایل .env):**

1. فایل `.env.example` را کپی کنید:

   ```bash
   cp .env.example .env
   ```

2. فایل `.env` را ویرایش کنید:

   ```bash
   OPENAI_API_KEY=your_actual_api_key_here
   ```

3. اپ را اجرا کنید:
   ```bash
   flutter run
   ```

### **Production (با environment variables):**

```bash
export OPENAI_API_KEY="your_api_key_here"
flutter run
```

## 🔍 تست تنظیمات

وقتی اپ اجرا می‌شود، این پیام‌ها نمایش داده می‌شود:

```
Initializing Pro Chef App...
App Name: Pro Chef
App Version: 1.0.0
OpenAI Base URL: https://api.openai.com/v1/chat/completions
OpenAI Model: gpt-3.5-turbo
Environment file loaded successfully
API Key Status: ✅ Available (sk-proj-_j...)
```

## ⚠️ عیب‌یابی

### **اگر فایل .env load نمی‌شود:**

1. مطمئن شوید که فایل `.env` در root پروژه قرار دارد
2. مطمئن شوید که فایل `.env` در `.gitignore` قرار دارد
3. اپ را restart کنید

### **اگر API key در دسترس نیست:**

1. فایل `.env` را بررسی کنید
2. مطمئن شوید که `OPENAI_API_KEY` درست تنظیم شده
3. از environment variable استفاده کنید

## 📚 مزایای استفاده از Dotenv

- ✅ **مدیریت آسان**: فایل‌های محیطی جداگانه
- ✅ **امنیت بالا**: فایل‌های حساس در .gitignore
- ✅ **انعطاف‌پذیری**: پشتیبانی از multiple environments
- ✅ **استاندارد**: روش استاندارد برای مدیریت configuration
- ✅ **توسعه آسان**: نیازی به تنظیم environment variables نیست

## 🔄 به‌روزرسانی

برای به‌روزرسانی پکیج:

```bash
flutter pub upgrade flutter_dotenv
```

---

**نکته**: همیشه از فایل `.env` برای development و environment variables برای production استفاده کنید! 🎯
