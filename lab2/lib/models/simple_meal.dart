class SimpleMeal {
  final String id;
  final String name;
  final String thumbnail;

  SimpleMeal({
    required this.id,
    required this.name,
    required this.thumbnail,
  });

  factory SimpleMeal.fromJson(Map<String, dynamic> json) {
    return SimpleMeal(
      id: json['idMeal'],
      name: json['strMeal'],
      thumbnail: json['strMealThumb'],
    );
  }
}
