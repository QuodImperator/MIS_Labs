import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/detailed_meal.dart';

class MealDetailScreen extends StatelessWidget {
  final DetailedMeal meal;

  const MealDetailScreen({super.key, required this.meal});

  Future<void> _launchYoutube(String? url) async {
    if (url != null && await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                meal.name,
                style: const TextStyle(
                    color: Colors.white, 
                    shadows: [Shadow(color: Colors.black, blurRadius: 2)]
                ),
                textScaler: MediaQuery.textScalerOf(context),
              ),
              background: Image.network(
                meal.thumbnail,
                fit: BoxFit.cover,
                color: Colors.black38,
                colorBlendMode: BlendMode.darken,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Chip(label: Text(meal.category), backgroundColor: Colors.orange[100]),
                        const SizedBox(width: 8),
                        Chip(label: Text(meal.area), backgroundColor: Colors.blue[100]),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    const Text(
                      'Ingredients',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    
                    ...List.generate(meal.ingredients.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2.0),
                        child: Row(
                          children: [
                            const Icon(Icons.check_circle_outline,
                                size: 16, color: Colors.green),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                '${meal.ingredients[index]} - ${meal.measures[index]}',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    
                    const SizedBox(height: 24),
                    
                    const Text(
                      'Instructions',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    
                    Text(
                      meal.instructions,
                      style: const TextStyle(fontSize: 16, height: 1.5),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    if (meal.youtubeUrl != null && meal.youtubeUrl!.isNotEmpty)
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.video_library),
                          label: const Text('Watch on YouTube'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          onPressed: () => _launchYoutube(meal.youtubeUrl),
                        ),
                      ),
                    
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
