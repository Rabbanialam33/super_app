import 'package:flutter_test/flutter_test.dart';

import 'package:super_app/core/access/models/partner_access_scope_model.dart';
import 'package:super_app/core/access/models/role_permission_model.dart';
import 'package:super_app/core/access/services/partner_access_scope_service.dart';

void main() {
  const service = PartnerAccessScopeService();

  const superAdminScope = PartnerAccessScopeModel(
    userId: 'USER-001',
    role: AppRole.superAdmin,
    isActive: true,
  );

  const franchiseScope = PartnerAccessScopeModel(
    userId: 'USER-002',
    role: AppRole.franchise,
    partnerId: 'FR-1001',
    franchiseId: 'FR-1001',
    stateId: 'WB',
    districtId: 'JALPAIGURI',
    cityId: 'DHUPGURI',
    zoneIds: [
      'ZONE-DHUPGURI-001',
      'ZONE-DHUPGURI-002',
    ],
    isActive: true,
  );

  const channelPartnerScope = PartnerAccessScopeModel(
    userId: 'USER-003',
    role: AppRole.channelPartner,
    partnerId: 'CP-1001',
    channelPartnerId: 'CP-1001',
    stateId: 'WB',
    districtId: 'JALPAIGURI',
    cityId: 'DHUPGURI',
    zoneIds: [
      'ZONE-DHUPGURI-003',
    ],
    isActive: true,
  );

  const inactiveFranchiseScope = PartnerAccessScopeModel(
    userId: 'USER-004',
    role: AppRole.franchise,
    partnerId: 'FR-1002',
    franchiseId: 'FR-1002',
    zoneIds: [
      'ZONE-SILIGURI-001',
    ],
    isActive: false,
  );

  group('Partner Access Scope Service', () {
    test('Super Admin can access every zone', () {
      expect(
        service.canAccessZone(
          scope: superAdminScope,
          zoneId: 'ZONE-ANY-001',
        ),
        isTrue,
      );
    });

    test('Franchise can access its assigned zone', () {
      expect(
        service.canAccessZone(
          scope: franchiseScope,
          zoneId: 'ZONE-DHUPGURI-001',
        ),
        isTrue,
      );
    });

    test('Franchise cannot access another zone', () {
      expect(
        service.canAccessZone(
          scope: franchiseScope,
          zoneId: 'ZONE-SILIGURI-001',
        ),
        isFalse,
      );
    });

    test('Channel Partner can access its assigned zone', () {
      expect(
        service.canAccessZone(
          scope: channelPartnerScope,
          zoneId: 'ZONE-DHUPGURI-003',
        ),
        isTrue,
      );
    });

    test('Channel Partner cannot access franchise zone', () {
      expect(
        service.canAccessZone(
          scope: channelPartnerScope,
          zoneId: 'ZONE-DHUPGURI-001',
        ),
        isFalse,
      );
    });

    test('Inactive partner cannot access its zone', () {
      expect(
        service.canAccessZone(
          scope: inactiveFranchiseScope,
          zoneId: 'ZONE-SILIGURI-001',
        ),
        isFalse,
      );
    });

    test('Franchise can access its own partner', () {
      expect(
        service.canAccessPartner(
          scope: franchiseScope,
          partnerId: 'FR-1001',
        ),
        isTrue,
      );
    });

    test('Franchise cannot access another partner', () {
      expect(
        service.canAccessPartner(
          scope: franchiseScope,
          partnerId: 'CP-1001',
        ),
        isFalse,
      );
    });

    test('Super Admin can access every partner', () {
      expect(
        service.canAccessPartner(
          scope: superAdminScope,
          partnerId: 'CP-1001',
        ),
        isTrue,
      );
    });

    test('Franchise can manage its assigned zone', () {
      expect(
        service.canManageZone(
          scope: franchiseScope,
          zoneId: 'ZONE-DHUPGURI-002',
        ),
        isTrue,
      );
    });

    test('Franchise cannot manage an unassigned zone', () {
      expect(
        service.canManageZone(
          scope: franchiseScope,
          zoneId: 'ZONE-SILIGURI-001',
        ),
        isFalse,
      );
    });

    test('Franchise can manage orders in its zone', () {
      expect(
        service.canPerform(
          scope: franchiseScope,
          permission: Permission.manageOrders,
          zoneId: 'ZONE-DHUPGURI-001',
        ),
        isTrue,
      );
    });

    test('Franchise cannot manage orders outside its zone', () {
      expect(
        service.canPerform(
          scope: franchiseScope,
          permission: Permission.manageOrders,
          zoneId: 'ZONE-SILIGURI-001',
        ),
        isFalse,
      );
    });

    test('Franchise cannot manage payments', () {
      expect(
        service.canPerform(
          scope: franchiseScope,
          permission: Permission.managePayments,
          zoneId: 'ZONE-DHUPGURI-001',
        ),
        isFalse,
      );
    });

    test('Super Admin can perform any permission in any zone', () {
      expect(
        service.canPerform(
          scope: superAdminScope,
          permission: Permission.managePayments,
          zoneId: 'ZONE-ANY-001',
        ),
        isTrue,
      );
    });
  });
}