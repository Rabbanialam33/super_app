import 'package:flutter_test/flutter_test.dart';

import 'package:super_app/core/location/models/customer_location_selection_model.dart';
import 'package:super_app/core/location/models/location_model.dart';

void main() {
  final location = LocationModel(
    id: 'LOC-001',
    name: 'Dhupguri',
    address: 'Dhupguri, Jalpaiguri, West Bengal',
    state: 'West Bengal',
    district: 'Jalpaiguri',
    city: 'Dhupguri',
    area: 'Dhupguri Town',
    pinCode: '735210',
    latitude: 26.5892,
    longitude: 89.0076,
  );

  group('Customer Location Selection Model', () {
    test('Default state has no selected location', () {
      const model = CustomerLocationSelectionModel();

      expect(model.hasLocation, isFalse);
      expect(model.hasZone, isFalse);
      expect(model.isReady, isFalse);
      expect(model.isConfirmed, isFalse);
      expect(model.displayLocation, 'Select your location');
    });

    test('Selected location is detected correctly', () {
      final model = CustomerLocationSelectionModel(
        selectedLocation: location,
      );

      expect(model.hasLocation, isTrue);
      expect(model.displayLocation, 'Dhupguri');
      expect(model.displayAddress, location.fullAddress);
    });

    test('Zone is detected correctly', () {
      final model = CustomerLocationSelectionModel(
        selectedLocation: location,
        selectedZoneId: 'ZONE-DHUPGURI-001',
      );

      expect(model.hasLocation, isTrue);
      expect(model.hasZone, isTrue);
      expect(model.isConfirmed, isFalse);
      expect(model.isReady, isFalse);
    });

    test('Location is ready after confirmation', () {
      final model = CustomerLocationSelectionModel(
        selectedLocation: location,
        selectedZoneId: 'ZONE-DHUPGURI-001',
        isConfirmed: true,
      );

      expect(model.hasLocation, isTrue);
      expect(model.hasZone, isTrue);
      expect(model.isConfirmed, isTrue);
      expect(model.isReady, isTrue);
    });

    test('Detecting location status message is correct', () {
      const model = CustomerLocationSelectionModel(
        isDetectingLocation: true,
      );

      expect(
        model.statusMessage,
        'Detecting your location...',
      );
    });

    test('Loading status message is correct', () {
      const model = CustomerLocationSelectionModel(
        isLoading: true,
      );

      expect(
        model.statusMessage,
        'Checking service availability...',
      );
    });

    test('Error message is returned correctly', () {
      const model = CustomerLocationSelectionModel(
        errorMessage: 'Location permission denied',
      );

      expect(
        model.statusMessage,
        'Location permission denied',
      );
    });

    test('Unconfirmed location message is correct', () {
      final model = CustomerLocationSelectionModel(
        selectedLocation: location,
        selectedZoneId: 'ZONE-DHUPGURI-001',
      );

      expect(
        model.statusMessage,
        'Confirm your location to continue',
      );
    });

    test('Confirmed location message is correct', () {
      final model = CustomerLocationSelectionModel(
        selectedLocation: location,
        selectedZoneId: 'ZONE-DHUPGURI-001',
        isConfirmed: true,
      );

      expect(
        model.statusMessage,
        'Location confirmed',
      );
    });

    test('copyWith updates confirmation state', () {
      final model = CustomerLocationSelectionModel(
        selectedLocation: location,
        selectedZoneId: 'ZONE-DHUPGURI-001',
      );

      final updated = model.copyWith(
        isConfirmed: true,
      );

      expect(updated.selectedLocation?.id, 'LOC-001');
      expect(
        updated.selectedZoneId,
        'ZONE-DHUPGURI-001',
      );
      expect(updated.isConfirmed, isTrue);
      expect(updated.isReady, isTrue);
    });

    test('copyWith can clear location', () {
      final model = CustomerLocationSelectionModel(
        selectedLocation: location,
        selectedZoneId: 'ZONE-DHUPGURI-001',
        isConfirmed: true,
      );

      final updated = model.copyWith(
        clearLocation: true,
      );

      expect(updated.hasLocation, isFalse);
      expect(updated.hasZone, isTrue);
      expect(updated.isReady, isFalse);
    });

    test('copyWith can clear zone', () {
      final model = CustomerLocationSelectionModel(
        selectedLocation: location,
        selectedZoneId: 'ZONE-DHUPGURI-001',
        isConfirmed: true,
      );

      final updated = model.copyWith(
        clearZone: true,
      );

      expect(updated.hasLocation, isTrue);
      expect(updated.hasZone, isFalse);
      expect(updated.isReady, isFalse);
    });

    test('copyWith can clear error', () {
      const model = CustomerLocationSelectionModel(
        errorMessage: 'Location error',
      );

      final updated = model.copyWith(
        clearError: true,
      );

      expect(updated.errorMessage, isNull);
      expect(
        updated.statusMessage,
        'Select your location to see available services',
      );
    });

    test('Map conversion preserves selection data', () {
      final model = CustomerLocationSelectionModel(
        selectedLocation: location,
        selectedZoneId: 'ZONE-DHUPGURI-001',
        isConfirmed: true,
      );

      final restored =
          CustomerLocationSelectionModel.fromMap(
        model.toMap(),
      );

      expect(
        restored.selectedLocation?.id,
        'LOC-001',
      );
      expect(
        restored.selectedLocation?.name,
        'Dhupguri',
      );
      expect(
        restored.selectedZoneId,
        'ZONE-DHUPGURI-001',
      );
      expect(
        restored.isConfirmed,
        isTrue,
      );
      expect(
        restored.isReady,
        isTrue,
      );
    });
  });
}