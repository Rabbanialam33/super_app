import 'package:flutter/material.dart';

import 'package:super_app/features/customer/delivery/delivery_page.dart';
import 'package:super_app/features/customer/food/food_page.dart';
import 'package:super_app/features/customer/ride/ride_page.dart';
import 'package:super_app/features/customer/shopping/shopping_page.dart';

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
          children: [
            _ServiceCategoryItem(
              icon: Icons.restaurant,
              title: 'Food',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FoodPage(),
                  ),
                );
              },
            ),
            _ServiceCategoryItem(
              icon: Icons.shopping_bag,
              title: 'Shopping',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ShoppingPage(),
                  ),
                );
              },
            ),
            _ServiceCategoryItem(
              icon: Icons.delivery_dining,
              title: 'Delivery',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DeliveryPage(),
                  ),
                );
              },
            ),
            _ServiceCategoryItem(
              icon: Icons.local_taxi,
              title: 'Ride',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RidePage(),
                  ),
                );
              },
            ),
            _ServiceCategoryItem(
              icon: Icons.people,
              title: 'Manpower',
              onTap: () {},
            ),
            _ServiceCategoryItem(
              icon: Icons.home_repair_service,
              title: 'Services',
              onTap: () {},
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
  final VoidCallback onTap;

  const _ServiceCategoryItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Column(
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
      ),
    );
  }
}