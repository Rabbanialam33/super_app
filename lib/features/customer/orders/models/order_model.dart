import 'package:super_app/features/customer/orders/models/order_status.dart';
import 'package:super_app/features/customer/orders/models/order_status_history.dart';

class OrderModel {
  final String id;
  final String customerId;

  /// Food, Shopping, Delivery, Ride, Manpower, Service etc.
  final String orderType;

  final OrderStatus status;

  /// Seller / vendor information.
  final String? sellerId;
  final String? sellerName;
  final String? branchId;

  /// Delivery partner information.
  final String? deliveryPartnerId;
  final String? deliveryPartnerName;

  /// Order items.
  final List<OrderItemModel> items;

  /// Price information.
  final double itemTotal;
  final double deliveryFee;
  final double serviceFee;
  final double tax;
  final double discount;
  final double grandTotal;

  /// Payment information.
  final String paymentMethod;
  final String paymentStatus;
  final String? paymentId;

  /// Delivery information.
  final String? addressId;
  final String deliveryAddress;
  final double? deliveryLatitude;
  final double? deliveryLongitude;

  /// Additional order information.
  final String? customerNote;
  final String? cancellationReason;

  /// Date/time information.
  final DateTime createdAt;
  final DateTime? updatedAt;

  /// Complete status history.
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
    this.sellerId,
    this.sellerName,
    this.branchId,
    this.deliveryPartnerId,
    this.deliveryPartnerName,
    this.serviceFee = 0.0,
    this.tax = 0.0,
    this.paymentId,
    this.addressId,
    this.deliveryLatitude,
    this.deliveryLongitude,
    this.customerNote,
    this.cancellationReason,
    this.updatedAt,
  });

  /// Total before discount.
  double get subtotal =>
      itemTotal + deliveryFee + serviceFee + tax;

  /// Returns true when the order is currently active.
  bool get isActive {
    return !status.isCompleted && !status.isCancelled;
  }

  /// Returns true when a delivery partner has been assigned.
  bool get hasDeliveryPartner {
    return deliveryPartnerId != null &&
        deliveryPartnerId!.isNotEmpty;
  }

  /// Returns true when seller information is available.
  bool get hasSeller {
    return sellerId != null && sellerId!.isNotEmpty;
  }

  /// Convert model into a Map.
  ///
  /// The field names are kept Supabase/PostgreSQL friendly.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customer_id': customerId,
      'order_type': orderType,
      'status': status.name,

      'seller_id': sellerId,
      'seller_name': sellerName,
      'branch_id': branchId,

      'delivery_partner_id': deliveryPartnerId,
      'delivery_partner_name': deliveryPartnerName,

      'items': items.map((item) => item.toMap()).toList(),

      'item_total': itemTotal,
      'delivery_fee': deliveryFee,
      'service_fee': serviceFee,
      'tax': tax,
      'discount': discount,
      'grand_total': grandTotal,

      'payment_method': paymentMethod,
      'payment_status': paymentStatus,
      'payment_id': paymentId,

      'address_id': addressId,
      'delivery_address': deliveryAddress,
      'delivery_latitude': deliveryLatitude,
      'delivery_longitude': deliveryLongitude,

      'customer_note': customerNote,
      'cancellation_reason': cancellationReason,

      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),

      'status_history':
          statusHistory.map((history) => history.toMap()).toList(),
    };
  }

  /// Create an OrderModel from a Map.
  ///
  /// This will be useful later when reading orders from Supabase.
  factory OrderModel.fromMap(Map<String, dynamic> map) {
    final statusName =
        map['status']?.toString() ?? 'pending';

    final status = OrderStatus.values.firstWhere(
      (item) => item.name == statusName,
      orElse: () => OrderStatus.pending,
    );

    final rawItems = _toList(map['items']);
    final rawHistory = _toList(map['status_history']);

    return OrderModel(
      id: map['id']?.toString() ?? '',
      customerId: map['customer_id']?.toString() ?? '',
      orderType:
          map['order_type']?.toString() ?? 'Order',
      status: status,

      sellerId: _toNullableString(map['seller_id']),
      sellerName: _toNullableString(map['seller_name']),
      branchId: _toNullableString(map['branch_id']),

      deliveryPartnerId:
          _toNullableString(map['delivery_partner_id']),
      deliveryPartnerName:
          _toNullableString(map['delivery_partner_name']),

      items: rawItems
          .map(_toMap)
          .whereType<Map<String, dynamic>>()
          .map(OrderItemModel.fromMap)
          .toList(),

      itemTotal: _toDouble(map['item_total']),
      deliveryFee: _toDouble(map['delivery_fee']),
      serviceFee: _toDouble(map['service_fee']),
      tax: _toDouble(map['tax']),
      discount: _toDouble(map['discount']),
      grandTotal: _toDouble(map['grand_total']),

      paymentMethod:
          map['payment_method']?.toString() ??
              'Online Payment',

      paymentStatus:
          map['payment_status']?.toString() ??
              'Pending',

      paymentId: _toNullableString(map['payment_id']),

      addressId:
          _toNullableString(map['address_id']),

      deliveryAddress:
          map['delivery_address']?.toString() ?? '',

      deliveryLatitude:
          _toNullableDouble(map['delivery_latitude']),

      deliveryLongitude:
          _toNullableDouble(map['delivery_longitude']),

      customerNote:
          _toNullableString(map['customer_note']),

      cancellationReason:
          _toNullableString(
            map['cancellation_reason'],
          ),

      createdAt:
          _toDateTime(map['created_at']),

      updatedAt:
          _toNullableDateTime(map['updated_at']),

      statusHistory: rawHistory
          .map(_toMap)
          .whereType<Map<String, dynamic>>()
          .map(OrderStatusHistory.fromMap)
          .toList(),
    );
  }

  /// Create a modified copy of this order.
  ///
  /// Useful when an order status changes without
  /// rebuilding the complete object manually.
  OrderModel copyWith({
    String? id,
    String? customerId,
    String? orderType,
    OrderStatus? status,
    String? sellerId,
    String? sellerName,
    String? branchId,
    String? deliveryPartnerId,
    String? deliveryPartnerName,
    List<OrderItemModel>? items,
    double? itemTotal,
    double? deliveryFee,
    double? serviceFee,
    double? tax,
    double? discount,
    double? grandTotal,
    String? paymentMethod,
    String? paymentStatus,
    String? paymentId,
    String? addressId,
    String? deliveryAddress,
    double? deliveryLatitude,
    double? deliveryLongitude,
    String? customerNote,
    String? cancellationReason,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<OrderStatusHistory>? statusHistory,
  }) {
    return OrderModel(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      orderType: orderType ?? this.orderType,
      status: status ?? this.status,

      sellerId: sellerId ?? this.sellerId,
      sellerName: sellerName ?? this.sellerName,
      branchId: branchId ?? this.branchId,

      deliveryPartnerId:
          deliveryPartnerId ?? this.deliveryPartnerId,
      deliveryPartnerName:
          deliveryPartnerName ?? this.deliveryPartnerName,

      items: items ?? this.items,

      itemTotal: itemTotal ?? this.itemTotal,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      serviceFee: serviceFee ?? this.serviceFee,
      tax: tax ?? this.tax,
      discount: discount ?? this.discount,
      grandTotal: grandTotal ?? this.grandTotal,

      paymentMethod:
          paymentMethod ?? this.paymentMethod,
      paymentStatus:
          paymentStatus ?? this.paymentStatus,
      paymentId: paymentId ?? this.paymentId,

      addressId: addressId ?? this.addressId,
      deliveryAddress:
          deliveryAddress ?? this.deliveryAddress,

      deliveryLatitude:
          deliveryLatitude ?? this.deliveryLatitude,
      deliveryLongitude:
          deliveryLongitude ?? this.deliveryLongitude,

      customerNote:
          customerNote ?? this.customerNote,
      cancellationReason:
          cancellationReason ?? this.cancellationReason,

      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,

      statusHistory:
          statusHistory ?? this.statusHistory,
    );
  }

  static List<dynamic> _toList(dynamic value) {
    if (value is List) {
      return value;
    }

    return const [];
  }

  static Map<String, dynamic>? _toMap(dynamic value) {
    if (value is Map<String, dynamic>) {
      return value;
    }

    if (value is Map) {
      return Map<String, dynamic>.from(value);
    }

    return null;
  }

  static String? _toNullableString(dynamic value) {
    if (value == null) {
      return null;
    }

    final text = value.toString().trim();

    if (text.isEmpty) {
      return null;
    }

    return text;
  }

  static double _toDouble(dynamic value) {
    if (value is num) {
      return value.toDouble();
    }

    return double.tryParse(
          value?.toString() ?? '',
        ) ??
        0.0;
  }

  static double? _toNullableDouble(dynamic value) {
    if (value == null) {
      return null;
    }

    if (value is num) {
      return value.toDouble();
    }

    return double.tryParse(
      value.toString(),
    );
  }

  static DateTime _toDateTime(dynamic value) {
    if (value is DateTime) {
      return value;
    }

    return DateTime.tryParse(
          value?.toString() ?? '',
        ) ??
        DateTime.now();
  }

  static DateTime? _toNullableDateTime(dynamic value) {
    if (value == null) {
      return null;
    }

    if (value is DateTime) {
      return value;
    }

    return DateTime.tryParse(
      value.toString(),
    );
  }
}

class OrderItemModel {
  final String productId;
  final String name;
  final int quantity;
  final double price;
  final String? imageUrl;

  /// Optional variant information.
  final String? variantId;
  final String? variantName;

  const OrderItemModel({
    required this.productId,
    required this.name,
    required this.quantity,
    required this.price,
    this.imageUrl,
    this.variantId,
    this.variantName,
  });

  double get total => price * quantity;

  Map<String, dynamic> toMap() {
    return {
      'product_id': productId,
      'name': name,
      'quantity': quantity,
      'price': price,
      'image_url': imageUrl,
      'variant_id': variantId,
      'variant_name': variantName,
    };
  }

  factory OrderItemModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return OrderItemModel(
      productId:
          map['product_id']?.toString() ?? '',
      name:
          map['name']?.toString() ?? '',
      quantity:
          _toInt(map['quantity']),
      price:
          _toDouble(map['price']),
      imageUrl:
          _toNullableString(map['image_url']),
      variantId:
          _toNullableString(map['variant_id']),
      variantName:
          _toNullableString(map['variant_name']),
    );
  }

  OrderItemModel copyWith({
    String? productId,
    String? name,
    int? quantity,
    double? price,
    String? imageUrl,
    String? variantId,
    String? variantName,
  }) {
    return OrderItemModel(
      productId: productId ?? this.productId,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      variantId: variantId ?? this.variantId,
      variantName: variantName ?? this.variantName,
    );
  }

  static int _toInt(dynamic value) {
    if (value is int) {
      return value;
    }

    if (value is num) {
      return value.toInt();
    }

    return int.tryParse(
          value?.toString() ?? '',
        ) ??
        0;
  }

  static double _toDouble(dynamic value) {
    if (value is num) {
      return value.toDouble();
    }

    return double.tryParse(
          value?.toString() ?? '',
        ) ??
        0.0;
  }

  static String? _toNullableString(dynamic value) {
    if (value == null) {
      return null;
    }

    final text = value.toString().trim();

    if (text.isEmpty) {
      return null;
    }

    return text;
  }
}