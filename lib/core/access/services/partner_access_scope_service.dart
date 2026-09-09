import 'package:super_app/core/access/models/partner_access_scope_model.dart';
import 'package:super_app/core/access/models/role_permission_model.dart';

class PartnerAccessScopeService {
  const PartnerAccessScopeService();

  bool canAccessZone({
    required PartnerAccessScopeModel scope,
    required String zoneId,
  }) {
    return scope.hasZoneAccess(zoneId);
  }

  bool canAccessPartner({
    required PartnerAccessScopeModel scope,
    required String partnerId,
  }) {
    return scope.canAccessPartner(partnerId);
  }

  bool canAccessLocation({
    required PartnerAccessScopeModel scope,
    String? stateId,
    String? districtId,
    String? cityId,
    String? zoneId,
  }) {
    return scope.canAccessLocation(
      stateId: stateId,
      districtId: districtId,
      cityId: cityId,
      zoneId: zoneId,
    );
  }

  bool canManageZone({
    required PartnerAccessScopeModel scope,
    required String zoneId,
  }) {
    return scope.canManageZone(zoneId);
  }

  bool canPerform({
    required PartnerAccessScopeModel scope,
    required Permission permission,
    String? zoneId,
  }) {
    if (!scope.isActive) {
      return false;
    }

    if (scope.role == AppRole.superAdmin) {
      return true;
    }

    if (!scope.rolePermissionAllowed(permission)) {
      return false;
    }

    if (zoneId == null || zoneId.trim().isEmpty) {
      return true;
    }

    return scope.hasZoneAccess(zoneId);
  }
}

extension PartnerAccessScopePermissionExtension
    on PartnerAccessScopeModel {
  bool rolePermissionAllowed(Permission permission) {
    switch (role) {
      case AppRole.superAdmin:
        return true;

      case AppRole.admin:
        return _adminPermissions.contains(permission);

      case AppRole.franchise:
        return _franchisePermissions.contains(permission);

      case AppRole.channelPartner:
        return _channelPartnerPermissions.contains(permission);

      case AppRole.seller:
        return _sellerPermissions.contains(permission);

      case AppRole.deliveryPartner:
        return _deliveryPartnerPermissions.contains(permission);

      case AppRole.serviceProvider:
        return _serviceProviderPermissions.contains(permission);

      case AppRole.customer:
        return _customerPermissions.contains(permission);
    }
  }

  static const Set<Permission> _adminPermissions = {
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
  };

  static const Set<Permission> _franchisePermissions = {
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
  };

  static const Set<Permission> _channelPartnerPermissions = {
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
  };

  static const Set<Permission> _sellerPermissions = {
    Permission.viewDashboard,
    Permission.manageOrders,
    Permission.manageProducts,
    Permission.viewReports,
    Permission.manageSupport,
  };

  static const Set<Permission> _deliveryPartnerPermissions = {
    Permission.viewDashboard,
    Permission.manageOrders,
    Permission.manageSupport,
  };

  static const Set<Permission> _serviceProviderPermissions = {
    Permission.viewDashboard,
    Permission.manageOrders,
    Permission.manageServices,
    Permission.manageSupport,
  };

  static const Set<Permission> _customerPermissions = {
    Permission.viewDashboard,
    Permission.manageOrders,
    Permission.manageSupport,
  };
}