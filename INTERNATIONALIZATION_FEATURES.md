# Internationalization (i18n) Features

## Overview

The Pro Chef app now supports full internationalization with Persian (فارسی) and English languages, including:

- **Language Switching**: Toggle between English and Persian
- **Persian Font Support**: Vazir font for proper Persian text rendering
- **RTL Support**: Right-to-left text direction for Persian
- **AI Service Integration**: Language-aware recipe generation
- **Theme Support**: Light, dark, and system theme modes
- **Persistent Settings**: Language and theme preferences are saved

## Features Implemented

### 1. Language Switching

- **Language Switcher**: Click the flag icon (🇺🇸/🇮🇷) in the app bar to switch languages
- **Settings Screen**: Access detailed language and theme settings
- **Persistent Storage**: Language preference is saved and restored on app restart

### 2. Persian Language Support

- **Complete Translation**: All UI text is translated to Persian
- **Vazir Font**: Proper Persian font rendering
- **RTL Layout**: Right-to-left text direction for Persian interface
- **Persian Input**: Support for Persian text input in recipe ingredients

### 3. AI Service Integration

- **Language-Aware Generation**: AI generates recipes in the selected language
- **Persian Recipes**: Recipe names, descriptions, and instructions in Persian
- **Filter Translation**: Dietary preferences are translated and work in both languages

### 4. Theme Management

- **Light Theme**: Default light theme
- **Dark Theme**: Dark theme for better visibility in low light
- **System Theme**: Automatically follows system theme preference
- **Persistent Storage**: Theme preference is saved

## File Structure

```
lib/
├── controllers/
│   ├── root_controller.dart          # Main app state management
│   └── recipe_controller.dart        # Recipe management with i18n
├── translations/
│   └── app_translations.dart         # All text translations
├── screens/
│   ├── home_screen.dart              # Updated with language switcher
│   ├── settings_screen.dart          # New settings screen
│   ├── results_screen.dart           # Updated with translations
│   └── recipe_detail_screen.dart     # Updated with translations
├── services/
│   └── demo_recipe_service.dart      # Updated with language support
└── main.dart                         # Updated with i18n configuration
```

## Key Components

### RootController

- Manages app-wide state (language, theme)
- Handles language switching
- Persists settings using GetStorage
- Provides language-aware utilities

### AppTranslations

- Contains all text strings in English and Persian
- Organized by screen/feature
- Easy to extend with new languages

### DemoRecipeService

- Generates recipes in the selected language
- Persian recipe names, descriptions, and instructions
- Language-aware filtering

## Usage

### Switching Languages

1. **Quick Switch**: Tap the flag icon in the app bar
2. **Settings**: Go to Settings → Language → Select language

### Changing Themes

1. Go to Settings → Theme
2. Select Light, Dark, or System theme

### Adding New Languages

1. Add new locale to `supportedLocales` in `main.dart`
2. Add translations to `AppTranslations`
3. Add language options to `RootController`

## Technical Details

### Dependencies Added

- `flutter_localizations`: Flutter's built-in localization support
- `get_storage`: Persistent storage for settings
- `font_awesome_flutter`: Additional icons

### Font Configuration

- Vazir font for Persian text
- Google Fonts (Poppins) for English text
- Automatic font switching based on language

### RTL Support

- Automatic text direction switching
- RTL-aware layouts
- Proper text alignment for Persian

## Future Enhancements

1. **More Languages**: Add support for Arabic, Turkish, etc.
2. **Voice Input**: Speech-to-text in multiple languages
3. **Recipe Sharing**: Share recipes in different languages
4. **Cultural Adaptations**: Region-specific recipe preferences
5. **Offline Translation**: Local translation database

## Testing

To test the internationalization features:

1. **Language Switching**: Tap the flag icon and verify all text changes
2. **RTL Layout**: Switch to Persian and verify right-to-left layout
3. **Recipe Generation**: Enter ingredients and verify recipes are in the correct language
4. **Theme Switching**: Change themes and verify proper color schemes
5. **Persistence**: Restart the app and verify settings are preserved

## Notes

- The Vazir font files are placeholder files for demonstration
- For production, download proper Vazir font files from the official repository
- The demo service provides Persian recipes for testing
- Real AI service integration would require API key and proper Persian prompt engineering
