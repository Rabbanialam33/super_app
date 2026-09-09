import 'package:flutter/foundation.dart';

enum AppRole {
  customer,
  seller,
  deliveryPartner,
  serviceProvider,
  franchise,
  channelPartner,
  admin,
  superAdmin,
}

enum Permission {
  viewDashboard,
  manageCustomers,
  manageVendors,
  manageServiceProviders,
  manageDeliveryPartners,
  manageOrders,
  manageRides,
  manageServices,
  manageProducts,
  managePromotions,
  managePayments,
  manageRefunds,
  manageCommissions,
  managePartners,
  manageZones,
  manageLocations,
  viewReports,
  manageSupport,
  manageKyc,
  manageSettings,
  manageUsers,
  viewAuditLogs,
}

@immutable
class RolePermissionModel {
  final AppRole role;
  final List<Permission> permissions;
  final List<String> zoneIds;
  final bool isActive;

  const RolePermissionModel({
    required this.role,
    this.permissions = const [],
    this.zoneIds = const [],
    this.isActive = true,
  });

  bool get isGlobalRole {
    return role == AppRole.superAdmin ||
        role == AppRole.admin;
  }

  bool get isPartnerRole {
    return role == AppRole.franchise ||
        role == AppRole.channelPartner;
  }

  bool get hasZoneScope {
    return !isGlobalRole;
  }

  bool hasPermission(Permission permission) {
    if (!isActive) {
      return false;
    }

    if (role == AppRole.superAdmin) {
      return true;
    }

    return permissions.contains(permission);
  }

  bool hasZoneAccess(String zoneId) {
    if (!isActive) {
      return false;
    }

    if (isGlobalRole) {
      return true;
    }

    final normalizedZoneId = zoneId.trim();

    if (normalizedZoneId.isEmpty) {
      return false;
    }

    return zoneIds.contains(normalizedZoneId);
  }

  bool canAccessZone(String zoneId) {
    return isActive && hasZoneAccess(zoneId);
  }

  bool canPerform(
    Permission permission, {
    String? zoneId,
  }) {
    if (!hasPermission(permission)) {
      return false;
    }

    if (zoneId == null || zoneId.trim().isEmpty) {
      return true;
    }

    return hasZoneAccess(zoneId);
  }

  String get roleLabel {
    switch (role) {
      case AppRole.customer:
        return 'Customer';
      case AppRole.seller:
        return 'Seller';
      case AppRole.deliveryPartner:
        return 'Delivery Partner';
      case AppRole.serviceProvider:
        return 'Service Provider';
      case AppRole.franchise:
        return 'Franchise Partner';
      case AppRole.channelPartner:
        return 'Channel Partner';
      case AppRole.admin:
        return 'Admin';
      case AppRole.superAdmin:
        return 'Super Admin';
    }
  }

  Map<String, dynamic> toMap() {
    return {
      'role': role.name,
      'permissions':
          permissions.map((permission) => permission.name).toList(),
      'zone_ids': zoneIds,
      'is_active': isActive,
    };
  }

  factory RolePermissionModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return RolePermissionModel(
      role: _parseRole(map['role']),
      permissions: _parsePermissions(map['permissions']),
      zoneIds: _toStringList(map['zone_ids']),
      isActive: _toBool(map['is_active']),
    );
  }

  RolePermissionModel copyWith({
    AppRole? role,
    List<Permission>? permissions,
    List<String>? zoneIds,
    bool? isActive,
  }) {
    return RolePermissionModel(
      role: role ?? this.role,
      permissions: permissions ?? this.permissions,
      zoneIds: zoneIds ?? this.zoneIds,
      isActive: isActive ?? this.isActive,
    );
  }

  static AppRole _parseRole(dynamic value) {
    final roleName = value?.toString();

    return AppRole.values.firstWhere(
      (item) => item.name == roleName,
      orElse: () => AppRole.customer,
    );
  }

  static List<Permission> _parsePermissions(
    dynamic value,
  ) {
    if (value is! List) {
      return const [];
    }

    return value
        .map(
          (item) => Permission.values.firstWhere(
            (permission) =>
                permission.name == item.toString(),
            orElse: () => Permission.viewDashboard,
          ),
        )
        .toList();
  }

  static List<String> _toStringList(dynamic value) {
    if (value is List) {
      return value
          .map((item) => item.toString())
          .where((item) => item.trim().isNotEmpty)
          .toList();
    }

    if (value is String && value.trim().isNotEmpty) {
      return [value.trim()];
    }

    return const [];
  }

  static bool _toBool(dynamic value) {
    if (value is bool) {
      return value;
    }

    if (value is String) {
      return value.toLowerCase() == 'true';
    }

    if (value is num) {
      return value != 0;
    }

    return true;
  }
}