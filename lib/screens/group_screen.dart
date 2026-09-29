import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/app_widgets.dart';

class GroupScreen extends StatelessWidget {
  const GroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();
    final group = app.group;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        children: [
          Text('Group', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 16),
          SectionCard(
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(group.name, style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 4),
                      Text('${group.members.length}/40 anggota', style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('Kode gabung', style: TextStyle(color: AppColors.textSecondary, fontSize: 11)),
                    Text(group.code, style: const TextStyle(fontWeight: FontWeight.w700, letterSpacing: 2, color: AppColors.primary)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text('Anggota', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          ...group.members.map((m) {
            final points = app.pointsForMember(m.id);
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SectionCard(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    InitialsAvatar(name: m.name, colorSeed: m.colorSeed),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(m.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                          const SizedBox(height: 2),
                          Pill(
                            text: m.role,
                            background: m.role == 'leader' ? AppColors.gold.withOpacity(0.15) : AppColors.primarySoft,
                            foreground: m.role == 'leader' ? AppColors.gold : AppColors.primary,
                          ),
                        ],
                      ),
                    ),
                    Text('$points pts', style: const TextStyle(fontWeight: FontWeight.w700)),
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
