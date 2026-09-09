import 'package:super_app/core/access/models/role_permission_model.dart';
import 'package:super_app/core/access/repository/permission_repository.dart';

class PermissionService {
  final PermissionRepository _repository;

  const PermissionService({
    this._repository = const PermissionRepository(),
  });

  Future<RolePermissionModel> getRolePermissions(
    AppRole role,
  ) async {
    return _repository.getPermissionsForRole(role);
  }

  Future<bool> hasPermission(
    AppRole role,
    Permission permission,
  ) async {
    return _repository.hasPermission(
      role,
      permission,
    );
  }

  Future<List<Permission>> getPermissions(
    AppRole role,
  ) async {
    return _repository.getPermissions(role);
  }

  Future<bool> canAccessZone(
    AppRole role,
    String zoneId, {
    List<String> assignedZoneIds = const [],
  }) async {
    return _repository.canAccessZone(
      role,
      zoneId,
      assignedZoneIds: assignedZoneIds,
    );
  }

  Future<bool> canPerform({
    required AppRole role,
    required Permission permission,
    String? zoneId,
    List<String> assignedZoneIds = const [],
  }) async {
    final rolePermissions =
        await getRolePermissions(role);

    if (!rolePermissions.hasPermission(permission)) {
      return false;
    }

    if (zoneId == null || zoneId.trim().isEmpty) {
      return true;
    }

    return canAccessZone(
      role,
      zoneId,
      assignedZoneIds: assignedZoneIds,
    );
  }

  Future<bool> canManagePartnerArea({
    required AppRole role,
    required String zoneId,
    required List<String> assignedZoneIds,
  }) async {
    if (role != AppRole.franchise &&
        role != AppRole.channelPartner) {
      return false;
    }

    return canAccessZone(
      role,
      zoneId,
      assignedZoneIds: assignedZoneIds,
    );
  }

  Future<bool> canViewReports({
    required AppRole role,
    String? zoneId,
    List<String> assignedZoneIds = const [],
  }) async {
    return canPerform(
      role: role,
      permission: Permission.viewReports,
      zoneId: zoneId,
      assignedZoneIds: assignedZoneIds,
    );
  }

  Future<bool> canManageOrders({
    required AppRole role,
    String? zoneId,
    List<String> assignedZoneIds = const [],
  }) async {
    return canPerform(
      role: role,
      permission: Permission.manageOrders,
      zoneId: zoneId,
      assignedZoneIds: assignedZoneIds,
    );
  }

  Future<bool> canManageVendors({
    required AppRole role,
    String? zoneId,
    List<String> assignedZoneIds = const [],
  }) async {
    return canPerform(
      role: role,
      permission: Permission.manageVendors,
      zoneId: zoneId,
      assignedZoneIds: assignedZoneIds,
    );
  }

  Future<bool> canManageServiceProviders({
    required AppRole role,
    String? zoneId,
    List<String> assignedZoneIds = const [],
  }) async {
    return canPerform(
      role: role,
      permission: Permission.manageServiceProviders,
      zoneId: zoneId,
      assignedZoneIds: assignedZoneIds,
    );
  }

  Future<bool> canManageDeliveryPartners({
    required AppRole role,
    String? zoneId,
    List<String> assignedZoneIds = const [],
  }) async {
    return canPerform(
      role: role,
      permission: Permission.manageDeliveryPartners,
      zoneId: zoneId,
      assignedZoneIds: assignedZoneIds,
    );
  }
}