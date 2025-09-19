# 🍳 Pro Chef - AI Recipe Generator

یک اپلیکیشن هوشمند برای تولید دستور پخت بر اساس مواد اولیه موجود، با استفاده از هوش مصنوعی OpenAI.

## ✨ ویژگی‌ها

- 🤖 تولید دستور پخت هوشمند با AI
- 🌍 پشتیبانی از زبان‌های فارسی و انگلیسی
- 💾 ذخیره دستور پخت‌های مورد علاقه
- 🍽️ دستور پخت‌های ایرانی
- 📱 رابط کاربری زیبا و کاربرپسند
- 🔒 مدیریت امن API keys

## 🚀 نصب و راه‌اندازی

### پیش‌نیازها

- Flutter SDK (نسخه 3.0 یا بالاتر)
- Dart SDK
- Android Studio / Xcode (برای توسعه موبایل)

### نصب

1. پروژه را clone کنید:

```bash
git clone <repository-url>
cd pro_chef
```

2. وابستگی‌ها را نصب کنید:

```bash
flutter pub get
```

3. **تنظیم API Key (مهم!)**:

```bash
export OPENAI_API_KEY="your_openai_api_key_here"
```

4. اپ را اجرا کنید:

```bash
flutter run
```

## 🔐 تنظیم امن API Key

### 🚀 روش Development (توصیه شده برای شروع سریع):

API key به صورت خودکار در اپ تنظیم می‌شود و نیازی به تنظیم environment variables نیست:

```bash
flutter run
```

### 🔒 روش Production (توصیه شده برای امنیت بالا):

برای امنیت بیشتر، API key در environment variables ذخیره می‌شود:

#### تنظیم موقت:

```bash
export OPENAI_API_KEY="your_api_key_here"
flutter run
```

#### تنظیم دائمی:

```bash
echo 'export OPENAI_API_KEY="your_api_key_here"' >> ~/.zshrc
source ~/.zshrc
flutter run
```

### تست تنظیمات:

```bash
echo $OPENAI_API_KEY
```

📖 برای اطلاعات بیشتر:

- `DEVELOPMENT_SETUP.md` - راهنمای توسعه سریع
- `ENVIRONMENT_SETUP.md` - راهنمای environment variables

## 🏗️ ساختار پروژه

```
lib/
├── constants/          # تنظیمات و ثابت‌ها
│   ├── app_config.dart # تنظیمات API (امن)
│   └── ...
├── controllers/        # کنترلرهای GetX
├── models/            # مدل‌های داده
├── screens/           # صفحات اپ
├── services/          # سرویس‌های API
├── translations/      # ترجمه‌ها
└── widgets/           # کامپوننت‌های قابل استفاده مجدد
```

## 🌍 پشتیبانی از زبان‌ها

- 🇺🇸 انگلیسی (English)
- 🇮🇷 فارسی (Persian)

## 🔧 توسعه

### اضافه کردن زبان جدید

1. فایل `lib/translations/app_translations.dart` را ویرایش کنید
2. کلیدهای ترجمه جدید را اضافه کنید
3. ترجمه‌ها را در هر دو زبان اضافه کنید

### اضافه کردن ویژگی جدید

1. مدل داده را در `lib/models/` تعریف کنید
2. سرویس مربوطه را در `lib/services/` ایجاد کنید
3. کنترلر را در `lib/controllers/` پیاده‌سازی کنید
4. UI را در `lib/screens/` یا `lib/widgets/` بسازید

## 📱 پلتفرم‌های پشتیبانی شده

- ✅ Android
- ✅ iOS
- ✅ Web
- ✅ macOS
- ✅ Linux
- ✅ Windows

## 🤝 مشارکت

1. پروژه را fork کنید
2. یک branch جدید ایجاد کنید (`git checkout -b feature/amazing-feature`)
3. تغییرات را commit کنید (`git commit -m 'Add amazing feature'`)
4. Branch را push کنید (`git push origin feature/amazing-feature`)
5. یک Pull Request ایجاد کنید

## 📄 مجوز

این پروژه تحت مجوز MIT منتشر شده است.

## 📞 پشتیبانی

برای سوالات و مشکلات:

- Issue جدید در GitHub ایجاد کنید
- مستندات `DEVELOPMENT_SETUP.md` را برای راهنمای توسعه مطالعه کنید
- فایل `ENVIRONMENT_SETUP.md` را برای راهنمای environment variables مطالعه کنید
- فایل `API_SETUP.md` را برای راهنمای کلی API بررسی کنید

---

**نکته مهم**: هرگز API key خود را در کد commit نکنید. همیشه از environment variables استفاده کنید!
