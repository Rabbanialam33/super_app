import 'package:flutter/material.dart';

import 'package:super_app/features/customer/orders/models/order_status.dart';
import 'package:super_app/features/customer/orders/order_details/order_details_page.dart';

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
      children: [
        _OrderCard(
          icon: Icons.restaurant,
          title: 'Food Order',
          subtitle: 'Your food order is being prepared',
          status: OrderStatus.preparing,
          statusIcon: Icons.restaurant_menu,
          orderId: 'SUP-1001',
          onViewDetails: () {
            _openOrderDetails(
              context,
              orderType: 'Food Order',
              status: OrderStatus.preparing,
              orderId: 'SUP-1001',
            );
          },
        ),
        const SizedBox(height: 12),
        _OrderCard(
          icon: Icons.local_taxi,
          title: 'Ride Booking',
          subtitle: 'Driver is on the way',
          status: OrderStatus.onTheWay,
          statusIcon: Icons.directions_car,
          orderId: 'SUP-1002',
          onViewDetails: () {
            _openOrderDetails(
              context,
              orderType: 'Ride Booking',
              status: OrderStatus.onTheWay,
              orderId: 'SUP-1002',
            );
          },
        ),
        const SizedBox(height: 12),
        _OrderCard(
          icon: Icons.home_repair_service,
          title: 'Home Service',
          subtitle: 'Electrician service booked',
          status: OrderStatus.confirmed,
          statusIcon: Icons.check_circle_outline,
          orderId: 'SUP-1003',
          onViewDetails: () {
            _openOrderDetails(
              context,
              orderType: 'Home Service',
              status: OrderStatus.confirmed,
              orderId: 'SUP-1003',
            );
          },
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
      children: [
        _OrderCard(
          icon: Icons.shopping_bag,
          title: 'Shopping Order',
          subtitle: 'Order delivered successfully',
          status: OrderStatus.delivered,
          statusIcon: Icons.done_all,
          orderId: 'SUP-1004',
          onViewDetails: () {
            _openOrderDetails(
              context,
              orderType: 'Shopping Order',
              status: OrderStatus.delivered,
              orderId: 'SUP-1004',
            );
          },
        ),
        const SizedBox(height: 12),
        _OrderCard(
          icon: Icons.delivery_dining,
          title: 'Parcel Delivery',
          subtitle: 'Parcel delivered successfully',
          status: OrderStatus.completed,
          statusIcon: Icons.done_all,
          orderId: 'SUP-1005',
          onViewDetails: () {
            _openOrderDetails(
              context,
              orderType: 'Parcel Delivery',
              status: OrderStatus.completed,
              orderId: 'SUP-1005',
            );
          },
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
      children: [
        _OrderCard(
          icon: Icons.restaurant,
          title: 'Food Order',
          subtitle: 'Order was cancelled',
          status: OrderStatus.cancelled,
          statusIcon: Icons.cancel_outlined,
          orderId: 'SUP-1006',
          onViewDetails: () {
            _openOrderDetails(
              context,
              orderType: 'Food Order',
              status: OrderStatus.cancelled,
              orderId: 'SUP-1006',
            );
          },
        ),
      ],
    );
  }
}

void _openOrderDetails(
  BuildContext context, {
  required String orderType,
  required OrderStatus status,
  required String orderId,
}) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => OrderDetailsPage(
        orderType: orderType,
        status: status,
        orderId: orderId,
      ),
    ),
  );
}

class _OrderCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final OrderStatus status;
  final IconData statusIcon;
  final String orderId;
  final VoidCallback onViewDetails;

  const _OrderCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.status,
    required this.statusIcon,
    required this.orderId,
    required this.onViewDetails,
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
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Order ID: $orderId',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
            const SizedBox(height: 14),
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
                    status.label,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.primary,
                    ),
                  ),
                ),
                OutlinedButton(
                  onPressed: onViewDetails,
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