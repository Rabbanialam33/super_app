import 'package:flutter/material.dart';

class ShoppingPage extends StatelessWidget {
  const ShoppingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Shopping',
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
              'Shop what you need',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Discover products from stores near you',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 24),

            // Search
            TextField(
              decoration: InputDecoration(
                hintText: 'Search products or stores...',
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
              'Shop by Category',
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
                _ShoppingCategory(
                  icon: Icons.phone_android,
                  title: 'Electronics',
                ),
                _ShoppingCategory(
                  icon: Icons.checkroom,
                  title: 'Fashion',
                ),
                _ShoppingCategory(
                  icon: Icons.shopping_basket,
                  title: 'Grocery',
                ),
                _ShoppingCategory(
                  icon: Icons.home,
                  title: 'Home',
                ),
                _ShoppingCategory(
                  icon: Icons.sports_soccer,
                  title: 'Sports',
                ),
                _ShoppingCategory(
                  icon: Icons.more_horiz,
                  title: 'More',
                ),
              ],
            ),

            const SizedBox(height: 32),

            const Text(
              'Popular Products',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            const _ProductCard(
              name: 'Popular Product',
              category: 'Electronics',
              price: '₹999',
            ),

            const SizedBox(height: 12),

            const _ProductCard(
              name: 'Daily Essentials',
              category: 'Grocery',
              price: '₹499',
            ),
          ],
        ),
      ),
    );
  }
}

class _ShoppingCategory extends StatelessWidget {
  final IconData icon;
  final String title;

  const _ShoppingCategory({
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

class _ProductCard extends StatelessWidget {
  final String name;
  final String category;
  final String price;

  const _ProductCard({
    required this.name,
    required this.category,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.shopping_bag),
        ),
        title: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(category),
        trailing: Text(
          price,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}