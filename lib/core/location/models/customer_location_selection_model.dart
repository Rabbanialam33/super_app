import 'package:flutter/foundation.dart';

import 'package:super_app/core/location/models/location_model.dart';

@immutable
class CustomerLocationSelectionModel {
  final LocationModel? selectedLocation;

  final String? selectedZoneId;

  final bool isDetectingLocation;
  final bool isLoading;
  final bool isConfirmed;

  final String? errorMessage;

  const CustomerLocationSelectionModel({
    this.selectedLocation,
    this.selectedZoneId,
    this.isDetectingLocation = false,
    this.isLoading = false,
    this.isConfirmed = false,
    this.errorMessage,
  });

  bool get hasLocation => selectedLocation != null;

  bool get hasZone => selectedZoneId != null &&
      selectedZoneId!.trim().isNotEmpty;

  bool get isReady => hasLocation && hasZone && isConfirmed;

  String get displayLocation {
    final location = selectedLocation;

    if (location == null) {
      return 'Select your location';
    }

    if (location.displayName.trim().isNotEmpty) {
      return location.displayName;
    }

    return location.fullAddress;
  }

  String get displayAddress {
    final location = selectedLocation;

    if (location == null) {
      return '';
    }

    return location.fullAddress;
  }

  String get statusMessage {
    if (isDetectingLocation) {
      return 'Detecting your location...';
    }

    if (isLoading) {
      return 'Checking service availability...';
    }

    if (errorMessage != null &&
        errorMessage!.trim().isNotEmpty) {
      return errorMessage!;
    }

    if (!hasLocation) {
      return 'Select your location to see available services';
    }

    if (!hasZone) {
      return 'Service zone could not be identified';
    }

    if (!isConfirmed) {
      return 'Confirm your location to continue';
    }

    return 'Location confirmed';
  }

  CustomerLocationSelectionModel copyWith({
    LocationModel? selectedLocation,
    String? selectedZoneId,
    bool? isDetectingLocation,
    bool? isLoading,
    bool? isConfirmed,
    String? errorMessage,
    bool clearLocation = false,
    bool clearZone = false,
    bool clearError = false,
  }) {
    return CustomerLocationSelectionModel(
      selectedLocation: clearLocation
          ? null
          : selectedLocation ?? this.selectedLocation,
      selectedZoneId: clearZone
          ? null
          : selectedZoneId ?? this.selectedZoneId,
      isDetectingLocation:
          isDetectingLocation ?? this.isDetectingLocation,
      isLoading: isLoading ?? this.isLoading,
      isConfirmed: isConfirmed ?? this.isConfirmed,
      errorMessage:
          clearError ? null : errorMessage ?? this.errorMessage,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'selectedLocation': selectedLocation?.toMap(),
      'selectedZoneId': selectedZoneId,
      'isDetectingLocation': isDetectingLocation,
      'isLoading': isLoading,
      'isConfirmed': isConfirmed,
      'errorMessage': errorMessage,
    };
  }

  factory CustomerLocationSelectionModel.fromMap(
    Map<String, dynamic> map,
  ) {
    final locationMap = map['selectedLocation'];

    return CustomerLocationSelectionModel(
      selectedLocation: locationMap is Map
          ? LocationModel.fromMap(
              Map<String, dynamic>.from(locationMap),
            )
          : null,
      selectedZoneId: _toNullableString(
        map['selectedZoneId'],
      ),
      isDetectingLocation:
          _toBool(map['isDetectingLocation']),
      isLoading: _toBool(map['isLoading']),
      isConfirmed: _toBool(map['isConfirmed']),
      errorMessage: _toNullableString(
        map['errorMessage'],
      ),
    );
  }

  static String? _toNullableString(dynamic value) {
    if (value == null) {
      return null;
    }

    final result = value.toString().trim();

    return result.isEmpty ? null : result;
  }

  static bool _toBool(dynamic value) {
    if (value is bool) {
      return value;
    }

    if (value is num) {
      return value != 0;
    }

    if (value is String) {
      return value.toLowerCase() == 'true';
    }

    return false;
  }
}