import 'package:flutter/foundation.dart';
import '../data/mock_data.dart';
import '../models/models.dart';

class AppProvider extends ChangeNotifier {
  GroupInfo group = mockGroup;
  Tournament tournament = mockTournament;
  final List<ResourceEntry> _entries = List.of(mockEntries);

  List<ResourceEntry> get entries => List.unmodifiable(_entries);

  void addEntry(String memberId, ResourceType type, int amount) {
    if (amount <= 0) return;
    _entries.add(
      ResourceEntry(
        memberId: memberId,
        type: type,
        amount: amount,
        timestamp: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  /// Total resource units a member has logged, per type.
  Map<ResourceType, int> resourcesFor(String memberId) {
    final map = <ResourceType, int>{for (final t in ResourceType.values) t: 0};
    for (final e in _entries.where((e) => e.memberId == memberId)) {
      map[e.type] = (map[e.type] ?? 0) + e.amount;
    }
    return map;
  }

  /// Points a single entry is worth under the active tournament formula.
  int _pointsFor(ResourceEntry e) =>
      e.amount * (tournament.pointsPerUnit[e.type] ?? 0);

  int pointsForMember(String memberId) => _entries
      .where((e) => e.memberId == memberId)
      .fold(0, (sum, e) => sum + _pointsFor(e));

  int get totalGroupPoints =>
      _entries.fold(0, (sum, e) => sum + _pointsFor(e));

  double percentOfGroup(String memberId) {
    final total = totalGroupPoints;
    if (total == 0) return 0;
    return pointsForMember(memberId) / total * 100;
  }

  double get progressToTarget =>
      (totalGroupPoints / tournament.targetPoints).clamp(0, 1).toDouble();

  /// Members ranked highest points first.
  List<Member> get leaderboard {
    final sorted = List<Member>.from(group.members);
    sorted.sort((a, b) => pointsForMember(b.id).compareTo(pointsForMember(a.id)));
    return sorted;
  }
}
