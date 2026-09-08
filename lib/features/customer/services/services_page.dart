import 'package:flutter/material.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Services',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: const [
          _ServiceCard(
            icon: Icons.restaurant,
            title: 'Food Delivery',
          ),
          _ServiceCard(
            icon: Icons.local_taxi,
            title: 'Ride Booking',
          ),
          _ServiceCard(
            icon: Icons.local_shipping,
            title: 'Parcel Delivery',
          ),
          _ServiceCard(
            icon: Icons.home_repair_service,
            title: 'Home Services',
          ),
          _ServiceCard(
            icon: Icons.people,
            title: 'Manpower',
          ),
          _ServiceCard(
            icon: Icons.shopping_cart,
            title: 'Shopping',
          ),
        ],
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;

  const _ServiceCard({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 42,
          ),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}