import 'package:flutter/material.dart';

class PopularServices extends StatelessWidget {
  const PopularServices({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Popular Services',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 128,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              _PopularServiceItem(
                icon: Icons.restaurant,
                title: 'Food Delivery',
              ),
              _PopularServiceItem(
                icon: Icons.local_taxi,
                title: 'Ride Booking',
              ),
              _PopularServiceItem(
                icon: Icons.local_shipping,
                title: 'Parcel Delivery',
              ),
              _PopularServiceItem(
                icon: Icons.home_repair_service,
                title: 'Home Services',
              ),
              _PopularServiceItem(
                icon: Icons.people,
                title: 'Manpower',
              ),
              _PopularServiceItem(
                icon: Icons.shopping_cart,
                title: 'Shopping',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PopularServiceItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const _PopularServiceItem({
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 32,
          ),
          const SizedBox(height: 6),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}