import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/mock_data.dart';
import '../models/models.dart';
import '../providers/app_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/app_widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final myPoints = app.pointsForMember(currentMemberId);
    final myPercent = app.percentOfGroup(currentMemberId);
    final myResources = app.resourcesFor(currentMemberId);
    final hoursLeft = app.tournament.timeLeft.inHours.clamp(0, 999);

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Halo, Rani 👋', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                  Text(app.group.name, style: Theme.of(context).textTheme.headlineSmall),
                ],
              ),
              Pill(text: app.group.league),
            ],
          ),
          const SizedBox(height: 20),
          SectionCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('🍪 ${app.tournament.name}', style: Theme.of(context).textTheme.titleMedium),
                    Text('$hoursLeft jam lagi', style: const TextStyle(color: AppColors.gold, fontWeight: FontWeight.w600, fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 16),
                LabeledProgress(
                  label: 'Total poin grup',
                  value: app.progressToTarget,
                  trailing: '${app.totalGroupPoints} / ${app.tournament.targetPoints}',
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.primarySoft,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      const InitialsAvatar(name: 'Rani', colorSeed: 0),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Kontribusimu: $myPoints poin', style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                            Text('${myPercent.toStringAsFixed(1)}% dari total grup', style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text('Resource kamu', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 2.4,
            children: ResourceType.values.map((type) {
              return SectionCard(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    Text(type.emoji, style: const TextStyle(fontSize: 22)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${myResources[type] ?? 0}', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                          Text(type.label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 11), overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
