class Recipe {
  final String name;
  final String description;
  final List<String> steps;

  Recipe({required this.name, required this.description, required this.steps});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      steps: List<String>.from(json['steps'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'description': description, 'steps': steps};
  }

  @override
  String toString() {
    return 'Recipe(name: $name, description: $description, steps: $steps)';
  }
}
