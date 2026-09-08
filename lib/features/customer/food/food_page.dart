import 'package:flutter/material.dart';

class FoodPage extends StatelessWidget {
  const FoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Food',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'What are you craving?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Find delicious food near you',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 24),

            // Food Search
            TextField(
              decoration: InputDecoration(
                hintText: 'Search restaurants or dishes...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 28),

            const Text(
              'Food Categories',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: const [
                _FoodCategory(
                  icon: Icons.local_pizza,
                  title: 'Pizza',
                ),
                _FoodCategory(
                  icon: Icons.lunch_dining,
                  title: 'Burger',
                ),
                _FoodCategory(
                  icon: Icons.rice_bowl,
                  title: 'Biryani',
                ),
                _FoodCategory(
                  icon: Icons.ramen_dining,
                  title: 'Noodles',
                ),
                _FoodCategory(
                  icon: Icons.cake,
                  title: 'Desserts',
                ),
                _FoodCategory(
                  icon: Icons.local_cafe,
                  title: 'Drinks',
                ),
              ],
            ),

            const SizedBox(height: 32),

            const Text(
              'Popular Near You',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            const _RestaurantCard(
              name: 'Popular Restaurant',
              category: 'Indian • Biryani • Fast Food',
            ),

            const SizedBox(height: 12),

            const _RestaurantCard(
              name: 'Local Food House',
              category: 'Chinese • Snacks • Drinks',
            ),
          ],
        ),
      ),
    );
  }
}

class _FoodCategory extends StatelessWidget {
  final IconData icon;
  final String title;

  const _FoodCategory({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 62,
          height: 62,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
          child: Icon(
            icon,
            size: 30,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _RestaurantCard extends StatelessWidget {
  final String name;
  final String category;

  const _RestaurantCard({
    required this.name,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.restaurant),
        ),
        title: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(category),
        trailing: const Icon(
          Icons.chevron_right,
        ),
      ),
    );
  }
}