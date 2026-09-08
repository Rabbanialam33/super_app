import 'package:super_app/features/customer/orders/models/order_status.dart';
import 'package:super_app/features/customer/orders/models/order_status_history.dart';

class OrderModel {
  final String id;
  final String customerId;
  final String orderType;
  final OrderStatus status;
  final List<OrderItemModel> items;
  final double itemTotal;
  final double deliveryFee;
  final double discount;
  final double grandTotal;
  final String paymentMethod;
  final String paymentStatus;
  final String deliveryAddress;
  final DateTime createdAt;
  final List<OrderStatusHistory> statusHistory;

  const OrderModel({
    required this.id,
    required this.customerId,
    required this.orderType,
    required this.status,
    required this.items,
    required this.itemTotal,
    required this.deliveryFee,
    required this.discount,
    required this.grandTotal,
    required this.paymentMethod,
    required this.paymentStatus,
    required this.deliveryAddress,
    required this.createdAt,
    required this.statusHistory,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customer_id': customerId,
      'order_type': orderType,
      'status': status.name,
      'items': items.map((item) => item.toMap()).toList(),
      'item_total': itemTotal,
      'delivery_fee': deliveryFee,
      'discount': discount,
      'grand_total': grandTotal,
      'payment_method': paymentMethod,
      'payment_status': paymentStatus,
      'delivery_address': deliveryAddress,
      'created_at': createdAt.toIso8601String(),
      'status_history':
          statusHistory.map((history) => history.toMap()).toList(),
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    final statusName = map['status'] as String? ?? 'pending';

    final status = OrderStatus.values.firstWhere(
      (item) => item.name == statusName,
      orElse: () => OrderStatus.pending,
    );

    final rawItems = map['items'] as List<dynamic>? ?? [];

    final rawHistory =
        map['status_history'] as List<dynamic>? ?? [];

    return OrderModel(
      id: map['id'] as String? ?? '',
      customerId: map['customer_id'] as String? ?? '',
      orderType: map['order_type'] as String? ?? 'Order',
      status: status,
      items: rawItems
          .whereType<Map<String, dynamic>>()
          .map(OrderItemModel.fromMap)
          .toList(),
      itemTotal: _toDouble(map['item_total']),
      deliveryFee: _toDouble(map['delivery_fee']),
      discount: _toDouble(map['discount']),
      grandTotal: _toDouble(map['grand_total']),
      paymentMethod:
          map['payment_method'] as String? ?? 'Online Payment',
      paymentStatus:
          map['payment_status'] as String? ?? 'Pending',
      deliveryAddress:
          map['delivery_address'] as String? ?? '',
      createdAt: DateTime.tryParse(
            map['created_at'] as String? ?? '',
          ) ??
          DateTime.now(),
      statusHistory: rawHistory
          .whereType<Map<String, dynamic>>()
          .map(OrderStatusHistory.fromMap)
          .toList(),
    );
  }

  static double _toDouble(dynamic value) {
    if (value is num) {
      return value.toDouble();
    }

    return double.tryParse(value?.toString() ?? '') ?? 0.0;
  }
}

class OrderItemModel {
  final String productId;
  final String name;
  final int quantity;
  final double price;
  final String? imageUrl;

  const OrderItemModel({
    required this.productId,
    required this.name,
    required this.quantity,
    required this.price,
    this.imageUrl,
  });

  double get total => price * quantity;

  Map<String, dynamic> toMap() {
    return {
      'product_id': productId,
      'name': name,
      'quantity': quantity,
      'price': price,
      'image_url': imageUrl,
    };
  }

  factory OrderItemModel.fromMap(Map<String, dynamic> map) {
    return OrderItemModel(
      productId: map['product_id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      quantity: _toInt(map['quantity']),
      price: _toDouble(map['price']),
      imageUrl: map['image_url'] as String?,
    );
  }

  static int _toInt(dynamic value) {
    if (value is int) {
      return value;
    }

    if (value is num) {
      return value.toInt();
    }

    return int.tryParse(value?.toString() ?? '') ?? 0;
  }

  static double _toDouble(dynamic value) {
    if (value is num) {
      return value.toDouble();
    }

    return double.tryParse(value?.toString() ?? '') ?? 0.0;
  }
}