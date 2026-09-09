import 'package:flutter_test/flutter_test.dart';
import 'package:super_app/core/location/models/location_model.dart';
import 'package:super_app/core/location/services/customer_location_selection_service.dart';

void main() {
  const service = CustomerLocationSelectionService();

  LocationModel createDhupguriLocation({
    String pinCode = '735210',
    String state = 'West Bengal',
    String district = 'Jalpaiguri',
    String city = 'Dhupguri',
  }) {
    return LocationModel(
      id: 'LOC-001',
      name: 'Dhupguri',
      address: 'Dhupguri, Jalpaiguri',
      state: state,
      district: district,
      city: city,
      area: 'Dhupguri Town',
      pinCode: pinCode,
      latitude: 26.5892,
      longitude: 89.0076,
      countryCode: 'IN',
      isActive: true,
    );
  }

  group('CustomerLocationSelectionService', () {
    test('finds matching zone for Dhupguri location', () async {
      final location = createDhupguriLocation();

      final zone = await service.findMatchingZone(location);

      expect(zone, isNotNull);
      expect(zone!.id, 'ZONE-DHUPGURI-001');
    });

    test('returns null for unknown PIN code', () async {
      final location = createDhupguriLocation(
        pinCode: '700001',
      );

      final zone = await service.findMatchingZone(location);

      expect(zone, isNull);
    });

    test('returns available services for valid location', () async {
      final location = createDhupguriLocation();

      final services =
          await service.getAvailableServicesForLocation(location);

      expect(services.length, 5);

      final serviceIds =
          services.map((item) => item.serviceCategoryId).toList();

      expect(serviceIds, contains('food'));
      expect(serviceIds, contains('ride'));
      expect(serviceIds, contains('delivery'));
      expect(serviceIds, contains('manpower'));
      expect(serviceIds, contains('services'));
      expect(serviceIds, isNot(contains('shopping')));
    });

    test('food service is available for valid location', () async {
      final location = createDhupguriLocation();

      final result = await service.isServiceAvailableForLocation(
        location: location,
        serviceCategoryId: 'food',
      );

      expect(result, isTrue);
    });

    test('shopping service is not available when coming soon', () async {
      final location = createDhupguriLocation();

      final result = await service.isServiceAvailableForLocation(
        location: location,
        serviceCategoryId: 'shopping',
      );

      expect(result, isFalse);
    });

    test('confirms valid location successfully', () async {
      final location = createDhupguriLocation();

      final selection =
          await service.confirmLocation(location);

      expect(selection.isConfirmed, isTrue);
      expect(selection.hasLocation, isTrue);
      expect(selection.hasZone, isTrue);
      expect(selection.selectedZoneId, 'ZONE-DHUPGURI-001');
      expect(selection.errorMessage, isNull);
    });

    test('does not confirm unavailable location', () async {
      final location = createDhupguriLocation(
        pinCode: '700001',
      );

      final selection =
          await service.confirmLocation(location);

      expect(selection.isConfirmed, isFalse);
      expect(selection.hasLocation, isTrue);
      expect(selection.hasZone, isFalse);
      expect(selection.errorMessage,
          'Service is not available in your area yet');
    });

    test('returns correct available service IDs', () async {
      final location = createDhupguriLocation();

      final serviceIds =
          await service.getAvailableServiceIdsForLocation(location);

      expect(serviceIds.length, 5);
      expect(serviceIds, contains('food'));
      expect(serviceIds, contains('ride'));
      expect(serviceIds, contains('delivery'));
      expect(serviceIds, contains('manpower'));
      expect(serviceIds, contains('services'));
      expect(serviceIds, isNot(contains('shopping')));
    });

    test('returns correct location status message', () async {
      final location = createDhupguriLocation();

      final message =
          await service.getLocationStatusMessage(location);

      expect(
        message,
        'Location available in Dhupguri Zone 001',
      );
    });

    test('returns unavailable message for unknown location',
        () async {
      final location = createDhupguriLocation(
        pinCode: '700001',
      );

      final message =
          await service.getLocationStatusMessage(location);

      expect(
        message,
        'Service is not available in your area yet',
      );
    });

    test('detects that at least one service is available',
        () async {
      final location = createDhupguriLocation();

      final result =
          await service.hasAvailableService(location);

      expect(result, isTrue);
    });

    test('returns false when no zone is available', () async {
      final location = createDhupguriLocation(
        pinCode: '700001',
      );

      final result =
          await service.hasAvailableService(location);

      expect(result, isFalse);
    });

    test('returns all availability records for valid location',
        () async {
      final location = createDhupguriLocation();

      final availability =
          await service.getServiceAvailabilityForLocation(location);

      expect(availability.length, 6);
    });

    test('creates unconfirmed selection for valid location',
        () async {
      final location = createDhupguriLocation();

      final selection =
          await service.createSelectionForLocation(location);

      expect(selection.hasLocation, isTrue);
      expect(selection.hasZone, isTrue);
      expect(selection.isConfirmed, isFalse);
      expect(selection.selectedZoneId, 'ZONE-DHUPGURI-001');
      expect(selection.errorMessage, isNull);
    });
  });
}