import 'package:super_app/core/location/models/service_availability_model.dart';
import 'package:super_app/core/location/repository/service_availability_repository.dart';

class ServiceAvailabilityService {
  final ServiceAvailabilityRepository _repository;

  const ServiceAvailabilityService({
    this._repository = const ServiceAvailabilityRepository(),
  });

  Future<List<ServiceAvailabilityModel>> getAvailabilityByZone(
    String zoneId,
  ) async {
    return _repository.getAvailabilityByZone(zoneId);
  }

  Future<ServiceAvailabilityModel?> getServiceAvailability({
    required String zoneId,
    required String serviceCategoryId,
  }) async {
    return _repository.getServiceAvailability(
      zoneId: zoneId,
      serviceCategoryId: serviceCategoryId,
    );
  }

  Future<List<ServiceAvailabilityModel>> getAvailableServices(
    String zoneId,
  ) async {
    return _repository.getAvailableServices(zoneId);
  }

  Future<List<ServiceAvailabilityModel>> getUnavailableServices(
    String zoneId,
  ) async {
    return _repository.getUnavailableServices(zoneId);
  }

  Future<bool> isServiceAvailable({
    required String zoneId,
    required String serviceCategoryId,
  }) async {
    return _repository.isServiceAvailable(
      zoneId: zoneId,
      serviceCategoryId: serviceCategoryId,
    );
  }

  Future<List<String>> getAvailableServiceIds(
    String zoneId,
  ) async {
    return _repository.getAvailableServiceIds(zoneId);
  }

  Future<bool> hasAnyAvailableService(
    String zoneId,
  ) async {
    final services = await getAvailableServices(zoneId);

    return services.isNotEmpty;
  }

  Future<String> getServiceMessage({
    required String zoneId,
    required String serviceCategoryId,
    required String serviceName,
  }) async {
    final availability = await getServiceAvailability(
      zoneId: zoneId,
      serviceCategoryId: serviceCategoryId,
    );

    if (availability == null) {
      return '$serviceName is not available in your area yet';
    }

    return availability.displayMessage;
  }
}