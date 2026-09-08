import 'package:super_app/core/partners/models/partner_model.dart';

class PartnerRepository {
  const PartnerRepository();

  Future<List<PartnerModel>> getAllPartners() async {
    return _demoPartners;
  }

  Future<PartnerModel?> getPartnerById(String partnerId) async {
    final normalizedId = partnerId.trim();

    if (normalizedId.isEmpty) {
      return null;
    }

    for (final partner in _demoPartners) {
      if (partner.id == normalizedId) {
        return partner;
      }
    }

    return null;
  }

  Future<List<PartnerModel>> getPartnersByType(
    PartnerType type,
  ) async {
    return _demoPartners
        .where((partner) => partner.type == type)
        .toList();
  }

  Future<List<PartnerModel>> getActivePartners() async {
    return _demoPartners
        .where((partner) => partner.isActive)
        .toList();
  }

  Future<List<PartnerModel>> getPartnersByZone(
    String zoneId,
  ) async {
    final normalizedZoneId = zoneId.trim();

    if (normalizedZoneId.isEmpty) {
      return [];
    }

    return _demoPartners
        .where(
          (partner) => partner.hasZoneAccess(normalizedZoneId),
        )
        .toList();
  }

  Future<List<PartnerModel>> getPartnersByStatus(
    PartnerStatus status,
  ) async {
    return _demoPartners
        .where((partner) => partner.status == status)
        .toList();
  }

  Future<bool> partnerExists(String partnerId) async {
    final partner = await getPartnerById(partnerId);
    return partner != null;
  }

  static final List<PartnerModel> _demoPartners = [
    PartnerModel(
      id: 'FR-1001',
      businessName: 'SuperAll North Bengal Franchise',
      ownerName: 'Demo Franchise Owner',
      phone: '9000000001',
      email: 'franchise@example.com',
      type: PartnerType.franchise,
      status: PartnerStatus.approved,
      crmStatus: PartnerCrmStatus.active,
      stateId: 'WB',
      districtId: 'JALPAIGURI',
      cityId: 'DHUPGURI',
      zoneIds: const [
        'ZONE-DHUPGURI-001',
        'ZONE-DHUPGURI-002',
      ],
      businessAddress: 'Dhupguri, West Bengal',
      pinCode: '735210',
      commissionPercent: 8.0,
      canManageVendors: true,
      canManageServiceProviders: true,
      canManageDeliveryPartners: true,
      canManageOrders: true,
      canManagePromotions: true,
      canViewReports: true,
      createdAt: DateTime(2026, 1, 10),
    ),
    PartnerModel(
      id: 'CP-1001',
      businessName: 'SuperAll Local Channel Partner',
      ownerName: 'Demo Channel Partner',
      phone: '9000000002',
      email: 'channel@example.com',
      type: PartnerType.channelPartner,
      status: PartnerStatus.approved,
      crmStatus: PartnerCrmStatus.active,
      stateId: 'WB',
      districtId: 'JALPAIGURI',
      cityId: 'DHUPGURI',
      zoneIds: const [
        'ZONE-DHUPGURI-003',
      ],
      businessAddress: 'Dhupguri, West Bengal',
      pinCode: '735210',
      commissionPercent: 5.0,
      canManageVendors: true,
      canManageServiceProviders: true,
      canManageDeliveryPartners: true,
      canManageOrders: true,
      canManagePromotions: false,
      canViewReports: true,
      createdAt: DateTime(2026, 2, 15),
    ),
    PartnerModel(
      id: 'FR-1002',
      businessName: 'SuperAll Siliguri Franchise',
      ownerName: 'Demo Franchise Owner 2',
      phone: '9000000003',
      email: 'siliguri@example.com',
      type: PartnerType.franchise,
      status: PartnerStatus.pending,
      crmStatus: PartnerCrmStatus.notCreated,
      stateId: 'WB',
      districtId: 'DARJEELING',
      cityId: 'SILIGURI',
      zoneIds: const [
        'ZONE-SILIGURI-001',
      ],
      businessAddress: 'Siliguri, West Bengal',
      pinCode: '734001',
      commissionPercent: 8.0,
      createdAt: DateTime(2026, 3, 1),
    ),
  ];
}