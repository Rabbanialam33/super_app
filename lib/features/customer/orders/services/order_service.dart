import 'package:super_app/features/customer/orders/models/order_model.dart';
import 'package:super_app/features/customer/orders/models/order_status.dart';
import 'package:super_app/features/customer/orders/repository/order_repository.dart';

/// Service layer for customer orders.
///
/// The service layer contains business-level operations.
/// UI should communicate with this layer instead of directly
/// communicating with the repository or database.
class OrderService {
  final OrderRepository _repository;

  const OrderService({
    this._repository = const OrderRepository(),
  });

  /// Fetches all orders for a customer.
  Future<List<OrderModel>> getCustomerOrders(
    String customerId,
  ) async {
    if (customerId.trim().isEmpty) {
      return const [];
    }

    final orders = await _repository.getCustomerOrders(
      customerId.trim(),
    );

    return List<OrderModel>.unmodifiable(orders);
  }

  /// Fetches a single order by ID.
  Future<OrderModel?> getOrderById(
    String orderId,
  ) async {
    if (orderId.trim().isEmpty) {
      return null;
    }

    return _repository.getOrderById(
      orderId.trim(),
    );
  }

  /// Returns only active orders.
  Future<List<OrderModel>> getActiveOrders(
    String customerId,
  ) async {
    final orders = await getCustomerOrders(customerId);

    return orders
        .where((order) => order.isActive)
        .toList(growable: false);
  }

  /// Returns completed orders.
  Future<List<OrderModel>> getCompletedOrders(
    String customerId,
  ) async {
    final orders = await getCustomerOrders(customerId);

    return orders
        .where((order) => order.status.isCompleted)
        .toList(growable: false);
  }

  /// Returns cancelled or failed orders.
  Future<List<OrderModel>> getCancelledOrders(
    String customerId,
  ) async {
    final orders = await getCustomerOrders(customerId);

    return orders
        .where((order) => order.status.isCancelled)
        .toList(growable: false);
  }

  /// Returns orders filtered by a specific status.
  Future<List<OrderModel>> getOrdersByStatus(
    String customerId,
    OrderStatus status,
  ) async {
    final orders = await getCustomerOrders(customerId);

    return orders
        .where((order) => order.status == status)
        .toList(growable: false);
  }

  /// Checks whether an order exists.
  Future<bool> orderExists(
    String orderId,
  ) async {
    final order = await getOrderById(orderId);
    return order != null;
  }
}