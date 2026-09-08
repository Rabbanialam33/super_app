import 'package:flutter/material.dart';

import 'package:super_app/features/customer/orders/models/order_model.dart';
import 'package:super_app/features/customer/orders/models/order_status.dart';
import 'package:super_app/features/customer/orders/models/order_status_history.dart';

class OrderDetailsPage extends StatelessWidget {
  final OrderModel? order;

  final String? orderType;
  final OrderStatus? status;
  final String? orderId;

  const OrderDetailsPage({
    super.key,
    this.order,
    this.orderType,
    this.status,
    this.orderId,
  });

  String get _orderType =>
      order?.orderType ?? orderType ?? 'Order';

  OrderStatus get _status =>
      order?.status ?? status ?? OrderStatus.pending;

  String get _orderId => order?.id ?? orderId ?? '';

  List<OrderStatusHistory> get _statusHistory {
    if (order != null && order!.statusHistory.isNotEmpty) {
      return order!.statusHistory;
    }

    return _buildFallbackStatusHistory();
  }

  List<OrderStatusHistory> _buildFallbackStatusHistory() {
    final currentStatus = _status;
    final now = DateTime.now();

    switch (currentStatus) {
      case OrderStatus.pending:
        return [
          OrderStatusHistory(
            status: OrderStatus.pending,
            timestamp: now,
            message: OrderStatus.pending.description,
          ),
        ];

      case OrderStatus.confirmed:
        return [
          OrderStatusHistory(
            status: OrderStatus.pending,
            timestamp: now.subtract(
              const Duration(minutes: 12),
            ),
            message: 'Order placed successfully',
          ),
          OrderStatusHistory(
            status: OrderStatus.confirmed,
            timestamp: now,
            message: OrderStatus.confirmed.description,
          ),
        ];

      case OrderStatus.preparing:
      case OrderStatus.ready:
        return [
          OrderStatusHistory(
            status: OrderStatus.pending,
            timestamp: now.subtract(
              const Duration(minutes: 30),
            ),
            message: 'Order placed successfully',
          ),
          OrderStatusHistory(
            status: OrderStatus.confirmed,
            timestamp: now.subtract(
              const Duration(minutes: 20),
            ),
            message: OrderStatus.confirmed.description,
          ),
          OrderStatusHistory(
            status: currentStatus == OrderStatus.ready
                ? OrderStatus.ready
                : OrderStatus.preparing,
            timestamp: now,
            message: currentStatus.description,
          ),
        ];

      case OrderStatus.assigned:
      case OrderStatus.onTheWay:
        return [
          OrderStatusHistory(
            status: OrderStatus.pending,
            timestamp: now.subtract(
              const Duration(minutes: 45),
            ),
            message: 'Order placed successfully',
          ),
          OrderStatusHistory(
            status: OrderStatus.confirmed,
            timestamp: now.subtract(
              const Duration(minutes: 35),
            ),
            message: OrderStatus.confirmed.description,
          ),
          OrderStatusHistory(
            status: OrderStatus.preparing,
            timestamp: now.subtract(
              const Duration(minutes: 25),
            ),
            message: OrderStatus.preparing.description,
          ),
          OrderStatusHistory(
            status: OrderStatus.assigned,
            timestamp: now.subtract(
              const Duration(minutes: 15),
            ),
            message: OrderStatus.assigned.description,
          ),
          if (currentStatus == OrderStatus.onTheWay)
            OrderStatusHistory(
              status: OrderStatus.onTheWay,
              timestamp: now,
              message: OrderStatus.onTheWay.description,
            ),
        ];

      case OrderStatus.delivered:
      case OrderStatus.completed:
        return [
          OrderStatusHistory(
            status: OrderStatus.pending,
            timestamp: now.subtract(
              const Duration(minutes: 60),
            ),
            message: 'Order placed successfully',
          ),
          OrderStatusHistory(
            status: OrderStatus.confirmed,
            timestamp: now.subtract(
              const Duration(minutes: 50),
            ),
            message: OrderStatus.confirmed.description,
          ),
          OrderStatusHistory(
            status: OrderStatus.preparing,
            timestamp: now.subtract(
              const Duration(minutes: 40),
            ),
            message: OrderStatus.preparing.description,
          ),
          OrderStatusHistory(
            status: OrderStatus.assigned,
            timestamp: now.subtract(
              const Duration(minutes: 30),
            ),
            message: OrderStatus.assigned.description,
          ),
          OrderStatusHistory(
            status: OrderStatus.onTheWay,
            timestamp: now.subtract(
              const Duration(minutes: 20),
            ),
            message: OrderStatus.onTheWay.description,
          ),
          OrderStatusHistory(
            status: OrderStatus.delivered,
            timestamp: now,
            message: OrderStatus.delivered.description,
          ),
        ];

      case OrderStatus.cancelled:
        return [
          OrderStatusHistory(
            status: OrderStatus.pending,
            timestamp: now.subtract(
              const Duration(minutes: 20),
            ),
            message: 'Order placed successfully',
          ),
          OrderStatusHistory(
            status: OrderStatus.cancelled,
            timestamp: now,
            message: OrderStatus.cancelled.description,
          ),
        ];

      case OrderStatus.failed:
        return [
          OrderStatusHistory(
            status: OrderStatus.pending,
            timestamp: now.subtract(
              const Duration(minutes: 15),
            ),
            message: 'Order placed successfully',
          ),
          OrderStatusHistory(
            status: OrderStatus.failed,
            timestamp: now,
            message: OrderStatus.failed.description,
          ),
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentStatus = _status;
    final history = _statusHistory;

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
              orderType: _orderType,
              status: currentStatus,
              orderId: _orderId,
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
            _StatusTimeline(
              currentStatus: currentStatus,
              history: history,
            ),
            const SizedBox(height: 24),
            const Text(
              'Order History',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _StatusHistoryCard(
              history: history,
            ),
            const SizedBox(height: 24),
            const Text(
              'Order Items',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _OrderItemsCard(
              items: order?.items,
            ),
            const SizedBox(height: 24),
            const Text(
              'Price Summary',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _PriceSummaryCard(
              itemTotal: order?.itemTotal,
              deliveryFee: order?.deliveryFee,
              discount: order?.discount,
              grandTotal: order?.grandTotal,
            ),
            const SizedBox(height: 24),
            const Text(
              'Order Information',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _InfoCard(
              orderType: order?.orderType,
              deliveryAddress: order?.deliveryAddress,
              createdAt: order?.createdAt,
            ),
            const SizedBox(height: 24),
            const Text(
              'Payment Information',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _PaymentCard(
              paymentMethod: order?.paymentMethod,
              totalAmount: order?.grandTotal,
              paymentStatus: order?.paymentStatus,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.support_agent_outlined,
                ),
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
  final List<OrderStatusHistory> history;

  const _StatusTimeline({
    required this.currentStatus,
    required this.history,
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
          children: [
            if (currentStatus == OrderStatus.pending)
              _TimelineItem(
                icon: Icons.schedule,
                title: 'Order Pending',
                subtitle: currentStatus.description,
                completed: false,
                isCurrent: true,
                isLast: true,
              )
            else if (currentStatus == OrderStatus.cancelled ||
                currentStatus == OrderStatus.failed)
              _TimelineItem(
                icon: currentStatus == OrderStatus.cancelled
                    ? Icons.cancel_outlined
                    : Icons.error_outline,
                title: currentStatus.label,
                subtitle: currentStatus.description,
                completed: false,
                isCurrent: true,
                isLast: true,
              )
            else
              ...List.generate(
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
          ],
        ),
      ),
    );
  }

  int _getCurrentIndex(List<_StatusStep> steps) {
    if (currentStatus == OrderStatus.pending ||
        currentStatus == OrderStatus.cancelled ||
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

  String _getSubtitle(OrderStatus stepStatus) {
    final matchingHistory = history.where(
      (item) => item.status == stepStatus,
    );

    if (matchingHistory.isNotEmpty) {
      final latest = matchingHistory.last;

      if (stepStatus == currentStatus) {
        return latest.message;
      }

      return 'Completed';
    }

    if (stepStatus == currentStatus) {
      return stepStatus.description;
    }

    if (_isBefore(stepStatus)) {
      return 'Completed';
    }

    return stepStatus.description;
  }

  bool _isBefore(OrderStatus stepStatus) {
    const order = [
      OrderStatus.confirmed,
      OrderStatus.preparing,
      OrderStatus.assigned,
      OrderStatus.onTheWay,
      OrderStatus.delivered,
    ];

    final currentIndex = order.indexOf(currentStatus);
    final statusIndex = order.indexOf(stepStatus);

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

class _StatusHistoryCard extends StatelessWidget {
  final List<OrderStatusHistory> history;

  const _StatusHistoryCard({
    required this.history,
  });

  String _formatTime(DateTime time) {
    final hour = time.hour % 12 == 0 ? 12 : time.hour % 12;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.hour >= 12 ? 'PM' : 'AM';

    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (history.isEmpty) {
      return Card(
        elevation: 1,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: const Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Text(
              'No order history available.',
            ),
          ),
        ),
      );
    }

    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: history.reversed.map((item) {
            final isLatest = item == history.last;

            return Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isLatest
                          ? colorScheme.primaryContainer
                          : Colors.grey.shade100,
                    ),
                    child: Icon(
                      isLatest
                          ? Icons.radio_button_checked
                          : Icons.check_circle_outline,
                      size: 20,
                      color: isLatest
                          ? colorScheme.primary
                          : Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                item.statusLabel,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              _formatTime(item.timestamp),
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.message,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
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
                completed ? Icons.check_circle : icon,
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
              crossAxisAlignment:
                  CrossAxisAlignment.start,
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
  final List<OrderItemModel>? items;

  const _OrderItemsCard({
    this.items,
  });

  @override
  Widget build(BuildContext context) {
    final displayItems = items == null || items!.isEmpty
        ? const <OrderItemModel>[]
        : items!;

    return Card(
      elevation: 1,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: displayItems.isEmpty
            ? const Column(
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
              )
            : Column(
                children: List.generate(
                  displayItems.length,
                  (index) {
                    final item = displayItems[index];

                    return Column(
                      children: [
                        _OrderItem(
                          icon: Icons.shopping_bag_outlined,
                          name: item.name,
                          quantity: '${item.quantity} ×',
                          price:
                              '₹${item.total.toStringAsFixed(2)}',
                        ),
                        if (index <
                            displayItems.length - 1)
                          const Divider(height: 24),
                      ],
                    );
                  },
                ),
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
            crossAxisAlignment:
                CrossAxisAlignment.start,
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
  final double? itemTotal;
  final double? deliveryFee;
  final double? discount;
  final double? grandTotal;

  const _PriceSummaryCard({
    this.itemTotal,
    this.deliveryFee,
    this.discount,
    this.grandTotal,
  });

  String _currency(double value) {
    return '₹${value.toStringAsFixed(2)}';
  }

  @override
  Widget build(BuildContext context) {
    final hasRealData = itemTotal != null ||
        deliveryFee != null ||
        discount != null ||
        grandTotal != null;

    final resolvedItemTotal =
        hasRealData ? itemTotal ?? 0 : 470.0;
    final resolvedDeliveryFee =
        hasRealData ? deliveryFee ?? 0 : 40.0;
    final resolvedDiscount =
        hasRealData ? discount ?? 0 : 50.0;
    final resolvedGrandTotal = hasRealData
        ? grandTotal ??
            (resolvedItemTotal +
                resolvedDeliveryFee -
                resolvedDiscount)
        : 460.0;

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
            _PriceRow(
              title: 'Item Total',
              value: _currency(resolvedItemTotal),
            ),
            const SizedBox(height: 12),
            _PriceRow(
              title: 'Delivery Fee',
              value: _currency(resolvedDeliveryFee),
            ),
            const SizedBox(height: 12),
            _PriceRow(
              title: 'Discount',
              value:
                  '-${_currency(resolvedDiscount)}',
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                vertical: 14,
              ),
              child: Divider(height: 1),
            ),
            _PriceRow(
              title: 'Grand Total',
              value: _currency(resolvedGrandTotal),
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
  final String? orderType;
  final String? deliveryAddress;
  final DateTime? createdAt;

  const _InfoCard({
    this.orderType,
    this.deliveryAddress,
    this.createdAt,
  });

  String _formatDate(DateTime dateTime) {
    return '${dateTime.day.toString().padLeft(2, '0')}/'
        '${dateTime.month.toString().padLeft(2, '0')}/'
        '${dateTime.year}';
  }

  @override
  Widget build(BuildContext context) {
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
            _InfoRow(
              icon: Icons.shopping_bag_outlined,
              title: 'Order Type',
              value: orderType ?? 'Super App Order',
            ),
            const Divider(height: 24),
            _InfoRow(
              icon: Icons.location_on_outlined,
              title: 'Delivery Address',
              value: deliveryAddress == null ||
                      deliveryAddress!.isEmpty
                  ? 'Your selected address'
                  : deliveryAddress!,
            ),
            const Divider(height: 24),
            _InfoRow(
              icon: Icons.access_time_outlined,
              title: 'Order Time',
              value: createdAt == null
                  ? 'Today'
                  : _formatDate(createdAt!),
            ),
          ],
        ),
      ),
    );
  }
}

class _PaymentCard extends StatelessWidget {
  final String? paymentMethod;
  final double? totalAmount;
  final String? paymentStatus;

  const _PaymentCard({
    this.paymentMethod,
    this.totalAmount,
    this.paymentStatus,
  });

  @override
  Widget build(BuildContext context) {
    final amount = totalAmount ?? 460.0;

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
            _InfoRow(
              icon: Icons.account_balance_wallet_outlined,
              title: 'Payment Method',
              value: paymentMethod ?? 'Online Payment',
            ),
            const Divider(height: 24),
            _InfoRow(
              icon: Icons.payments_outlined,
              title: 'Total Amount',
              value: '₹${amount.toStringAsFixed(2)}',
            ),
            const Divider(height: 24),
            _InfoRow(
              icon: Icons.verified_outlined,
              title: 'Payment Status',
              value: paymentStatus ?? 'Pending',
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
            crossAxisAlignment:
                CrossAxisAlignment.start,
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