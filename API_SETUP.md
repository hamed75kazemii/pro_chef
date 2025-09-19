# API Setup Guide

## OpenAI API Configuration

This app uses OpenAI's GPT API to generate recipe suggestions. Follow these steps to set up your API key:

### 1. Get an OpenAI API Key

1. Go to [OpenAI Platform](https://platform.openai.com/api-keys)
2. Sign in or create an account
3. Navigate to API Keys section
4. Create a new API key
5. Copy the API key (it starts with `sk-`)

### 2. Configure the App

1. Copy the template file:

   ```bash
   cp lib/constants/app_config.template.dart lib/constants/app_config.dart
   ```

2. Open `lib/constants/app_config.dart` and replace:

   ```dart
   static const String openaiApiKey = 'YOUR_OPENAI_API_KEY_HERE';
   ```

   With your actual API key:

   ```dart
   static const String openaiApiKey = 'sk-your-actual-api-key-here';
   ```

### 3. Security Notes

- **NEVER commit your API key to version control**
- The `app_config.dart` file is already added to `.gitignore`
- Keep the `app_config.template.dart` file for other developers
- If you accidentally commit your API key, immediately rotate it on OpenAI's platform

### 4. API Usage

The app will use your API key to:

- Generate recipe suggestions based on available ingredients
- Provide cooking instructions and nutritional information
- Create personalized meal plans

### 5. Cost Considerations

- OpenAI charges per API call
- Monitor your usage in the [OpenAI Dashboard](https://platform.openai.com/usage)
- Set up billing alerts to avoid unexpected charges

### 6. Troubleshooting

If you encounter API errors:

1. Verify your API key is correct
2. Check your OpenAI account has sufficient credits
3. Ensure you haven't exceeded rate limits
4. Check the API status at [OpenAI Status](https://status.openai.com/)
