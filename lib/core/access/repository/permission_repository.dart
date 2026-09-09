import 'package:super_app/core/access/models/role_permission_model.dart';

class PermissionRepository {
  const PermissionRepository();

  Future<RolePermissionModel> getPermissionsForRole(
    AppRole role,
  ) async {
    return _defaultPermissions[role] ??
        const RolePermissionModel(
          role: AppRole.customer,
        );
  }

  Future<bool> hasPermission(
    AppRole role,
    Permission permission,
  ) async {
    final rolePermission = await getPermissionsForRole(role);

    return rolePermission.hasPermission(permission);
  }

  Future<List<Permission>> getPermissions(
    AppRole role,
  ) async {
    final rolePermission = await getPermissionsForRole(role);

    return rolePermission.permissions;
  }

  Future<bool> canAccessZone(
    AppRole role,
    String zoneId, {
    List<String> assignedZoneIds = const [],
  }) async {
    final rolePermission = await getPermissionsForRole(role);

    if (rolePermission.isGlobalRole) {
      return true;
    }

    if (!rolePermission.isActive) {
      return false;
    }

    final normalizedZoneId = zoneId.trim();

    if (normalizedZoneId.isEmpty) {
      return false;
    }

    return assignedZoneIds.contains(normalizedZoneId);
  }

  static const Map<AppRole, RolePermissionModel>
      _defaultPermissions = {
    AppRole.superAdmin: RolePermissionModel(
      role: AppRole.superAdmin,
      permissions: Permission.values,
    ),

    AppRole.admin: RolePermissionModel(
      role: AppRole.admin,
      permissions: [
        Permission.viewDashboard,
        Permission.manageCustomers,
        Permission.manageVendors,
        Permission.manageServiceProviders,
        Permission.manageDeliveryPartners,
        Permission.manageOrders,
        Permission.manageRides,
        Permission.manageServices,
        Permission.manageProducts,
        Permission.managePromotions,
        Permission.managePayments,
        Permission.manageRefunds,
        Permission.manageCommissions,
        Permission.managePartners,
        Permission.manageZones,
        Permission.manageLocations,
        Permission.viewReports,
        Permission.manageSupport,
        Permission.manageKyc,
        Permission.manageUsers,
        Permission.viewAuditLogs,
      ],
    ),

    AppRole.franchise: RolePermissionModel(
      role: AppRole.franchise,
      permissions: [
        Permission.viewDashboard,
        Permission.manageCustomers,
        Permission.manageVendors,
        Permission.manageServiceProviders,
        Permission.manageDeliveryPartners,
        Permission.manageOrders,
        Permission.manageRides,
        Permission.manageServices,
        Permission.manageProducts,
        Permission.managePromotions,
        Permission.viewReports,
        Permission.manageSupport,
        Permission.manageKyc,
      ],
    ),

    AppRole.channelPartner: RolePermissionModel(
      role: AppRole.channelPartner,
      permissions: [
        Permission.viewDashboard,
        Permission.manageCustomers,
        Permission.manageVendors,
        Permission.manageServiceProviders,
        Permission.manageDeliveryPartners,
        Permission.manageOrders,
        Permission.manageRides,
        Permission.manageServices,
        Permission.manageProducts,
        Permission.viewReports,
        Permission.manageSupport,
        Permission.manageKyc,
      ],
    ),

    AppRole.seller: RolePermissionModel(
      role: AppRole.seller,
      permissions: [
        Permission.viewDashboard,
        Permission.manageOrders,
        Permission.manageProducts,
        Permission.viewReports,
        Permission.manageSupport,
      ],
    ),

    AppRole.deliveryPartner: RolePermissionModel(
      role: AppRole.deliveryPartner,
      permissions: [
        Permission.viewDashboard,
        Permission.manageOrders,
        Permission.manageSupport,
      ],
    ),

    AppRole.serviceProvider: RolePermissionModel(
      role: AppRole.serviceProvider,
      permissions: [
        Permission.viewDashboard,
        Permission.manageOrders,
        Permission.manageServices,
        Permission.manageSupport,
      ],
    ),

    AppRole.customer: RolePermissionModel(
      role: AppRole.customer,
      permissions: [
        Permission.viewDashboard,
        Permission.manageOrders,
        Permission.manageSupport,
      ],
    ),
  };
}