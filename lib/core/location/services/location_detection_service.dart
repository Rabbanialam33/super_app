import 'package:geolocator/geolocator.dart';

/// Handles device location detection and permission checks.
///
/// This service is intentionally kept independent from the UI so it can
/// later be reused by:
/// - Customer location selection
/// - Service-zone matching
/// - Delivery tracking
/// - Ride booking
/// - Nearby services
class LocationDetectionService {
  const LocationDetectionService();

  /// Checks whether location services are enabled on the device.
  Future<bool> isLocationServiceEnabled() {
    return Geolocator.isLocationServiceEnabled();
  }

  /// Returns the current location permission status.
  Future<LocationPermission> checkPermission() {
    return Geolocator.checkPermission();
  }

  /// Requests location permission from the user.
  Future<LocationPermission> requestPermission() {
    return Geolocator.requestPermission();
  }

  /// Returns whether the current permission allows location access.
  Future<bool> hasLocationPermission() async {
    final permission = await checkPermission();

    return permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always;
  }

  /// Requests permission when necessary and returns the final status.
  Future<LocationPermission> ensureLocationPermission() async {
    final currentPermission = await checkPermission();

    if (currentPermission == LocationPermission.denied) {
      return requestPermission();
    }

    return currentPermission;
  }

  /// Gets the device's current geographic position.
  ///
  /// Throws a [LocationServiceDisabledException] when device location
  /// services are disabled.
  ///
  /// Throws a [PermissionDeniedException] when location permission
  /// is unavailable.
  Future<Position> getCurrentPosition() async {
    final serviceEnabled = await isLocationServiceEnabled();

    if (!serviceEnabled) {
      throw const LocationServiceDisabledException();
    }

    final permission = await ensureLocationPermission();

    if (permission == LocationPermission.denied) {
      throw const PermissionDeniedException(
        'Location permission was denied.',
      );
    }

    if (permission == LocationPermission.deniedForever) {
      throw const PermissionDeniedException(
        'Location permission was permanently denied.',
      );
    }

    return Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
      ),
    );
  }

  /// Opens the device location settings.
  Future<bool> openLocationSettings() {
    return Geolocator.openLocationSettings();
  }

  /// Opens the application settings so the user can manually enable
  /// permanently denied location permission.
  Future<bool> openAppSettings() {
    return Geolocator.openAppSettings();
  }

  /// Converts a [Position] into a simple coordinate map.
  ///
  /// Useful when connecting this service to the existing LocationModel
  /// and later to Supabase/PostgreSQL.
  Map<String, double> positionToCoordinates(Position position) {
    return <String, double>{
      'latitude': position.latitude,
      'longitude': position.longitude,
    };
  }
}