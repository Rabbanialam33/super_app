import 'package:super_app/features/customer/orders/models/order_status.dart';

class OrderStatusHistory {
  final OrderStatus status;
  final DateTime timestamp;
  final String message;

  const OrderStatusHistory({
    required this.status,
    required this.timestamp,
    required this.message,
  });

  String get statusLabel => status.label;

  Map<String, dynamic> toMap() {
    return {
      'status': status.name,
      'timestamp': timestamp.toIso8601String(),
      'message': message,
    };
  }

  factory OrderStatusHistory.fromMap(Map<String, dynamic> map) {
    final statusName = map['status'] as String? ?? 'pending';

    final status = OrderStatus.values.firstWhere(
      (item) => item.name == statusName,
      orElse: () => OrderStatus.pending,
    );

    return OrderStatusHistory(
      status: status,
      timestamp: DateTime.tryParse(
            map['timestamp'] as String? ?? '',
          ) ??
          DateTime.now(),
      message: map['message'] as String? ?? '',
    );
  }
}