# Pro Chef - AI Recipe Generator 🍳

A Flutter app that generates delicious recipes using AI based on the ingredients you have available.

## Features ✨

- **AI-Powered Recipe Generation**: Get personalized recipes based on your available ingredients
- **Dietary Preferences**: Filter recipes by dietary requirements (Vegetarian, Quick meals, Low calorie, etc.)
- **Beautiful Material 3 UI**: Modern, intuitive interface with smooth animations
- **Recipe Details**: View complete recipes with step-by-step instructions
- **Error Handling**: Robust error handling and loading states
- **Responsive Design**: Works on all screen sizes

## Screenshots 📱

- **Home Screen**: Input ingredients and select dietary preferences
- **Results Screen**: Browse generated recipes in a beautiful card layout
- **Recipe Detail Screen**: View complete recipe with numbered steps

## Setup Instructions 🚀

### Prerequisites

- Flutter SDK (3.7.2 or higher)
- Dart SDK
- Android Studio / VS Code
- OpenAI API Key

### Installation

1. **Clone the repository**

   ```bash
   git clone <repository-url>
   cd pro_chef
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Configure API Key**

   Open `lib/services/recipe_service.dart` and replace `YOUR_OPENAI_API_KEY` with your actual OpenAI API key:

   ```dart
   static const String _apiKey = 'your-actual-api-key-here';
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

## API Configuration 🔧

### OpenAI API Setup

1. Go to [OpenAI Platform](https://platform.openai.com/)
2. Create an account or sign in
3. Navigate to API Keys section
4. Create a new API key
5. Copy the key and replace it in the `RecipeService` class

### Alternative AI Services

You can easily modify the `RecipeService` to use other AI services like:

- Google's Generative AI
- Anthropic Claude
- Local AI models

## Project Structure 📁

```
lib/
├── controllers/
│   └── recipe_controller.dart    # GetX controller for state management
├── models/
│   └── recipe.dart              # Recipe data model
├── screens/
│   ├── home_screen.dart         # Ingredients input screen
│   ├── results_screen.dart      # Recipe list screen
│   └── recipe_detail_screen.dart # Recipe detail screen
├── services/
│   └── recipe_service.dart      # API service for AI requests
└── main.dart                    # App entry point
```

## Dependencies 📦

- **flutter**: Core Flutter framework
- **get**: State management and navigation
- **http**: HTTP requests for API calls
- **cupertino_icons**: iOS-style icons

## Usage Guide 📖

1. **Enter Ingredients**: On the home screen, enter your available ingredients separated by commas
2. **Select Preferences**: Choose dietary preferences from the dropdown (optional)
3. **Generate Recipes**: Tap "Suggest Recipes" to get AI-generated recipes
4. **Browse Results**: View the list of generated recipes
5. **View Details**: Tap on any recipe to see complete instructions
6. **Save/Share**: Use the action buttons to save or share recipes

## Features in Detail 🎯

### Task 1 - Project Setup ✅

- Flutter project with Material 3 theme
- Organized folder structure
- GetX for state management

### Task 2 - Data Model ✅

- Recipe model with name, description, and steps
- JSON serialization support

### Task 3 - API Service ✅

- OpenAI integration
- Error handling and fallback parsing
- Configurable prompts

### Task 4 - Home Screen ✅

- Ingredients input with validation
- Dietary preference filters
- Loading states and error messages

### Task 5 - Results Screen ✅

- Scrollable recipe list
- Beautiful card layout
- Navigation to detail screen

### Task 6 - Recipe Detail Screen ✅

- Complete recipe display
- Numbered step instructions
- Save and share functionality

### Task 7 - Error & Loading States ✅

- Loading spinners
- Error message display
- Input validation

### Task 8 - Optional Filters ✅

- Dietary preference dropdown
- Filter integration with API prompts

### Task 9 - UI Polish ✅

- Material 3 design
- Consistent spacing and colors
- Modern icons and animations

## Contributing 🤝

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License 📄

This project is licensed under the MIT License - see the LICENSE file for details.

## Support 💬

If you encounter any issues or have questions:

1. Check the troubleshooting section below
2. Open an issue on GitHub
3. Contact the development team

## Troubleshooting 🔧

### Common Issues

1. **API Key Error**

   - Ensure your OpenAI API key is correctly set
   - Check if you have sufficient API credits

2. **No Recipes Generated**

   - Try different ingredients
   - Check your internet connection
   - Verify API key permissions

3. **Build Errors**
   - Run `flutter clean` and `flutter pub get`
   - Ensure Flutter SDK version compatibility

## Future Enhancements 🚀

- [ ] Recipe favorites and local storage
- [ ] Recipe sharing via social media
- [ ] Nutritional information
- [ ] Recipe ratings and reviews
- [ ] Offline mode with cached recipes
- [ ] Multiple language support
- [ ] Recipe categories and tags
- [ ] Shopping list generation

---

Made with ❤️ using Flutter and AI
