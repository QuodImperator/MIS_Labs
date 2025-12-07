import 'package:flutter/material.dart';
import '../models/simple_meal.dart';
import '../models/detailed_meal.dart';
import '../services/favorites_service.dart';
import '../services/api_service.dart';
import 'meal_detail_screen.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final FavoritesService _favoritesService = FavoritesService();

  @override
  Widget build(BuildContext context) {
    final favorites = _favoritesService.favoriteMeals;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Recipes'),
      ),
      body: favorites.isEmpty
          ? const Center(
              child: Text('No favorite recipes yet!'),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final meal = favorites[index];
                return _buildMealCard(meal);
              },
            ),
    );
  }

  Widget _buildMealCard(SimpleMeal meal) {
    return GestureDetector(
      onTap: () async {
        try {
          DetailedMeal detail = await ApiService.fetchMealDetails(meal.id);
          if (!mounted) return;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => MealDetailScreen(meal: detail),
            ),
          ).then((_) => setState(() {}));
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Could not fetch details")));
        }
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                child: Image.network(
                  meal.thumbnail,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(Icons.restaurant),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      meal.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.favorite, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        _favoritesService.toggleFavorite(meal);
                      });
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}