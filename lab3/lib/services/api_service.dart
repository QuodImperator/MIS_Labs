import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category.dart';
import '../models/simple_meal.dart';
import '../models/detailed_meal.dart';

class ApiService {
  static const String _baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  static Future<List<Category>> fetchCategories() async {
    final response = await http.get(Uri.parse('$_baseUrl/categories.php'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['categories'] as List)
          .map((json) => Category.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }

  static Future<List<SimpleMeal>> fetchMealsByCategory(String category) async {
    final response = await http.get(Uri.parse('$_baseUrl/filter.php?c=$category'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['meals'] == null) return []; 
      return (data['meals'] as List)
          .map((json) => SimpleMeal.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load meals');
    }
  }

  static Future<DetailedMeal> fetchMealDetails(String id) async {
    final response = await http.get(Uri.parse('$_baseUrl/lookup.php?i=$id'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['meals'] == null) throw Exception('Meal not found');
      return DetailedMeal.fromJson(data['meals'][0]);
    } else {
      throw Exception('Failed to load meal details');
    }
  }

  static Future<DetailedMeal> fetchRandomMeal() async {
    final response = await http.get(Uri.parse('$_baseUrl/random.php'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return DetailedMeal.fromJson(data['meals'][0]);
    } else {
      throw Exception('Failed to load random meal');
    }
  }
}
