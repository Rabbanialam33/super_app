import 'package:flutter/material.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'My Orders',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Active'),
              Tab(text: 'Completed'),
              Tab(text: 'Cancelled'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _ActiveOrders(),
            _CompletedOrders(),
            _CancelledOrders(),
          ],
        ),
      ),
    );
  }
}

class _ActiveOrders extends StatelessWidget {
  const _ActiveOrders();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _OrderCard(
          icon: Icons.restaurant,
          title: 'Food Order',
          subtitle: 'Your food order is being prepared',
          status: 'Preparing',
          statusIcon: Icons.restaurant_menu,
        ),
        SizedBox(height: 12),
        _OrderCard(
          icon: Icons.local_taxi,
          title: 'Ride Booking',
          subtitle: 'Driver is on the way',
          status: 'On the way',
          statusIcon: Icons.directions_car,
        ),
        SizedBox(height: 12),
        _OrderCard(
          icon: Icons.home_repair_service,
          title: 'Home Service',
          subtitle: 'Electrician service booked',
          status: 'Confirmed',
          statusIcon: Icons.check_circle_outline,
        ),
      ],
    );
  }
}

class _CompletedOrders extends StatelessWidget {
  const _CompletedOrders();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _OrderCard(
          icon: Icons.shopping_bag,
          title: 'Shopping Order',
          subtitle: 'Order delivered successfully',
          status: 'Delivered',
          statusIcon: Icons.done_all,
        ),
        SizedBox(height: 12),
        _OrderCard(
          icon: Icons.delivery_dining,
          title: 'Parcel Delivery',
          subtitle: 'Parcel delivered successfully',
          status: 'Completed',
          statusIcon: Icons.done_all,
        ),
      ],
    );
  }
}

class _CancelledOrders extends StatelessWidget {
  const _CancelledOrders();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: const [
        _OrderCard(
          icon: Icons.restaurant,
          title: 'Food Order',
          subtitle: 'Order was cancelled',
          status: 'Cancelled',
          statusIcon: Icons.cancel_outlined,
        ),
      ],
    );
  }
}

class _OrderCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String status;
  final IconData statusIcon;

  const _OrderCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.status,
    required this.statusIcon,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: colorScheme.primaryContainer,
                  ),
                  child: Icon(
                    icon,
                    color: colorScheme.primary,
                    size: 26,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        subtitle,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            const Divider(height: 1),

            const SizedBox(height: 14),

            Row(
              children: [
                Icon(
                  statusIcon,
                  size: 18,
                  color: colorScheme.primary,
                ),
                const SizedBox(width: 7),
                Expanded(
                  child: Text(
                    status,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.primary,
                    ),
                  ),
                ),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('View Details'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}