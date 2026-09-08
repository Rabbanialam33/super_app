import 'package:flutter/material.dart';

class ServiceCategories extends StatelessWidget {
  const ServiceCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'What do you need?',
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
          mainAxisSpacing: 18,
          crossAxisSpacing: 18,
          children: const [
            _ServiceCategoryItem(
              icon: Icons.restaurant,
              title: 'Food',
            ),
            _ServiceCategoryItem(
              icon: Icons.shopping_bag,
              title: 'Shopping',
            ),
            _ServiceCategoryItem(
              icon: Icons.delivery_dining,
              title: 'Delivery',
            ),
            _ServiceCategoryItem(
              icon: Icons.local_taxi,
              title: 'Ride',
            ),
            _ServiceCategoryItem(
              icon: Icons.people,
              title: 'Manpower',
            ),
            _ServiceCategoryItem(
              icon: Icons.home_repair_service,
              title: 'Services',
            ),
          ],
        ),
      ],
    );
  }
}

class _ServiceCategoryItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const _ServiceCategoryItem({
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
        const SizedBox(height: 9),
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}