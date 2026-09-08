import 'package:flutter/material.dart';

class ServicesHomePage extends StatelessWidget {
  const ServicesHomePage({super.key});

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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Get things done with trusted services',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Find reliable professionals and local services near you',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 24),

            // Search
            TextField(
              decoration: InputDecoration(
                hintText: 'Search services...',
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
              'Popular Services',
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
                _ServiceItem(
                  icon: Icons.plumbing,
                  title: 'Plumber',
                ),
                _ServiceItem(
                  icon: Icons.electrical_services,
                  title: 'Electrician',
                ),
                _ServiceItem(
                  icon: Icons.cleaning_services,
                  title: 'Cleaning',
                ),
                _ServiceItem(
                  icon: Icons.handyman,
                  title: 'Carpenter',
                ),
                _ServiceItem(
                  icon: Icons.format_paint,
                  title: 'Painting',
                ),
                _ServiceItem(
                  icon: Icons.ac_unit,
                  title: 'AC Service',
                ),
                _ServiceItem(
                  icon: Icons.water_drop,
                  title: 'Water Service',
                ),
                _ServiceItem(
                  icon: Icons.local_laundry_service,
                  title: 'Laundry',
                ),
                _ServiceItem(
                  icon: Icons.more_horiz,
                  title: 'More',
                ),
              ],
            ),

            const SizedBox(height: 32),

            const Text(
              'Trusted Professionals',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            const _ProfessionalCard(
              name: 'Verified Service Expert',
              service: 'Electrical & Home Repair',
              rating: '4.9',
            ),

            const SizedBox(height: 12),

            const _ProfessionalCard(
              name: 'Local Home Service',
              service: 'Cleaning & Maintenance',
              rating: '4.8',
            ),

            const SizedBox(height: 28),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.business_center_outlined),
                label: const Text(
                  'Become a Service Provider',
                ),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ServiceItem extends StatelessWidget {
  final IconData icon;
  final String title;

  const _ServiceItem({
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
            color: Theme.of(context)
                .colorScheme
                .primaryContainer,
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

class _ProfessionalCard extends StatelessWidget {
  final String name;
  final String service;
  final String rating;

  const _ProfessionalCard({
    required this.name,
    required this.service,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.person),
        ),
        title: Text(
          name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(service),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.star,
              size: 18,
            ),
            const SizedBox(width: 4),
            Text(
              rating,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}