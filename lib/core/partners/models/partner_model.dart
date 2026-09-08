import 'package:flutter/foundation.dart';

/// Defines the type of business partner.
enum PartnerType {
  franchise,
  channelPartner,
}

/// Defines the partner approval status.
enum PartnerStatus {
  pending,
  approved,
  suspended,
  rejected,
}

/// Defines the partner's CRM access status.
enum PartnerCrmStatus {
  notCreated,
  active,
  blocked,
}

/// Represents a Franchise Partner or Channel Partner.
///
/// This model is designed for a multi-area business platform where
/// partners can operate only within their assigned locations/zones.
///
/// Central Super Admin retains master control over all partners.
@immutable
class PartnerModel {
  final String id;
  final String businessName;
  final String ownerName;
  final String? phone;
  final String? email;

  /// Partner type.
  final PartnerType type;

  /// Partner approval/status.
  final PartnerStatus status;

  /// CRM access status.
  final PartnerCrmStatus crmStatus;

  /// Assigned geographical scope.
  final String? stateId;
  final String? districtId;
  final String? cityId;
  final List<String> zoneIds;

  /// Business information.
  final String? businessAddress;
  final String? pinCode;
  final String? gstNumber;

  /// Commission percentage assigned to the partner.
  final double commissionPercent;

  /// Whether the partner can onboard/manage local businesses.
  final bool canManageVendors;

  /// Whether the partner can manage local service providers.
  final bool canManageServiceProviders;

  /// Whether the partner can manage delivery partners.
  final bool canManageDeliveryPartners;

  /// Whether the partner can manage local operations.
  final bool canManageOrders;

  /// Whether the partner can create local promotions.
  final bool canManagePromotions;

  /// Whether the partner can view financial reports.
  final bool canViewReports;

  /// Creation/update timestamps.
  final DateTime createdAt;
  final DateTime? updatedAt;

  const PartnerModel({
    required this.id,
    required this.businessName,
    required this.ownerName,
    required this.type,
    required this.status,
    required this.crmStatus,
    required this.createdAt,
    this.phone,
    this.email,
    this.stateId,
    this.districtId,
    this.cityId,
    this.zoneIds = const [],
    this.businessAddress,
    this.pinCode,
    this.gstNumber,
    this.commissionPercent = 0.0,
    this.canManageVendors = false,
    this.canManageServiceProviders = false,
    this.canManageDeliveryPartners = false,
    this.canManageOrders = false,
    this.canManagePromotions = false,
    this.canViewReports = false,
    this.updatedAt,
  });

  /// Returns true when the partner is approved and active.
  bool get isActive {
    return status == PartnerStatus.approved &&
        crmStatus == PartnerCrmStatus.active;
  }

  /// Returns true when the partner has CRM access.
  bool get hasCrmAccess {
    return crmStatus == PartnerCrmStatus.active;
  }

  /// Returns true when at least one zone is assigned.
  bool get hasAssignedZones {
    return zoneIds.isNotEmpty;
  }

  /// Returns true when the partner has a valid commission rate.
  bool get hasValidCommission {
    return commissionPercent >= 0 &&
        commissionPercent <= 100;
  }

  /// Human-readable partner type.
  String get typeLabel {
    switch (type) {
      case PartnerType.franchise:
        return 'Franchise Partner';
      case PartnerType.channelPartner:
        return 'Channel Partner';
    }
  }

  /// Human-readable partner status.
  String get statusLabel {
    switch (status) {
      case PartnerStatus.pending:
        return 'Pending';
      case PartnerStatus.approved:
        return 'Approved';
      case PartnerStatus.suspended:
        return 'Suspended';
      case PartnerStatus.rejected:
        return 'Rejected';
    }
  }

  /// Human-readable CRM status.
  String get crmStatusLabel {
    switch (crmStatus) {
      case PartnerCrmStatus.notCreated:
        return 'CRM Not Created';
      case PartnerCrmStatus.active:
        return 'CRM Active';
      case PartnerCrmStatus.blocked:
        return 'CRM Blocked';
    }
  }

  /// Checks whether this partner has access to a specific zone.
  bool hasZoneAccess(String zoneId) {
    final normalizedZoneId = zoneId.trim();

    if (normalizedZoneId.isEmpty) {
      return false;
    }

    return zoneIds.contains(normalizedZoneId);
  }

  /// Checks whether the partner can manage a specific business area.
  bool canManageArea(String zoneId) {
    return isActive && hasZoneAccess(zoneId);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'business_name': businessName,
      'owner_name': ownerName,
      'phone': phone,
      'email': email,
      'type': type.name,
      'status': status.name,
      'crm_status': crmStatus.name,
      'state_id': stateId,
      'district_id': districtId,
      'city_id': cityId,
      'zone_ids': zoneIds,
      'business_address': businessAddress,
      'pin_code': pinCode,
      'gst_number': gstNumber,
      'commission_percent': commissionPercent,
      'can_manage_vendors': canManageVendors,
      'can_manage_service_providers':
          canManageServiceProviders,
      'can_manage_delivery_partners':
          canManageDeliveryPartners,
      'can_manage_orders': canManageOrders,
      'can_manage_promotions': canManagePromotions,
      'can_view_reports': canViewReports,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  factory PartnerModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return PartnerModel(
      id: map['id']?.toString() ?? '',
      businessName:
          map['business_name']?.toString() ?? '',
      ownerName:
          map['owner_name']?.toString() ?? '',
      phone: _toNullableString(map['phone']),
      email: _toNullableString(map['email']),
      type: _parsePartnerType(map['type']),
      status: _parsePartnerStatus(map['status']),
      crmStatus:
          _parseCrmStatus(map['crm_status']),
      stateId: _toNullableString(map['state_id']),
      districtId:
          _toNullableString(map['district_id']),
      cityId: _toNullableString(map['city_id']),
      zoneIds: _toStringList(map['zone_ids']),
      businessAddress:
          _toNullableString(map['business_address']),
      pinCode:
          _toNullableString(map['pin_code']),
      gstNumber:
          _toNullableString(map['gst_number']),
      commissionPercent:
          _toDouble(map['commission_percent']),
      canManageVendors:
          _toBool(map['can_manage_vendors']),
      canManageServiceProviders:
          _toBool(
            map['can_manage_service_providers'],
          ),
      canManageDeliveryPartners:
          _toBool(
            map['can_manage_delivery_partners'],
          ),
      canManageOrders:
          _toBool(map['can_manage_orders']),
      canManagePromotions:
          _toBool(map['can_manage_promotions']),
      canViewReports:
          _toBool(map['can_view_reports']),
      createdAt:
          _toDateTime(map['created_at']),
      updatedAt:
          _toNullableDateTime(map['updated_at']),
    );
  }

  PartnerModel copyWith({
    String? id,
    String? businessName,
    String? ownerName,
    String? phone,
    String? email,
    PartnerType? type,
    PartnerStatus? status,
    PartnerCrmStatus? crmStatus,
    String? stateId,
    String? districtId,
    String? cityId,
    List<String>? zoneIds,
    String? businessAddress,
    String? pinCode,
    String? gstNumber,
    double? commissionPercent,
    bool? canManageVendors,
    bool? canManageServiceProviders,
    bool? canManageDeliveryPartners,
    bool? canManageOrders,
    bool? canManagePromotions,
    bool? canViewReports,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PartnerModel(
      id: id ?? this.id,
      businessName:
          businessName ?? this.businessName,
      ownerName: ownerName ?? this.ownerName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      type: type ?? this.type,
      status: status ?? this.status,
      crmStatus: crmStatus ?? this.crmStatus,
      stateId: stateId ?? this.stateId,
      districtId:
          districtId ?? this.districtId,
      cityId: cityId ?? this.cityId,
      zoneIds: zoneIds ?? this.zoneIds,
      businessAddress:
          businessAddress ?? this.businessAddress,
      pinCode: pinCode ?? this.pinCode,
      gstNumber: gstNumber ?? this.gstNumber,
      commissionPercent:
          commissionPercent ?? this.commissionPercent,
      canManageVendors:
          canManageVendors ?? this.canManageVendors,
      canManageServiceProviders:
          canManageServiceProviders ??
              this.canManageServiceProviders,
      canManageDeliveryPartners:
          canManageDeliveryPartners ??
              this.canManageDeliveryPartners,
      canManageOrders:
          canManageOrders ?? this.canManageOrders,
      canManagePromotions:
          canManagePromotions ??
              this.canManagePromotions,
      canViewReports:
          canViewReports ?? this.canViewReports,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  static PartnerType _parsePartnerType(
    dynamic value,
  ) {
    final name = value?.toString();

    return PartnerType.values.firstWhere(
      (item) => item.name == name,
      orElse: () => PartnerType.channelPartner,
    );
  }

  static PartnerStatus _parsePartnerStatus(
    dynamic value,
  ) {
    final name = value?.toString();

    return PartnerStatus.values.firstWhere(
      (item) => item.name == name,
      orElse: () => PartnerStatus.pending,
    );
  }

  static PartnerCrmStatus _parseCrmStatus(
    dynamic value,
  ) {
    final name = value?.toString();

    return PartnerCrmStatus.values.firstWhere(
      (item) => item.name == name,
      orElse: () => PartnerCrmStatus.notCreated,
    );
  }

  static List<String> _toStringList(
    dynamic value,
  ) {
    if (value is! List) {
      return const [];
    }

    return value
        .map((item) => item.toString().trim())
        .where((item) => item.isNotEmpty)
        .toList(growable: false);
  }

  static String? _toNullableString(
    dynamic value,
  ) {
    if (value == null) {
      return null;
    }

    final text = value.toString().trim();

    if (text.isEmpty) {
      return null;
    }

    return text;
  }

  static double _toDouble(
    dynamic value,
  ) {
    if (value is num) {
      return value.toDouble();
    }

    return double.tryParse(
          value?.toString() ?? '',
        ) ??
        0.0;
  }

  static bool _toBool(
    dynamic value,
  ) {
    if (value is bool) {
      return value;
    }

    if (value is num) {
      return value != 0;
    }

    final text =
        value?.toString().trim().toLowerCase();

    return text == 'true' || text == '1';
  }

  static DateTime _toDateTime(
    dynamic value,
  ) {
    if (value is DateTime) {
      return value;
    }

    return DateTime.tryParse(
          value?.toString() ?? '',
        ) ??
        DateTime.now();
  }

  static DateTime? _toNullableDateTime(
    dynamic value,
  ) {
    if (value == null) {
      return null;
    }

    if (value is DateTime) {
      return value;
    }

    return DateTime.tryParse(
      value.toString(),
    );
  }
}