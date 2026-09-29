import '../models/models.dart';

final List<Member> mockMembers = [
  Member(id: 'u1', name: 'Rani', role: 'leader', colorSeed: 0),
  Member(id: 'u2', name: 'Dimas', role: 'admin', colorSeed: 1),
  Member(id: 'u3', name: 'Sasa', role: 'member', colorSeed: 2),
  Member(id: 'u4', name: 'Bagas', role: 'member', colorSeed: 3),
  Member(id: 'u5', name: 'Nadia', role: 'member', colorSeed: 4),
  Member(id: 'u6', name: 'Reza', role: 'member', colorSeed: 5),
];

final GroupInfo mockGroup = GroupInfo(
  name: 'Purple Squad',
  code: 'PRPL29',
  league: 'Emerald II',
  members: mockMembers,
);

final Tournament mockTournament = Tournament(
  name: 'Cookie Wars',
  startDate: DateTime.now().subtract(const Duration(days: 2)),
  endDate: DateTime.now().add(const Duration(days: 1, hours: 6)),
  pointsPerUnit: {
    ResourceType.cookie: 10,
    ResourceType.gold: 1,
    ResourceType.gems: 5,
    ResourceType.suitcase: 15,
    ResourceType.tailorSpin: 8,
    ResourceType.carpenterCommon: 6,
    ResourceType.carpenterRare: 20,
    ResourceType.carpenterGold: 40,
  },
  targetPoints: 5000,
);

final List<ResourceEntry> mockEntries = [
  ResourceEntry(memberId: 'u1', type: ResourceType.cookie, amount: 3, timestamp: DateTime.now()),
  ResourceEntry(memberId: 'u1', type: ResourceType.suitcase, amount: 4, timestamp: DateTime.now()),
  ResourceEntry(memberId: 'u2', type: ResourceType.cookie, amount: 3, timestamp: DateTime.now()),
  ResourceEntry(memberId: 'u2', type: ResourceType.gold, amount: 120, timestamp: DateTime.now()),
  ResourceEntry(memberId: 'u3', type: ResourceType.tailorSpin, amount: 10, timestamp: DateTime.now()),
  ResourceEntry(memberId: 'u4', type: ResourceType.carpenterRare, amount: 2, timestamp: DateTime.now()),
  ResourceEntry(memberId: 'u5', type: ResourceType.cookie, amount: 2, timestamp: DateTime.now()),
  ResourceEntry(memberId: 'u6', type: ResourceType.carpenterGold, amount: 1, timestamp: DateTime.now()),
];

/// The signed-in user for this starter (swap for real auth later).
const String currentMemberId = 'u1';
