import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/mock_data.dart';
import '../models/models.dart';
import '../providers/app_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/app_widgets.dart';

class ResourceInputScreen extends StatefulWidget {
  const ResourceInputScreen({super.key});

  @override
  State<ResourceInputScreen> createState() => _ResourceInputScreenState();
}

class _ResourceInputScreenState extends State<ResourceInputScreen> {
  final Map<ResourceType, int> _draft = {for (final t in ResourceType.values) t: 0};

  @override
  Widget build(BuildContext context) {
    final app = context.watch<AppProvider>();

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Input Resource', style: Theme.of(context).textTheme.headlineSmall),
                Text('${app.tournament.name} 🍪', style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
              itemCount: ResourceType.values.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final type = ResourceType.values[index];
                final pointsEach = app.tournament.pointsPerUnit[type] ?? 0;
                return SectionCard(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    children: [
                      Text(type.emoji, style: const TextStyle(fontSize: 22)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(type.label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                            Text('$pointsEach poin / unit', style: const TextStyle(color: AppColors.textSecondary, fontSize: 11)),
                          ],
                        ),
                      ),
                      _Stepper(
                        value: _draft[type] ?? 0,
                        onChanged: (v) => setState(() => _draft[type] = v),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: _draft.values.every((v) => v == 0) ? null : _save,
                child: const Text('Simpan ke grup'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _save() {
    final app = context.read<AppProvider>();
    _draft.forEach((type, amount) {
      if (amount > 0) app.addEntry(currentMemberId, type, amount);
    });
    setState(() {
      for (final t in ResourceType.values) {
        _draft[t] = 0;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Resource tersimpan ✅')),
    );
  }
}

class _Stepper extends StatelessWidget {
  final int value;
  final ValueChanged<int> onChanged;

  const _Stepper({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _RoundIconButton(icon: Icons.remove, onTap: value > 0 ? () => onChanged(value - 1) : null),
        SizedBox(
          width: 28,
          child: Text('$value', textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w700)),
        ),
        _RoundIconButton(icon: Icons.add, onTap: () => onChanged(value + 1)),
      ],
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _RoundIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        width: 30,
        height: 30,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: enabled ? AppColors.primarySoft : AppColors.background,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 16, color: enabled ? AppColors.primary : AppColors.textSecondary),
      ),
    );
  }
}
