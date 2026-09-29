import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/app_widgets.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final ranked = app.leaderboard;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        children: [
          Text('Leaderboard', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 4),
          Text('Ranking kontribusi poin — ${app.tournament.name}', style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
          const SizedBox(height: 16),
          SectionCard(
            child: LabeledProgress(
              label: 'Progress menuju target liga',
              value: app.progressToTarget,
              trailing: '${(app.progressToTarget * 100).toStringAsFixed(0)}%',
              color: AppColors.success,
            ),
          ),
          const SizedBox(height: 20),
          ...List.generate(ranked.length, (i) {
            final m = ranked[i];
            final points = app.pointsForMember(m.id);
            final percent = app.percentOfGroup(m.id);
            final isTop3 = i < 3;
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SectionCard(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(
                  children: [
                    SizedBox(
                      width: 28,
                      child: Text(
                        '${i + 1}',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                          color: isTop3 ? AppColors.gold : AppColors.textSecondary,
                        ),
                      ),
                    ),
                    InitialsAvatar(name: m.name, colorSeed: m.colorSeed, radius: 18),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(m.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                          const SizedBox(height: 4),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(999),
                            child: LinearProgressIndicator(
                              value: (percent / 100).clamp(0, 1),
                              minHeight: 5,
                              backgroundColor: AppColors.primarySoft,
                              valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('$points pts', style: const TextStyle(fontWeight: FontWeight.w700)),
                        Text('${percent.toStringAsFixed(1)}%', style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
