import '../models/simple_meal.dart';

class FavoritesService {
  static final FavoritesService _instance = FavoritesService._internal();
  factory FavoritesService() => _instance;
  FavoritesService._internal();

  final List<SimpleMeal> _favoriteMeals = [];

  List<SimpleMeal> get favoriteMeals => _favoriteMeals;

  void toggleFavorite(SimpleMeal meal) {
    if (isFavorite(meal.id)) {
      _favoriteMeals.removeWhere((item) => item.id == meal.id);
    } else {
      _favoriteMeals.add(meal);
    }
  }

  bool isFavorite(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }
}