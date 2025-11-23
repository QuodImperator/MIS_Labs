import 'package:flutter/material.dart';
import 'screens/categories_screen.dart';

void main() {
  runApp(const RecipeApp());
}

class RecipeApp extends StatelessWidget {
  const RecipeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
        ),
      ),
      home: const CategoriesScreen(),
    );
  }
}
