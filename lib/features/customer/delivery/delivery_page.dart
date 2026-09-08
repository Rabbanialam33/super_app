import 'package:flutter/material.dart';

class DeliveryPage extends StatelessWidget {
  const DeliveryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Delivery',
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
              'Send anything, anywhere',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Fast and reliable pickup & delivery',
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 24),

            // Pickup Location
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
                  'Select pickup location',
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                ),
                onTap: () {},
              ),
            ),

            const SizedBox(height: 12),

            // Drop Location
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
                  'Select delivery location',
                ),
                trailing: const Icon(
                  Icons.chevron_right,
                ),
                onTap: () {},
              ),
            ),

            const SizedBox(height: 28),

            const Text(
              'Delivery Services',
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
                _DeliveryServiceCard(
                  icon: Icons.local_shipping,
                  title: 'Parcel Delivery',
                  subtitle: 'Send packages',
                ),
                _DeliveryServiceCard(
                  icon: Icons.two_wheeler,
                  title: 'Bike Delivery',
                  subtitle: 'Fast local delivery',
                ),
                _DeliveryServiceCard(
                  icon: Icons.inventory_2_outlined,
                  title: 'Pickup & Drop',
                  subtitle: 'Quick pickup service',
                ),
                _DeliveryServiceCard(
                  icon: Icons.track_changes,
                  title: 'Track Delivery',
                  subtitle: 'Track your parcel',
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

            const _DeliveryStep(
              number: '1',
              title: 'Enter locations',
              subtitle: 'Choose pickup and drop locations',
            ),

            const _DeliveryStep(
              number: '2',
              title: 'Choose delivery',
              subtitle: 'Select the delivery service you need',
            ),

            const _DeliveryStep(
              number: '3',
              title: 'Confirm & track',
              subtitle: 'Confirm your order and track delivery',
            ),
          ],
        ),
      ),
    );
  }
}

class _DeliveryServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _DeliveryServiceCard({
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
                color: Theme.of(context)
                    .colorScheme
                    .primaryContainer,
              ),
              child: Icon(
                icon,
                size: 28,
                color: Theme.of(context)
                    .colorScheme
                    .primary,
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

class _DeliveryStep extends StatelessWidget {
  final String number;
  final String title;
  final String subtitle;

  const _DeliveryStep({
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