import 'package:flutter/material.dart';

class RidePage extends StatelessWidget {
  const RidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Ride',
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
              'Where do you want to go?',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Book a ride quickly and safely',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 24),
            Card(
              elevation: 1,
              child: ListTile(
                leading: const Icon(
                  Icons.my_location,
                ),
                title: const Text(
                  'Pickup Location',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: const Text(
                  'Choose your pickup point',
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                ),
                onTap: () {},
              ),
            ),
            const SizedBox(height: 12),
            Card(
              elevation: 1,
              child: ListTile(
                leading: const Icon(
                  Icons.location_on_outlined,
                ),
                title: const Text(
                  'Drop Location',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: const Text(
                  'Where should we take you?',
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                ),
                onTap: () {},
              ),
            ),
            const SizedBox(height: 28),
            const Text(
              'Choose a Ride',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: const [
                _RideTypeCard(
                  icon: Icons.two_wheeler,
                  title: 'Bike',
                  subtitle: 'Affordable & fast',
                ),
                _RideTypeCard(
                  icon: Icons.local_taxi,
                  title: 'Auto',
                  subtitle: 'Comfortable ride',
                ),
                _RideTypeCard(
                  icon: Icons.directions_car,
                  title: 'Car',
                  subtitle: 'Private ride',
                ),
                _RideTypeCard(
                  icon: Icons.airport_shuttle,
                  title: 'XL',
                  subtitle: 'For groups',
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text(
              'How it works',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const _RideStep(
              number: '1',
              title: 'Enter locations',
              subtitle: 'Choose pickup and drop locations',
            ),
            const _RideStep(
              number: '2',
              title: 'Choose a ride',
              subtitle: 'Select the ride that suits you',
            ),
            const _RideStep(
              number: '3',
              title: 'Book & track',
              subtitle: 'Confirm your ride and track it live',
            ),
          ],
        ),
      ),
    );
  }
}

class _RideTypeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _RideTypeCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: Icon(
                icon,
                size: 28,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RideStep extends StatelessWidget {
  final String number;
  final String title;
  final String subtitle;

  const _RideStep({
    required this.number,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        child: Text(number),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(subtitle),
    );
  }
}