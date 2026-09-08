import 'package:flutter/material.dart';
import 'package:super_app/features/customer/orders/models/order_status.dart';

class OrderDetailsPage extends StatelessWidget {
  final String orderType;
  final OrderStatus status;
  final String orderId;

  const OrderDetailsPage({
    super.key,
    required this.orderType,
    required this.status,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Order Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _OrderHeader(
              orderType: orderType,
              status: status,
              orderId: orderId,
            ),
            const SizedBox(height: 20),
            const Text(
              'Order Status',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _StatusTimeline(currentStatus: status),
            const SizedBox(height: 24),
            const Text(
              'Order Items',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const _OrderItemsCard(),
            const SizedBox(height: 24),
            const Text(
              'Price Summary',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const _PriceSummaryCard(),
            const SizedBox(height: 24),
            const Text(
              'Order Information',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const _InfoCard(),
            const SizedBox(height: 24),
            const Text(
              'Payment Information',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const _PaymentCard(),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.support_agent_outlined),
                label: const Text('Need Help?'),
                style: OutlinedButton.styleFrom(
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

class _OrderHeader extends StatelessWidget {
  final String orderType;
  final OrderStatus status;
  final String orderId;

  const _OrderHeader({
    required this.orderType,
    required this.status,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: colorScheme.primaryContainer,
      ),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorScheme.surface,
            ),
            child: Icon(
              Icons.receipt_long_rounded,
              size: 32,
              color: colorScheme.primary,
            ),
          ),
          const SizedBox(height: 14),
          Text(
            orderType,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Order ID: $orderId',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 7,
            ),
            decoration: BoxDecoration(
              color: colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status.label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusTimeline extends StatelessWidget {
  final OrderStatus currentStatus;

  const _StatusTimeline({
    required this.currentStatus,
  });

  @override
  Widget build(BuildContext context) {
    final steps = [
      _StatusStep(
        status: OrderStatus.confirmed,
        icon: Icons.check_circle_outline,
        title: 'Order Confirmed',
      ),
      _StatusStep(
        status: OrderStatus.preparing,
        icon: Icons.restaurant_menu,
        title: 'Preparing',
      ),
      _StatusStep(
        status: OrderStatus.assigned,
        icon: Icons.person_pin_circle_outlined,
        title: 'Partner Assigned',
      ),
      _StatusStep(
        status: OrderStatus.onTheWay,
        icon: Icons.delivery_dining,
        title: 'On the Way',
      ),
      _StatusStep(
        status: OrderStatus.delivered,
        icon: Icons.home_outlined,
        title: 'Delivered',
      ),
    ];

    final currentIndex = _getCurrentIndex(steps);

    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: List.generate(
            steps.length,
            (index) {
              final step = steps[index];
              final completed = index <= currentIndex;

              return _TimelineItem(
                icon: step.icon,
                title: step.title,
                subtitle: _getSubtitle(step.status),
                completed: completed,
                isCurrent: index == currentIndex,
                isLast: index == steps.length - 1,
              );
            },
          ),
        ),
      ),
    );
  }

  int _getCurrentIndex(List<_StatusStep> steps) {
    if (currentStatus == OrderStatus.pending) {
      return -1;
    }

    if (currentStatus == OrderStatus.cancelled ||
        currentStatus == OrderStatus.failed) {
      return -1;
    }

    if (currentStatus == OrderStatus.completed) {
      return steps.length - 1;
    }

    final index = steps.indexWhere(
      (step) => step.status == currentStatus,
    );

    if (index != -1) {
      return index;
    }

    if (currentStatus == OrderStatus.ready) {
      return 1;
    }

    return 0;
  }

  String _getSubtitle(OrderStatus status) {
    if (status == currentStatus) {
      return status.description;
    }

    if (_isBefore(status)) {
      return 'Completed';
    }

    return status.description;
  }

  bool _isBefore(OrderStatus status) {
    const order = [
      OrderStatus.confirmed,
      OrderStatus.preparing,
      OrderStatus.assigned,
      OrderStatus.onTheWay,
      OrderStatus.delivered,
    ];

    final currentIndex = order.indexOf(currentStatus);
    final statusIndex = order.indexOf(status);

    if (currentStatus == OrderStatus.completed) {
      return true;
    }

    if (currentIndex == -1 || statusIndex == -1) {
      return false;
    }

    return statusIndex < currentIndex;
  }
}

class _StatusStep {
  final OrderStatus status;
  final IconData icon;
  final String title;

  const _StatusStep({
    required this.status,
    required this.icon,
    required this.title,
  });
}

class _TimelineItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool completed;
  final bool isCurrent;
  final bool isLast;

  const _TimelineItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.completed,
    required this.isCurrent,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 34,
          child: Column(
            children: [
              Icon(
                completed
                    ? Icons.check_circle
                    : icon,
                size: 24,
                color: completed
                    ? colorScheme.primary
                    : Colors.grey.shade400,
              ),
              if (!isLast)
                Container(
                  width: 2,
                  height: 42,
                  margin: const EdgeInsets.symmetric(
                    vertical: 4,
                  ),
                  color: completed
                      ? colorScheme.primary
                      : Colors.grey.shade300,
                ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: completed
                        ? Colors.black87
                        : Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: isCurrent
                        ? colorScheme.primary
                        : Colors.grey.shade600,
                    fontWeight: isCurrent
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                ),
                if (!isLast) const SizedBox(height: 18),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _OrderItemsCard extends StatelessWidget {
  const _OrderItemsCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _OrderItem(
              icon: Icons.fastfood_outlined,
              name: 'Sample Food Item',
              quantity: '2 ×',
              price: '₹240.00',
            ),
            Divider(height: 24),
            _OrderItem(
              icon: Icons.local_drink_outlined,
              name: 'Sample Beverage',
              quantity: '1 ×',
              price: '₹80.00',
            ),
            Divider(height: 24),
            _OrderItem(
              icon: Icons.shopping_bag_outlined,
              name: 'Sample Product',
              quantity: '1 ×',
              price: '₹150.00',
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderItem extends StatelessWidget {
  final IconData icon;
  final String name;
  final String quantity;
  final String price;

  const _OrderItem({
    required this.icon,
    required this.name,
    required this.quantity,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: colorScheme.primaryContainer,
          ),
          child: Icon(
            icon,
            color: colorScheme.primary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                quantity,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Text(
          price,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _PriceSummaryCard extends StatelessWidget {
  const _PriceSummaryCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _PriceRow(
              title: 'Item Total',
              value: '₹470.00',
            ),
            SizedBox(height: 12),
            _PriceRow(
              title: 'Delivery Fee',
              value: '₹40.00',
            ),
            SizedBox(height: 12),
            _PriceRow(
              title: 'Discount',
              value: '-₹50.00',
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Divider(height: 1),
            ),
            _PriceRow(
              title: 'Grand Total',
              value: '₹460.00',
              isTotal: true,
            ),
          ],
        ),
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String title;
  final String value;
  final bool isTotal;

  const _PriceRow({
    required this.title,
    required this.value,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 17 : 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _InfoRow(
              icon: Icons.shopping_bag_outlined,
              title: 'Order Type',
              value: 'Super App Order',
            ),
            Divider(height: 24),
            _InfoRow(
              icon: Icons.location_on_outlined,
              title: 'Delivery Address',
              value: 'Your selected address',
            ),
            Divider(height: 24),
            _InfoRow(
              icon: Icons.access_time_outlined,
              title: 'Order Time',
              value: 'Today',
            ),
          ],
        ),
      ),
    );
  }
}

class _PaymentCard extends StatelessWidget {
  const _PaymentCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            _InfoRow(
              icon: Icons.account_balance_wallet_outlined,
              title: 'Payment Method',
              value: 'Online Payment',
            ),
            Divider(height: 24),
            _InfoRow(
              icon: Icons.payments_outlined,
              title: 'Total Amount',
              value: '₹460.00',
            ),
            Divider(height: 24),
            _InfoRow(
              icon: Icons.verified_outlined,
              title: 'Payment Status',
              value: 'Pending',
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 23,
          color: colorScheme.primary,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}