import 'package:flutter/material.dart';
import 'package:super_app/widgets/home/popular_services.dart';
import 'package:super_app/widgets/home/service_categories.dart';
import 'package:super_app/widgets/home/promotional_banner.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Super App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notifications_outlined,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Location
            Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Deliver to your location',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Professional Search Bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search food, services, rides...',
                prefixIcon: const Icon(
                  Icons.search,
                ),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.tune,
                  ),
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Promotional Banner
            const PromotionalBanner(),

            const SizedBox(height: 28),

            // Service Categories
            const ServiceCategories(),

            const SizedBox(height: 32),

            // Popular Services
            const PopularServices(),
          ],
        ),
      ),
    );
  }
}