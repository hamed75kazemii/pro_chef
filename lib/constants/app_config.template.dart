class AppConfig {
  // OpenAI API Configuration
  // Get your API key from: https://platform.openai.com/api-keys
  static const String openaiApiKey = 'YOUR_OPENAI_API_KEY_HERE';
  static const String openaiBaseUrl =
      'https://api.openai.com/v1/chat/completions';
  static const String openaiModel = 'gpt-3.5-turbo';

  // App Configuration
  static const String appName = 'Pro Chef';
  static const String appVersion = '1.0.0';

  // API Configuration
  static const int apiTimeoutSeconds = 30;
  static const int maxRetries = 3;
}

/*
INSTRUCTIONS:
1. Copy this file to app_config.dart
2. Replace 'YOUR_OPENAI_API_KEY_HERE' with your actual OpenAI API key
3. Never commit your actual API key to version control
4. Keep this template file for other developers
*/
