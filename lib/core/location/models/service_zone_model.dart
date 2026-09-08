import 'package:flutter/foundation.dart';

/// Represents a custom service zone.
///
/// A service zone can be assigned to a franchise partner,
/// channel partner, or directly controlled by the platform.
///
/// The zone can be defined using:
/// - State
/// - District
/// - City
/// - Area
/// - PIN code
/// - GPS center coordinates
/// - Radius
///
/// Later this model can be extended to support polygon/geofence
/// boundaries through Google Maps and Supabase/PostGIS.
@immutable
class ServiceZoneModel {
  final String id;
  final String name;

  /// Location hierarchy.
  final String? state;
  final String? district;
  final String? city;
  final String? area;
  final List<String> pinCodes;

  /// GPS-based service area.
  final double? centerLatitude;
  final double? centerLongitude;
  final double? radiusKm;

  /// Partner ownership / assignment.
  final String? franchiseId;
  final String? channelPartnerId;

  /// Services available inside this zone.
  final List<String> serviceCategoryIds;

  /// Zone status.
  final bool isActive;

  /// Whether this zone is currently accepting new customers/orders.
  final bool acceptingOrders;

  const ServiceZoneModel({
    required this.id,
    required this.name,
    this.state,
    this.district,
    this.city,
    this.area,
    this.pinCodes = const [],
    this.centerLatitude,
    this.centerLongitude,
    this.radiusKm,
    this.franchiseId,
    this.channelPartnerId,
    this.serviceCategoryIds = const [],
    this.isActive = true,
    this.acceptingOrders = true,
  });

  /// Returns true when GPS center and radius are configured.
  bool get hasGeoRadius {
    return centerLatitude != null &&
        centerLongitude != null &&
        radiusKm != null &&
        radiusKm! > 0;
  }

  /// Returns true when this zone is assigned to a franchise.
  bool get isFranchiseManaged {
    return franchiseId != null &&
        franchiseId!.trim().isNotEmpty;
  }

  /// Returns true when this zone is assigned to a channel partner.
  bool get isChannelPartnerManaged {
    return channelPartnerId != null &&
        channelPartnerId!.trim().isNotEmpty;
  }

  /// Returns true when the zone is operational.
  bool get isOperational {
    return isActive && acceptingOrders;
  }

  /// Returns a readable hierarchy string.
  String get locationPath {
    final parts = <String>[
      if (area != null && area!.trim().isNotEmpty) area!.trim(),
      if (city != null && city!.trim().isNotEmpty) city!.trim(),
      if (district != null && district!.trim().isNotEmpty)
        district!.trim(),
      if (state != null && state!.trim().isNotEmpty) state!.trim(),
    ];

    if (parts.isNotEmpty) {
      return parts.join(', ');
    }

    return name;
  }

  /// Checks whether a PIN code belongs to this zone.
  bool containsPinCode(String pinCode) {
    final normalizedPinCode = pinCode.trim();

    if (normalizedPinCode.isEmpty) {
      return false;
    }

    return pinCodes.any(
      (code) => code.trim() == normalizedPinCode,
    );
  }

  /// Checks whether a service category is enabled in this zone.
  bool hasService(String serviceCategoryId) {
    final normalizedId = serviceCategoryId.trim();

    if (normalizedId.isEmpty) {
      return false;
    }

    return serviceCategoryIds.contains(normalizedId);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'state': state,
      'district': district,
      'city': city,
      'area': area,
      'pin_codes': pinCodes,
      'center_latitude': centerLatitude,
      'center_longitude': centerLongitude,
      'radius_km': radiusKm,
      'franchise_id': franchiseId,
      'channel_partner_id': channelPartnerId,
      'service_category_ids': serviceCategoryIds,
      'is_active': isActive,
      'accepting_orders': acceptingOrders,
    };
  }

  factory ServiceZoneModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return ServiceZoneModel(
      id: map['id']?.toString() ?? '',
      name: map['name']?.toString() ?? '',
      state: _toNullableString(map['state']),
      district: _toNullableString(map['district']),
      city: _toNullableString(map['city']),
      area: _toNullableString(map['area']),
      pinCodes: _toStringList(map['pin_codes']),
      centerLatitude:
          _toNullableDouble(map['center_latitude']),
      centerLongitude:
          _toNullableDouble(map['center_longitude']),
      radiusKm: _toNullableDouble(map['radius_km']),
      franchiseId:
          _toNullableString(map['franchise_id']),
      channelPartnerId:
          _toNullableString(map['channel_partner_id']),
      serviceCategoryIds:
          _toStringList(map['service_category_ids']),
      isActive: _toBool(
        map['is_active'],
        defaultValue: true,
      ),
      acceptingOrders: _toBool(
        map['accepting_orders'],
        defaultValue: true,
      ),
    );
  }

  ServiceZoneModel copyWith({
    String? id,
    String? name,
    String? state,
    String? district,
    String? city,
    String? area,
    List<String>? pinCodes,
    double? centerLatitude,
    double? centerLongitude,
    double? radiusKm,
    String? franchiseId,
    String? channelPartnerId,
    List<String>? serviceCategoryIds,
    bool? isActive,
    bool? acceptingOrders,
  }) {
    return ServiceZoneModel(
      id: id ?? this.id,
      name: name ?? this.name,
      state: state ?? this.state,
      district: district ?? this.district,
      city: city ?? this.city,
      area: area ?? this.area,
      pinCodes: pinCodes ?? this.pinCodes,
      centerLatitude:
          centerLatitude ?? this.centerLatitude,
      centerLongitude:
          centerLongitude ?? this.centerLongitude,
      radiusKm: radiusKm ?? this.radiusKm,
      franchiseId:
          franchiseId ?? this.franchiseId,
      channelPartnerId:
          channelPartnerId ?? this.channelPartnerId,
      serviceCategoryIds:
          serviceCategoryIds ?? this.serviceCategoryIds,
      isActive: isActive ?? this.isActive,
      acceptingOrders:
          acceptingOrders ?? this.acceptingOrders,
    );
  }

  static List<String> _toStringList(dynamic value) {
    if (value is! List) {
      return const [];
    }

    return value
        .map((item) => item.toString().trim())
        .where((item) => item.isNotEmpty)
        .toList(growable: false);
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

  static double? _toNullableDouble(dynamic value) {
    if (value == null) {
      return null;
    }

    if (value is num) {
      return value.toDouble();
    }

    return double.tryParse(value.toString());
  }

  static bool _toBool(
    dynamic value, {
    required bool defaultValue,
  }) {
    if (value == null) {
      return defaultValue;
    }

    if (value is bool) {
      return value;
    }

    if (value is num) {
      return value != 0;
    }

    final text = value.toString().trim().toLowerCase();

    if (text == 'true' || text == '1') {
      return true;
    }

    if (text == 'false' || text == '0') {
      return false;
    }

    return defaultValue;
  }
}