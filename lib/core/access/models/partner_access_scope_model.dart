import 'package:flutter/foundation.dart';

import 'package:super_app/core/access/models/role_permission_model.dart';

@immutable
class PartnerAccessScopeModel {
  final String userId;
  final AppRole role;

  final String? partnerId;
  final String? franchiseId;
  final String? channelPartnerId;

  final String? stateId;
  final String? districtId;
  final String? cityId;

  final List<String> zoneIds;

  final bool isActive;

  const PartnerAccessScopeModel({
    required this.userId,
    required this.role,
    this.partnerId,
    this.franchiseId,
    this.channelPartnerId,
    this.stateId,
    this.districtId,
    this.cityId,
    this.zoneIds = const [],
    this.isActive = true,
  });

  bool get isSuperAdmin {
    return role == AppRole.superAdmin;
  }

  bool get isAdmin {
    return role == AppRole.admin;
  }

  bool get isGlobalAccess {
    return isSuperAdmin || isAdmin;
  }

  bool get isPartner {
    return role == AppRole.franchise ||
        role == AppRole.channelPartner;
  }

  bool get isFranchise {
    return role == AppRole.franchise;
  }

  bool get isChannelPartner {
    return role == AppRole.channelPartner;
  }

  bool get hasPartner {
    return partnerId != null &&
        partnerId!.trim().isNotEmpty;
  }

  bool get hasZoneScope {
    return !isGlobalAccess;
  }

  bool hasZoneAccess(String zoneId) {
    if (!isActive) {
      return false;
    }

    if (isGlobalAccess) {
      return true;
    }

    final normalizedZoneId = zoneId.trim();

    if (normalizedZoneId.isEmpty) {
      return false;
    }

    return zoneIds.contains(normalizedZoneId);
  }

  bool canAccessPartner(String requestedPartnerId) {
    if (!isActive) {
      return false;
    }

    if (isGlobalAccess) {
      return true;
    }

    final normalizedPartnerId =
        requestedPartnerId.trim();

    if (normalizedPartnerId.isEmpty) {
      return false;
    }

    if (partnerId == null) {
      return false;
    }

    return partnerId == normalizedPartnerId;
  }

  bool canAccessLocation({
    String? stateId,
    String? districtId,
    String? cityId,
    String? zoneId,
  }) {
    if (!isActive) {
      return false;
    }

    if (isGlobalAccess) {
      return true;
    }

    if (stateId != null &&
        this.stateId != null &&
        this.stateId != stateId) {
      return false;
    }

    if (districtId != null &&
        this.districtId != null &&
        this.districtId != districtId) {
      return false;
    }

    if (cityId != null &&
        this.cityId != null &&
        this.cityId != cityId) {
      return false;
    }

    if (zoneId != null) {
      return hasZoneAccess(zoneId);
    }

    return true;
  }

  bool canManageZone(String zoneId) {
    if (!isActive) {
      return false;
    }

    if (isGlobalAccess) {
      return true;
    }

    if (!isPartner) {
      return false;
    }

    return hasZoneAccess(zoneId);
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'role': role.name,
      'partner_id': partnerId,
      'franchise_id': franchiseId,
      'channel_partner_id': channelPartnerId,
      'state_id': stateId,
      'district_id': districtId,
      'city_id': cityId,
      'zone_ids': zoneIds,
      'is_active': isActive,
    };
  }

  factory PartnerAccessScopeModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return PartnerAccessScopeModel(
      userId: map['user_id']?.toString() ?? '',
      role: _parseRole(map['role']),
      partnerId: _toNullableString(
        map['partner_id'],
      ),
      franchiseId: _toNullableString(
        map['franchise_id'],
      ),
      channelPartnerId: _toNullableString(
        map['channel_partner_id'],
      ),
      stateId: _toNullableString(
        map['state_id'],
      ),
      districtId: _toNullableString(
        map['district_id'],
      ),
      cityId: _toNullableString(
        map['city_id'],
      ),
      zoneIds: _toStringList(
        map['zone_ids'],
      ),
      isActive: _toBool(
        map['is_active'],
      ),
    );
  }

  PartnerAccessScopeModel copyWith({
    String? userId,
    AppRole? role,
    String? partnerId,
    String? franchiseId,
    String? channelPartnerId,
    String? stateId,
    String? districtId,
    String? cityId,
    List<String>? zoneIds,
    bool? isActive,
  }) {
    return PartnerAccessScopeModel(
      userId: userId ?? this.userId,
      role: role ?? this.role,
      partnerId: partnerId ?? this.partnerId,
      franchiseId: franchiseId ?? this.franchiseId,
      channelPartnerId:
          channelPartnerId ?? this.channelPartnerId,
      stateId: stateId ?? this.stateId,
      districtId: districtId ?? this.districtId,
      cityId: cityId ?? this.cityId,
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

  static List<String> _toStringList(dynamic value) {
    if (value is List) {
      return value
          .map((item) => item.toString())
          .where(
            (item) => item.trim().isNotEmpty,
          )
          .toList();
    }

    if (value is String &&
        value.trim().isNotEmpty) {
      return [value.trim()];
    }

    return const [];
  }

  static String? _toNullableString(dynamic value) {
    if (value == null) {
      return null;
    }

    final text = value.toString().trim();

    return text.isEmpty ? null : text;
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