import 'package:flutter/material.dart';
import '../models/category.dart';
import '../models/detailed_meal.dart';
import '../services/api_service.dart';
import 'meals_by_category_screen.dart';
import 'meal_detail_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  late Future<List<Category>> futureCategories;
  List<Category> _allCategories = [];
  List<Category> _filteredCategories = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    futureCategories = ApiService.fetchCategories();
  }

  void _filterCategories(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredCategories = _allCategories;
      } else {
        _filteredCategories = _allCategories
            .where((category) =>
                category.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  void _navigateToRandomMeal() async {
    try {
      DetailedMeal meal = await ApiService.fetchRandomMeal();
      if (!mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => MealDetailScreen(meal: meal)),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recipe Categories'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shuffle),
            tooltip: 'Random Recipe',
            onPressed: _navigateToRandomMeal,
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search Categories',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: _filterCategories,
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Category>>(
              future: futureCategories,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No categories found'));
                }

                if (_allCategories.isEmpty) {
                  _allCategories = snapshot.data!;
                  _filteredCategories = _allCategories;
                }

                return ListView.builder(
                  itemCount: _filteredCategories.length,
                  itemBuilder: (context, index) {
                    final category = _filteredCategories[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      elevation: 4,
                      child: ListTile(
                        leading: Image.network(
                          category.thumbnail,
                          width: 70,
                          fit: BoxFit.cover,
                          errorBuilder: (ctx, _, __) => const Icon(Icons.broken_image),
                        ),
                        title: Text(
                          category.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          category.description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => MealsByCategoryScreen(category: category),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
