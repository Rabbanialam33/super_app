import 'package:super_app/core/location/models/service_availability_model.dart';

class ServiceAvailabilityRepository {
  const ServiceAvailabilityRepository();

  Future<List<ServiceAvailabilityModel>>
      getAvailabilityByZone(
    String zoneId,
  ) async {
    final normalizedZoneId = zoneId.trim();

    if (normalizedZoneId.isEmpty) {
      return [];
    }

    return _demoAvailability
        .where(
          (item) => item.zoneId == normalizedZoneId,
        )
        .toList();
  }

  Future<ServiceAvailabilityModel?>
      getServiceAvailability({
    required String zoneId,
    required String serviceCategoryId,
  }) async {
    final normalizedZoneId = zoneId.trim();
    final normalizedServiceId =
        serviceCategoryId.trim();

    if (normalizedZoneId.isEmpty ||
        normalizedServiceId.isEmpty) {
      return null;
    }

    for (final item in _demoAvailability) {
      if (item.zoneId == normalizedZoneId &&
          item.serviceCategoryId ==
              normalizedServiceId) {
        return item;
      }
    }

    return null;
  }

  Future<List<ServiceAvailabilityModel>>
      getAvailableServices(
    String zoneId,
  ) async {
    final availability =
        await getAvailabilityByZone(zoneId);

    return availability
        .where((item) => item.isAvailable)
        .toList();
  }

  Future<List<ServiceAvailabilityModel>>
      getUnavailableServices(
    String zoneId,
  ) async {
    final availability =
        await getAvailabilityByZone(zoneId);

    return availability
        .where((item) => item.isUnavailable)
        .toList();
  }

  Future<bool> isServiceAvailable({
    required String zoneId,
    required String serviceCategoryId,
  }) async {
    final availability =
        await getServiceAvailability(
      zoneId: zoneId,
      serviceCategoryId: serviceCategoryId,
    );

    return availability?.isAvailable ?? false;
  }

  Future<List<String>> getAvailableServiceIds(
    String zoneId,
  ) async {
    final services =
        await getAvailableServices(zoneId);

    return services
        .map(
          (item) => item.serviceCategoryId,
        )
        .toList();
  }

  static const List<ServiceAvailabilityModel>
      _demoAvailability = [
    ServiceAvailabilityModel(
      serviceCategoryId: 'food',
      serviceName: 'Food',
      zoneId: 'ZONE-DHUPGURI-001',
      partnerId: 'FR-1001',
      franchiseId: 'FR-1001',
      status: ServiceAvailabilityStatus.available,
    ),
    ServiceAvailabilityModel(
      serviceCategoryId: 'ride',
      serviceName: 'Ride',
      zoneId: 'ZONE-DHUPGURI-001',
      partnerId: 'FR-1001',
      franchiseId: 'FR-1001',
      status: ServiceAvailabilityStatus.available,
    ),
    ServiceAvailabilityModel(
      serviceCategoryId: 'delivery',
      serviceName: 'Delivery',
      zoneId: 'ZONE-DHUPGURI-001',
      partnerId: 'FR-1001',
      franchiseId: 'FR-1001',
      status: ServiceAvailabilityStatus.available,
    ),
    ServiceAvailabilityModel(
      serviceCategoryId: 'manpower',
      serviceName: 'Manpower',
      zoneId: 'ZONE-DHUPGURI-001',
      partnerId: 'FR-1001',
      franchiseId: 'FR-1001',
      status: ServiceAvailabilityStatus.available,
    ),
    ServiceAvailabilityModel(
      serviceCategoryId: 'services',
      serviceName: 'Home Services',
      zoneId: 'ZONE-DHUPGURI-001',
      partnerId: 'FR-1001',
      franchiseId: 'FR-1001',
      status: ServiceAvailabilityStatus.available,
    ),
    ServiceAvailabilityModel(
      serviceCategoryId: 'shopping',
      serviceName: 'Shopping',
      zoneId: 'ZONE-DHUPGURI-001',
      partnerId: 'FR-1001',
      franchiseId: 'FR-1001',
      status: ServiceAvailabilityStatus.comingSoon,
    ),
    ServiceAvailabilityModel(
      serviceCategoryId: 'food',
      serviceName: 'Food',
      zoneId: 'ZONE-DHUPGURI-003',
      partnerId: 'CP-1001',
      channelPartnerId: 'CP-1001',
      status: ServiceAvailabilityStatus.available,
    ),
    ServiceAvailabilityModel(
      serviceCategoryId: 'ride',
      serviceName: 'Ride',
      zoneId: 'ZONE-DHUPGURI-003',
      partnerId: 'CP-1001',
      channelPartnerId: 'CP-1001',
      status: ServiceAvailabilityStatus.available,
    ),
    ServiceAvailabilityModel(
      serviceCategoryId: 'delivery',
      serviceName: 'Delivery',
      zoneId: 'ZONE-DHUPGURI-003',
      partnerId: 'CP-1001',
      channelPartnerId: 'CP-1001',
      status: ServiceAvailabilityStatus.available,
    ),
    ServiceAvailabilityModel(
      serviceCategoryId: 'manpower',
      serviceName: 'Manpower',
      zoneId: 'ZONE-DHUPGURI-003',
      partnerId: 'CP-1001',
      channelPartnerId: 'CP-1001',
      status: ServiceAvailabilityStatus.unavailable,
      unavailableMessage:
          'Manpower service is not available in this area yet',
    ),
    ServiceAvailabilityModel(
      serviceCategoryId: 'services',
      serviceName: 'Home Services',
      zoneId: 'ZONE-DHUPGURI-003',
      partnerId: 'CP-1001',
      channelPartnerId: 'CP-1001',
      status: ServiceAvailabilityStatus.available,
    ),
    ServiceAvailabilityModel(
      serviceCategoryId: 'shopping',
      serviceName: 'Shopping',
      zoneId: 'ZONE-DHUPGURI-003',
      partnerId: 'CP-1001',
      channelPartnerId: 'CP-1001',
      status: ServiceAvailabilityStatus.temporarilyUnavailable,
      unavailableMessage:
          'Shopping is temporarily unavailable in this area',
    ),
  ];
}