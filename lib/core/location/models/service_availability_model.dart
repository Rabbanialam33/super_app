import 'package:flutter/foundation.dart';

enum ServiceAvailabilityStatus {
  available,
  unavailable,
  comingSoon,
  temporarilyUnavailable,
}

@immutable
class ServiceAvailabilityModel {
  final String serviceCategoryId;
  final String serviceName;

  final String zoneId;
  final String? partnerId;
  final String? franchiseId;
  final String? channelPartnerId;

  final ServiceAvailabilityStatus status;

  final bool isActive;
  final bool acceptingOrders;

  final String? unavailableMessage;
  final DateTime? updatedAt;

  const ServiceAvailabilityModel({
    required this.serviceCategoryId,
    required this.serviceName,
    required this.zoneId,
    required this.status,
    this.partnerId,
    this.franchiseId,
    this.channelPartnerId,
    this.isActive = true,
    this.acceptingOrders = true,
    this.unavailableMessage,
    this.updatedAt,
  });

  bool get isAvailable {
    return isActive &&
        acceptingOrders &&
        status == ServiceAvailabilityStatus.available;
  }

  bool get isUnavailable {
    return status ==
            ServiceAvailabilityStatus.unavailable ||
        status ==
            ServiceAvailabilityStatus.temporarilyUnavailable;
  }

  bool get isComingSoon {
    return status == ServiceAvailabilityStatus.comingSoon;
  }

  bool get isPartnerManaged {
    return franchiseId != null ||
        channelPartnerId != null;
  }

  String get statusLabel {
    switch (status) {
      case ServiceAvailabilityStatus.available:
        return 'Available';

      case ServiceAvailabilityStatus.unavailable:
        return 'Unavailable';

      case ServiceAvailabilityStatus.comingSoon:
        return 'Coming Soon';

      case ServiceAvailabilityStatus.temporarilyUnavailable:
        return 'Temporarily Unavailable';
    }
  }

  String get displayMessage {
    if (isAvailable) {
      return '$serviceName is available in your area';
    }

    if (unavailableMessage != null &&
        unavailableMessage!.trim().isNotEmpty) {
      return unavailableMessage!.trim();
    }

    switch (status) {
      case ServiceAvailabilityStatus.available:
        return '$serviceName is available in your area';

      case ServiceAvailabilityStatus.unavailable:
        return '$serviceName is not available in your area yet';

      case ServiceAvailabilityStatus.comingSoon:
        return '$serviceName is coming soon to your area';

      case ServiceAvailabilityStatus.temporarilyUnavailable:
        return '$serviceName is temporarily unavailable';
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'service_category_id': serviceCategoryId,
      'service_name': serviceName,
      'zone_id': zoneId,
      'partner_id': partnerId,
      'franchise_id': franchiseId,
      'channel_partner_id': channelPartnerId,
      'status': status.name,
      'is_active': isActive,
      'accepting_orders': acceptingOrders,
      'unavailable_message': unavailableMessage,
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  factory ServiceAvailabilityModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return ServiceAvailabilityModel(
      serviceCategoryId:
          map['service_category_id']?.toString() ?? '',
      serviceName:
          map['service_name']?.toString() ?? '',
      zoneId: map['zone_id']?.toString() ?? '',
      partnerId: _toNullableString(
        map['partner_id'],
      ),
      franchiseId: _toNullableString(
        map['franchise_id'],
      ),
      channelPartnerId: _toNullableString(
        map['channel_partner_id'],
      ),
      status: _parseStatus(
        map['status'],
      ),
      isActive: _toBool(
        map['is_active'],
      ),
      acceptingOrders: _toBool(
        map['accepting_orders'],
      ),
      unavailableMessage: _toNullableString(
        map['unavailable_message'],
      ),
      updatedAt: _toDateTime(
        map['updated_at'],
      ),
    );
  }

  ServiceAvailabilityModel copyWith({
    String? serviceCategoryId,
    String? serviceName,
    String? zoneId,
    String? partnerId,
    String? franchiseId,
    String? channelPartnerId,
    ServiceAvailabilityStatus? status,
    bool? isActive,
    bool? acceptingOrders,
    String? unavailableMessage,
    DateTime? updatedAt,
  }) {
    return ServiceAvailabilityModel(
      serviceCategoryId:
          serviceCategoryId ?? this.serviceCategoryId,
      serviceName: serviceName ?? this.serviceName,
      zoneId: zoneId ?? this.zoneId,
      partnerId: partnerId ?? this.partnerId,
      franchiseId: franchiseId ?? this.franchiseId,
      channelPartnerId:
          channelPartnerId ?? this.channelPartnerId,
      status: status ?? this.status,
      isActive: isActive ?? this.isActive,
      acceptingOrders:
          acceptingOrders ?? this.acceptingOrders,
      unavailableMessage:
          unavailableMessage ?? this.unavailableMessage,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  static ServiceAvailabilityStatus _parseStatus(
    dynamic value,
  ) {
    final statusName = value?.toString();

    return ServiceAvailabilityStatus.values.firstWhere(
      (item) => item.name == statusName,
      orElse: () =>
          ServiceAvailabilityStatus.unavailable,
    );
  }

  static String? _toNullableString(dynamic value) {
    if (value == null) {
      return null;
    }

    final text = value.toString().trim();

    return text.isEmpty ? null : text;
  }

  static DateTime? _toDateTime(dynamic value) {
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

  static bool _toBool(dynamic value) {
    if (value is bool) {
      return value;
    }

    if (value is String) {
      return value.toLowerCase() == 'true';
    }

    if (value is num) {
      return value != 0;
    }

    return true;
  }
}