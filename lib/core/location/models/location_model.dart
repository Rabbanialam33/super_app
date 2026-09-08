import 'package:flutter/foundation.dart';

/// Represents a customer's, partner's, vendor's or service area's location.
///
/// This model is designed to support:
/// - GPS coordinates
/// - State / District / City / Area
/// - PIN code
/// - Custom service zones
/// - Future Google Maps integration
@immutable
class LocationModel {
  final String id;
  final String? name;
  final String? address;
  final String? state;
  final String? district;
  final String? city;
  final String? area;
  final String? pinCode;
  final double? latitude;
  final double? longitude;
  final String? countryCode;
  final bool isActive;

  const LocationModel({
    required this.id,
    this.name,
    this.address,
    this.state,
    this.district,
    this.city,
    this.area,
    this.pinCode,
    this.latitude,
    this.longitude,
    this.countryCode,
    this.isActive = true,
  });

  /// Returns true when valid GPS coordinates are available.
  bool get hasCoordinates {
    return latitude != null && longitude != null;
  }

  /// Returns a readable location name.
  String get displayName {
    if (name != null && name!.trim().isNotEmpty) {
      return name!.trim();
    }

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

    return 'Unknown Location';
  }

  /// Returns the complete readable address.
  String get fullAddress {
    final parts = <String>[
      if (address != null && address!.trim().isNotEmpty)
        address!.trim(),
      if (area != null && area!.trim().isNotEmpty) area!.trim(),
      if (city != null && city!.trim().isNotEmpty) city!.trim(),
      if (district != null && district!.trim().isNotEmpty)
        district!.trim(),
      if (state != null && state!.trim().isNotEmpty) state!.trim(),
      if (pinCode != null && pinCode!.trim().isNotEmpty)
        pinCode!.trim(),
    ];

    if (parts.isNotEmpty) {
      return parts.join(', ');
    }

    return 'Location not available';
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'state': state,
      'district': district,
      'city': city,
      'area': area,
      'pin_code': pinCode,
      'latitude': latitude,
      'longitude': longitude,
      'country_code': countryCode,
      'is_active': isActive,
    };
  }

  factory LocationModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return LocationModel(
      id: map['id']?.toString() ?? '',
      name: _toNullableString(map['name']),
      address: _toNullableString(map['address']),
      state: _toNullableString(map['state']),
      district: _toNullableString(map['district']),
      city: _toNullableString(map['city']),
      area: _toNullableString(map['area']),
      pinCode: _toNullableString(map['pin_code']),
      latitude: _toNullableDouble(map['latitude']),
      longitude: _toNullableDouble(map['longitude']),
      countryCode: _toNullableString(
        map['country_code'],
      ),
      isActive: _toBool(map['is_active']),
    );
  }

  LocationModel copyWith({
    String? id,
    String? name,
    String? address,
    String? state,
    String? district,
    String? city,
    String? area,
    String? pinCode,
    double? latitude,
    double? longitude,
    String? countryCode,
    bool? isActive,
  }) {
    return LocationModel(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      state: state ?? this.state,
      district: district ?? this.district,
      city: city ?? this.city,
      area: area ?? this.area,
      pinCode: pinCode ?? this.pinCode,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      countryCode: countryCode ?? this.countryCode,
      isActive: isActive ?? this.isActive,
    );
  }

  static String? _toNullableString(
    dynamic value,
  ) {
    if (value == null) {
      return null;
    }

    final text = value.toString().trim();

    if (text.isEmpty) {
      return null;
    }

    return text;
  }

  static double? _toNullableDouble(
    dynamic value,
  ) {
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

  static bool _toBool(
    dynamic value,
  ) {
    if (value is bool) {
      return value;
    }

    if (value is num) {
      return value != 0;
    }

    return value?.toString().toLowerCase() == 'true';
  }
}