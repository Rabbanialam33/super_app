import 'package:super_app/core/partners/models/partner_model.dart';
import 'package:super_app/core/partners/repository/partner_repository.dart';

class PartnerService {
  final PartnerRepository _repository;

  const PartnerService({
    this._repository = const PartnerRepository(),
  });

  Future<List<PartnerModel>> getAllPartners() async {
    return _repository.getAllPartners();
  }

  Future<PartnerModel?> getPartnerById(
    String partnerId,
  ) async {
    return _repository.getPartnerById(partnerId);
  }

  Future<List<PartnerModel>> getFranchises() async {
    return _repository.getPartnersByType(
      PartnerType.franchise,
    );
  }

  Future<List<PartnerModel>> getChannelPartners() async {
    return _repository.getPartnersByType(
      PartnerType.channelPartner,
    );
  }

  Future<List<PartnerModel>> getActivePartners() async {
    return _repository.getActivePartners();
  }

  Future<List<PartnerModel>> getPartnersByZone(
    String zoneId,
  ) async {
    return _repository.getPartnersByZone(zoneId);
  }

  Future<List<PartnerModel>> getPartnersByStatus(
    PartnerStatus status,
  ) async {
    return _repository.getPartnersByStatus(status);
  }

  Future<List<PartnerModel>> getApprovedPartners() async {
    return _repository.getPartnersByStatus(
      PartnerStatus.approved,
    );
  }

  Future<List<PartnerModel>> getPendingPartners() async {
    return _repository.getPartnersByStatus(
      PartnerStatus.pending,
    );
  }

  Future<bool> partnerExists(String partnerId) async {
    return _repository.partnerExists(partnerId);
  }

  Future<bool> hasZoneAccess(
    String partnerId,
    String zoneId,
  ) async {
    final partner = await getPartnerById(partnerId);

    if (partner == null || !partner.isActive) {
      return false;
    }

    return partner.hasZoneAccess(zoneId);
  }

  Future<bool> canManageArea(
    String partnerId,
    String zoneId,
  ) async {
    final partner = await getPartnerById(partnerId);

    if (partner == null) {
      return false;
    }

    return partner.canManageArea(zoneId);
  }
}