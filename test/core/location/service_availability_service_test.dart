import 'package:flutter_test/flutter_test.dart';

import 'package:super_app/core/location/models/service_availability_model.dart';
import 'package:super_app/core/location/services/service_availability_service.dart';

void main() {
  const service = ServiceAvailabilityService();

  group('Service Availability Service', () {
    test('Food is available in Dhupguri Zone 001', () async {
      final result = await service.isServiceAvailable(
        zoneId: 'ZONE-DHUPGURI-001',
        serviceCategoryId: 'food',
      );

      expect(result, isTrue);
    });

    test('Ride is available in Dhupguri Zone 001', () async {
      final result = await service.isServiceAvailable(
        zoneId: 'ZONE-DHUPGURI-001',
        serviceCategoryId: 'ride',
      );

      expect(result, isTrue);
    });

    test('Shopping is coming soon in Dhupguri Zone 001', () async {
      final result = await service.getServiceAvailability(
        zoneId: 'ZONE-DHUPGURI-001',
        serviceCategoryId: 'shopping',
      );

      expect(
        result?.status,
        ServiceAvailabilityStatus.comingSoon,
      );

      expect(result?.isAvailable, isFalse);
      expect(result?.isComingSoon, isTrue);
    });

    test('Manpower is unavailable in Dhupguri Zone 003', () async {
      final result = await service.isServiceAvailable(
        zoneId: 'ZONE-DHUPGURI-003',
        serviceCategoryId: 'manpower',
      );

      expect(result, isFalse);
    });

    test('Manpower returns unavailable message', () async {
      final message = await service.getServiceMessage(
        zoneId: 'ZONE-DHUPGURI-003',
        serviceCategoryId: 'manpower',
        serviceName: 'Manpower',
      );

      expect(
        message,
        'Manpower service is not available in this area yet',
      );
    });

    test('Shopping is temporarily unavailable in Zone 003', () async {
      final result = await service.getServiceAvailability(
        zoneId: 'ZONE-DHUPGURI-003',
        serviceCategoryId: 'shopping',
      );

      expect(
        result?.status,
        ServiceAvailabilityStatus.temporarilyUnavailable,
      );

      expect(result?.isAvailable, isFalse);
      expect(result?.isUnavailable, isTrue);
    });

    test('Unknown service returns unavailable', () async {
      final result = await service.isServiceAvailable(
        zoneId: 'ZONE-DHUPGURI-001',
        serviceCategoryId: 'unknown-service',
      );

      expect(result, isFalse);
    });

    test('Unknown zone returns no available services', () async {
      final result = await service.getAvailableServices(
        'ZONE-UNKNOWN-999',
      );

      expect(result, isEmpty);
    });

    test('Zone 001 returns five available services', () async {
      final result = await service.getAvailableServices(
        'ZONE-DHUPGURI-001',
      );

      expect(result.length, 5);

      expect(
        result.map((item) => item.serviceCategoryId),
        containsAll([
          'food',
          'ride',
          'delivery',
          'manpower',
          'services',
        ]),
      );
    });

    test('Zone 001 available service IDs are correct', () async {
      final result = await service.getAvailableServiceIds(
        'ZONE-DHUPGURI-001',
      );

      expect(result.length, 5);

      expect(
        result,
        containsAll([
          'food',
          'ride',
          'delivery',
          'manpower',
          'services',
        ]),
      );

      expect(result, isNot(contains('shopping')));
    });

    test('Zone 003 has available services', () async {
      final result = await service.hasAnyAvailableService(
        'ZONE-DHUPGURI-003',
      );

      expect(result, isTrue);
    });

    test('Available service has correct display message', () async {
      final result = await service.getServiceMessage(
        zoneId: 'ZONE-DHUPGURI-001',
        serviceCategoryId: 'food',
        serviceName: 'Food',
      );

      expect(
        result,
        'Food is available in your area',
      );
    });

    test('Unknown zone returns a proper unavailable message', () async {
      final result = await service.getServiceMessage(
        zoneId: 'ZONE-UNKNOWN-999',
        serviceCategoryId: 'food',
        serviceName: 'Food',
      );

      expect(
        result,
        'Food is not available in your area yet',
      );
    });
  });
}