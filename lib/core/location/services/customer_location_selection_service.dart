import 'package:super_app/core/location/models/customer_location_selection_model.dart';
import 'package:super_app/core/location/models/location_model.dart';
import 'package:super_app/core/location/models/service_availability_model.dart';
import 'package:super_app/core/location/models/service_zone_model.dart';
import 'package:super_app/core/location/services/service_availability_service.dart';

class CustomerLocationSelectionService {
  final ServiceAvailabilityService _availabilityService;

  const CustomerLocationSelectionService({
    this._availabilityService = const ServiceAvailabilityService(),
  });

  Future<ServiceZoneModel?> findMatchingZone(
    LocationModel location,
  ) async {
    final normalizedPin = _normalize(location.pinCode);
    final normalizedState = _normalize(location.state);
    final normalizedDistrict = _normalize(location.district);
    final normalizedCity = _normalize(location.city);

    if (normalizedPin.isEmpty) {
      return null;
    }

    for (final zone in _demoZones) {
      if (!zone.isOperational) {
        continue;
      }

      if (!zone.containsPinCode(normalizedPin)) {
        continue;
      }

      final stateMatches =
          _normalize(zone.state) == normalizedState;

      final districtMatches =
          _normalize(zone.district) == normalizedDistrict;

      final cityMatches =
          _normalize(zone.city) == normalizedCity;

      if (stateMatches && districtMatches && cityMatches) {
        return zone;
      }
    }

    return null;
  }

  Future<List<ServiceAvailabilityModel>>
      getAvailableServicesForLocation(
    LocationModel location,
  ) async {
    final zone = await findMatchingZone(location);

    if (zone == null) {
      return const [];
    }

    return _availabilityService.getAvailableServices(zone.id);
  }

  Future<List<ServiceAvailabilityModel>>
      getServiceAvailabilityForLocation(
    LocationModel location,
  ) async {
    final zone = await findMatchingZone(location);

    if (zone == null) {
      return const [];
    }

    return _availabilityService.getAvailabilityByZone(zone.id);
  }

  Future<bool> isServiceAvailableForLocation({
    required LocationModel location,
    required String serviceCategoryId,
  }) async {
    final zone = await findMatchingZone(location);

    if (zone == null) {
      return false;
    }

    return _availabilityService.isServiceAvailable(
      zoneId: zone.id,
      serviceCategoryId: serviceCategoryId,
    );
  }

  Future<CustomerLocationSelectionModel>
      createSelectionForLocation(
    LocationModel location,
  ) async {
    final zone = await findMatchingZone(location);

    return CustomerLocationSelectionModel(
      selectedLocation: location,
      selectedZoneId: zone?.id,
      isConfirmed: false,
      isDetectingLocation: false,
      isLoading: false,
      errorMessage: zone == null
          ? 'Service is not available in your area yet'
          : null,
    );
  }

  Future<CustomerLocationSelectionModel> confirmLocation(
    LocationModel location,
  ) async {
    final zone = await findMatchingZone(location);

    if (zone == null) {
      return CustomerLocationSelectionModel(
        selectedLocation: location,
        selectedZoneId: null,
        isConfirmed: false,
        errorMessage:
            'Service is not available in your area yet',
      );
    }

    return CustomerLocationSelectionModel(
      selectedLocation: location,
      selectedZoneId: zone.id,
      isConfirmed: true,
      isDetectingLocation: false,
      isLoading: false,
      errorMessage: null,
    );
  }

  Future<String> getLocationStatusMessage(
    LocationModel location,
  ) async {
    final zone = await findMatchingZone(location);

    if (zone == null) {
      return 'Service is not available in your area yet';
    }

    return 'Location available in ${zone.name}';
  }

  Future<List<String>> getAvailableServiceIdsForLocation(
    LocationModel location,
  ) async {
    final zone = await findMatchingZone(location);

    if (zone == null) {
      return const [];
    }

    return _availabilityService.getAvailableServiceIds(zone.id);
  }

  Future<bool> hasAvailableService(
    LocationModel location,
  ) async {
    final zone = await findMatchingZone(location);

    if (zone == null) {
      return false;
    }

    return _availabilityService.hasAnyAvailableService(zone.id);
  }

  static String _normalize(String? value) {
    return value?.trim().toLowerCase() ?? '';
  }

  static const List<ServiceZoneModel> _demoZones = [
    ServiceZoneModel(
      id: 'ZONE-DHUPGURI-001',
      name: 'Dhupguri Zone 001',
      state: 'West Bengal',
      district: 'Jalpaiguri',
      city: 'Dhupguri',
      area: 'Dhupguri Town',
      pinCodes: ['735210'],
      centerLatitude: 26.5892,
      centerLongitude: 89.0076,
      radiusKm: 5,
      franchiseId: 'FR-1001',
      serviceCategoryIds: [
        'food',
        'ride',
        'delivery',
        'manpower',
        'services',
        'shopping',
      ],
      isActive: true,
      acceptingOrders: true,
    ),
    ServiceZoneModel(
      id: 'ZONE-DHUPGURI-003',
      name: 'Dhupguri Zone 003',
      state: 'West Bengal',
      district: 'Jalpaiguri',
      city: 'Dhupguri',
      area: 'Dhupguri',
      pinCodes: ['735210'],
      centerLatitude: 26.5892,
      centerLongitude: 89.0076,
      radiusKm: 8,
      channelPartnerId: 'CP-1001',
      serviceCategoryIds: [
        'food',
        'ride',
        'delivery',
        'manpower',
        'services',
        'shopping',
      ],
      isActive: true,
      acceptingOrders: true,
    ),
  ];
}