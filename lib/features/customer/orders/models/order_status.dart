enum OrderStatus {
  pending,
  confirmed,
  preparing,
  ready,
  assigned,
  onTheWay,
  delivered,
  completed,
  cancelled,
  failed,
}

extension OrderStatusExtension on OrderStatus {
  String get label {
    switch (this) {
      case OrderStatus.pending:
        return 'Pending';

      case OrderStatus.confirmed:
        return 'Confirmed';

      case OrderStatus.preparing:
        return 'Preparing';

      case OrderStatus.ready:
        return 'Ready';

      case OrderStatus.assigned:
        return 'Partner Assigned';

      case OrderStatus.onTheWay:
        return 'On the Way';

      case OrderStatus.delivered:
        return 'Delivered';

      case OrderStatus.completed:
        return 'Completed';

      case OrderStatus.cancelled:
        return 'Cancelled';

      case OrderStatus.failed:
        return 'Failed';
    }
  }

  String get description {
    switch (this) {
      case OrderStatus.pending:
        return 'Your order is waiting for confirmation';

      case OrderStatus.confirmed:
        return 'Your order has been confirmed';

      case OrderStatus.preparing:
        return 'Your order is being prepared';

      case OrderStatus.ready:
        return 'Your order is ready';

      case OrderStatus.assigned:
        return 'A delivery partner has been assigned';

      case OrderStatus.onTheWay:
        return 'Your order is on the way';

      case OrderStatus.delivered:
        return 'Your order has been delivered';

      case OrderStatus.completed:
        return 'Your order has been completed';

      case OrderStatus.cancelled:
        return 'Your order has been cancelled';

      case OrderStatus.failed:
        return 'There was a problem with your order';
    }
  }

  bool get isCompleted {
    return this == OrderStatus.delivered ||
        this == OrderStatus.completed;
  }

  bool get isCancelled {
    return this == OrderStatus.cancelled ||
        this == OrderStatus.failed;
  }
}