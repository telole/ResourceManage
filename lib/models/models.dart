enum ResourceType {
  gold,
  gems,
  suitcase,
  tailorSpin,
  cookie,
  carpenterCommon,
  carpenterRare,
  carpenterGold,
}

extension ResourceTypeInfo on ResourceType {
  String get label {
    switch (this) {
      case ResourceType.gold:
        return 'Gold';
      case ResourceType.gems:
        return 'Gems';
      case ResourceType.suitcase:
        return 'Suitcase';
      case ResourceType.tailorSpin:
        return 'Tailor of Fortune';
      case ResourceType.cookie:
        return 'Cookie';
      case ResourceType.carpenterCommon:
        return 'Carpenter (Common)';
      case ResourceType.carpenterRare:
        return 'Carpenter (Rare)';
      case ResourceType.carpenterGold:
        return 'Carpenter (Gold)';
    }
  }

  String get emoji {
    switch (this) {
      case ResourceType.gold:
        return '🪙';
      case ResourceType.gems:
        return '💎';
      case ResourceType.suitcase:
        return '🧳';
      case ResourceType.tailorSpin:
        return '🎡';
      case ResourceType.cookie:
        return '🍪';
      case ResourceType.carpenterCommon:
        return '🪵';
      case ResourceType.carpenterRare:
        return '🟣';
      case ResourceType.carpenterGold:
        return '🏆';
    }
  }
}

class Member {
  final String id;
  final String name;
  final String role; // 'leader', 'admin', 'member'
  final int colorSeed;

  Member({
    required this.id,
    required this.name,
    required this.role,
    required this.colorSeed,
  });
}

class ResourceEntry {
  final String memberId;
  final ResourceType type;
  final int amount;
  final DateTime timestamp;

  ResourceEntry({
    required this.memberId,
    required this.type,
    required this.amount,
    required this.timestamp,
  });
}

class Tournament {
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final Map<ResourceType, int> pointsPerUnit;
  final int targetPoints;

  Tournament({
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.pointsPerUnit,
    required this.targetPoints,
  });

  Duration get timeLeft => endDate.difference(DateTime.now());
}

class GroupInfo {
  final String name;
  final String code;
  final String league;
  final List<Member> members;

  GroupInfo({
    required this.name,
    required this.code,
    required this.league,
    required this.members,
  });
}
