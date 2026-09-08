import 'package:super_app/features/customer/orders/models/order_model.dart';
import 'package:super_app/features/customer/orders/models/order_status.dart';
import 'package:super_app/features/customer/orders/models/order_status_history.dart';

/// Repository layer for customer orders.
///
/// This class is intentionally independent from Flutter UI.
/// Later, the data source can be changed from local/demo data
/// to Supabase without changing the UI architecture.
class OrderRepository {
  const OrderRepository();

  /// Returns all orders belonging to a customer.
  ///
  /// For now this returns demo data.
  /// Later this method will fetch real data from Supabase.
  Future<List<OrderModel>> getCustomerOrders(
    String customerId,
  ) async {
    await Future<void>.delayed(
      const Duration(milliseconds: 150),
    );

    return _demoOrders
        .where(
          (order) => order.customerId == customerId,
        )
        .toList();
  }

  /// Returns one order by its ID.
  ///
  /// Later this will query the Supabase orders table.
  Future<OrderModel?> getOrderById(
    String orderId,
  ) async {
    await Future<void>.delayed(
      const Duration(milliseconds: 100),
    );

    for (final order in _demoOrders) {
      if (order.id == orderId) {
        return order;
      }
    }

    return null;
  }

  /// Demo data.
  ///
  /// This is temporary and will be removed when
  /// Supabase becomes the real data source.
  static final List<OrderModel> _demoOrders = [
    OrderModel(
      id: 'SUP-1001',
      customerId: 'demo-customer-001',
      orderType: 'Food Order',
      status: OrderStatus.preparing,
      sellerId: 'seller-food-001',
      sellerName: 'Demo Restaurant',
      branchId: 'branch-food-001',
      items: const [
        OrderItemModel(
          productId: 'food-001',
          name: 'Chicken Biryani',
          quantity: 2,
          price: 180,
          imageUrl: null,
        ),
        OrderItemModel(
          productId: 'food-002',
          name: 'Cold Drink',
          quantity: 1,
          price: 60,
          imageUrl: null,
        ),
      ],
      itemTotal: 420,
      deliveryFee: 40,
      serviceFee: 10,
      tax: 21,
      discount: 50,
      grandTotal: 441,
      paymentMethod: 'Online Payment',
      paymentStatus: 'Paid',
      paymentId: 'PAY-DEMO-1001',
      addressId: 'address-demo-001',
      deliveryAddress: 'Demo Customer Address',
      deliveryLatitude: null,
      deliveryLongitude: null,
      customerNote: 'Please deliver carefully.',
      cancellationReason: null,
      createdAt: DateTime(2026, 9, 8, 12, 30),
      updatedAt: DateTime(2026, 9, 8, 12, 50),
      statusHistory: [
        OrderStatusHistory(
          status: OrderStatus.pending,
          timestamp: DateTime(2026, 9, 8, 12, 30),
          message: 'Order placed successfully',
        ),
        OrderStatusHistory(
          status: OrderStatus.confirmed,
          timestamp: DateTime(2026, 9, 8, 12, 35),
          message: 'Your order has been confirmed',
        ),
        OrderStatusHistory(
          status: OrderStatus.preparing,
          timestamp: DateTime(2026, 9, 8, 12, 45),
          message: 'Your order is being prepared',
        ),
      ],
    ),
    OrderModel(
      id: 'SUP-1002',
      customerId: 'demo-customer-001',
      orderType: 'Ride Booking',
      status: OrderStatus.onTheWay,
      sellerId: null,
      sellerName: null,
      branchId: null,
      deliveryPartnerId: 'driver-demo-001',
      deliveryPartnerName: 'Demo Driver',
      items: const [],
      itemTotal: 180,
      deliveryFee: 0,
      serviceFee: 10,
      tax: 9,
      discount: 0,
      grandTotal: 199,
      paymentMethod: 'Cash',
      paymentStatus: 'Pending',
      paymentId: null,
      addressId: 'address-demo-001',
      deliveryAddress: 'Demo Pickup → Demo Destination',
      deliveryLatitude: null,
      deliveryLongitude: null,
      customerNote: null,
      cancellationReason: null,
      createdAt: DateTime(2026, 9, 8, 11, 15),
      updatedAt: DateTime(2026, 9, 8, 11, 35),
      statusHistory: [
        OrderStatusHistory(
          status: OrderStatus.pending,
          timestamp: DateTime(2026, 9, 8, 11, 15),
          message: 'Ride booking requested',
        ),
        OrderStatusHistory(
          status: OrderStatus.confirmed,
          timestamp: DateTime(2026, 9, 8, 11, 20),
          message: 'Ride booking confirmed',
        ),
        OrderStatusHistory(
          status: OrderStatus.assigned,
          timestamp: DateTime(2026, 9, 8, 11, 25),
          message: 'A driver has been assigned',
        ),
        OrderStatusHistory(
          status: OrderStatus.onTheWay,
          timestamp: DateTime(2026, 9, 8, 11, 35),
          message: 'Driver is on the way',
        ),
      ],
    ),
    OrderModel(
      id: 'SUP-1003',
      customerId: 'demo-customer-001',
      orderType: 'Home Service',
      status: OrderStatus.confirmed,
      sellerId: null,
      sellerName: null,
      branchId: null,
      deliveryPartnerId: null,
      deliveryPartnerName: null,
      items: const [],
      itemTotal: 500,
      deliveryFee: 0,
      serviceFee: 50,
      tax: 27.5,
      discount: 0,
      grandTotal: 577.5,
      paymentMethod: 'Online Payment',
      paymentStatus: 'Paid',
      paymentId: 'PAY-DEMO-1003',
      addressId: 'address-demo-001',
      deliveryAddress: 'Demo Customer Address',
      deliveryLatitude: null,
      deliveryLongitude: null,
      customerNote: 'Electrician service required.',
      cancellationReason: null,
      createdAt: DateTime(2026, 9, 8, 10, 20),
      updatedAt: DateTime(2026, 9, 8, 10, 25),
      statusHistory: [
        OrderStatusHistory(
          status: OrderStatus.pending,
          timestamp: DateTime(2026, 9, 8, 10, 20),
          message: 'Service booking requested',
        ),
        OrderStatusHistory(
          status: OrderStatus.confirmed,
          timestamp: DateTime(2026, 9, 8, 10, 25),
          message: 'Your service has been confirmed',
        ),
      ],
    ),
    OrderModel(
      id: 'SUP-1004',
      customerId: 'demo-customer-001',
      orderType: 'Shopping Order',
      status: OrderStatus.delivered,
      sellerId: 'seller-shop-001',
      sellerName: 'Demo Store',
      branchId: 'branch-shop-001',
      items: const [
        OrderItemModel(
          productId: 'product-001',
          name: 'Demo Product',
          quantity: 1,
          price: 450,
          imageUrl: null,
        ),
      ],
      itemTotal: 450,
      deliveryFee: 40,
      serviceFee: 5,
      tax: 22.5,
      discount: 25,
      grandTotal: 492.5,
      paymentMethod: 'Online Payment',
      paymentStatus: 'Paid',
      paymentId: 'PAY-DEMO-1004',
      addressId: 'address-demo-001',
      deliveryAddress: 'Demo Customer Address',
      deliveryLatitude: null,
      deliveryLongitude: null,
      customerNote: null,
      cancellationReason: null,
      createdAt: DateTime(2026, 9, 7, 15, 10),
      updatedAt: DateTime(2026, 9, 7, 16, 30),
      statusHistory: [
        OrderStatusHistory(
          status: OrderStatus.pending,
          timestamp: DateTime(2026, 9, 7, 15, 10),
          message: 'Order placed successfully',
        ),
        OrderStatusHistory(
          status: OrderStatus.confirmed,
          timestamp: DateTime(2026, 9, 7, 15, 15),
          message: 'Your order has been confirmed',
        ),
        OrderStatusHistory(
          status: OrderStatus.preparing,
          timestamp: DateTime(2026, 9, 7, 15, 30),
          message: 'Your order is being prepared',
        ),
        OrderStatusHistory(
          status: OrderStatus.assigned,
          timestamp: DateTime(2026, 9, 7, 15, 45),
          message: 'A delivery partner has been assigned',
        ),
        OrderStatusHistory(
          status: OrderStatus.onTheWay,
          timestamp: DateTime(2026, 9, 7, 16, 00),
          message: 'Your order is on the way',
        ),
        OrderStatusHistory(
          status: OrderStatus.delivered,
          timestamp: DateTime(2026, 9, 7, 16, 30),
          message: 'Your order has been delivered',
        ),
      ],
    ),
    OrderModel(
      id: 'SUP-1005',
      customerId: 'demo-customer-001',
      orderType: 'Parcel Delivery',
      status: OrderStatus.completed,
      sellerId: null,
      sellerName: null,
      branchId: null,
      deliveryPartnerId: 'delivery-demo-002',
      deliveryPartnerName: 'Demo Delivery Partner',
      items: const [],
      itemTotal: 120,
      deliveryFee: 50,
      serviceFee: 5,
      tax: 8.75,
      discount: 10,
      grandTotal: 173.75,
      paymentMethod: 'Cash',
      paymentStatus: 'Paid',
      paymentId: null,
      addressId: 'address-demo-001',
      deliveryAddress: 'Demo Customer Address',
      deliveryLatitude: null,
      deliveryLongitude: null,
      customerNote: 'Handle with care.',
      cancellationReason: null,
      createdAt: DateTime(2026, 9, 6, 14, 00),
      updatedAt: DateTime(2026, 9, 6, 15, 10),
      statusHistory: [
        OrderStatusHistory(
          status: OrderStatus.pending,
          timestamp: DateTime(2026, 9, 6, 14, 00),
          message: 'Parcel delivery requested',
        ),
        OrderStatusHistory(
          status: OrderStatus.confirmed,
          timestamp: DateTime(2026, 9, 6, 14, 05),
          message: 'Delivery request confirmed',
        ),
        OrderStatusHistory(
          status: OrderStatus.assigned,
          timestamp: DateTime(2026, 9, 6, 14, 15),
          message: 'A delivery partner has been assigned',
        ),
        OrderStatusHistory(
          status: OrderStatus.onTheWay,
          timestamp: DateTime(2026, 9, 6, 14, 30),
          message: 'Parcel is on the way',
        ),
        OrderStatusHistory(
          status: OrderStatus.delivered,
          timestamp: DateTime(2026, 9, 6, 15, 00),
          message: 'Parcel delivered successfully',
        ),
        OrderStatusHistory(
          status: OrderStatus.completed,
          timestamp: DateTime(2026, 9, 6, 15, 10),
          message: 'Delivery completed',
        ),
      ],
    ),
    OrderModel(
      id: 'SUP-1006',
      customerId: 'demo-customer-001',
      orderType: 'Food Order',
      status: OrderStatus.cancelled,
      sellerId: 'seller-food-002',
      sellerName: 'Demo Restaurant 2',
      branchId: 'branch-food-002',
      items: const [
        OrderItemModel(
          productId: 'food-003',
          name: 'Pizza',
          quantity: 1,
          price: 300,
          imageUrl: null,
        ),
      ],
      itemTotal: 300,
      deliveryFee: 40,
      serviceFee: 10,
      tax: 15,
      discount: 0,
      grandTotal: 365,
      paymentMethod: 'Online Payment',
      paymentStatus: 'Refund Pending',
      paymentId: 'PAY-DEMO-1006',
      addressId: 'address-demo-001',
      deliveryAddress: 'Demo Customer Address',
      deliveryLatitude: null,
      deliveryLongitude: null,
      customerNote: null,
      cancellationReason: 'Cancelled by customer',
      createdAt: DateTime(2026, 9, 5, 19, 00),
      updatedAt: DateTime(2026, 9, 5, 19, 10),
      statusHistory: [
        OrderStatusHistory(
          status: OrderStatus.pending,
          timestamp: DateTime(2026, 9, 5, 19, 00),
          message: 'Order placed successfully',
        ),
        OrderStatusHistory(
          status: OrderStatus.cancelled,
          timestamp: DateTime(2026, 9, 5, 19, 10),
          message: 'Order was cancelled',
        ),
      ],
    ),
  ];
}