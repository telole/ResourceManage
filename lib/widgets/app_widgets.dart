import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// A simple rounded content card with consistent padding.
class SectionCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  const SectionCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(18),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }
}

/// Small colored badge, used for league tier / role labels.
class Pill extends StatelessWidget {
  final String text;
  final Color background;
  final Color foreground;

  const Pill({
    super.key,
    required this.text,
    this.background = AppColors.primarySoft,
    this.foreground = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: foreground,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

/// A rounded progress bar with a label + percentage read-out.
class LabeledProgress extends StatelessWidget {
  final String label;
  final double value; // 0..1
  final String trailing;
  final Color color;

  const LabeledProgress({
    super.key,
    required this.label,
    required this.value,
    required this.trailing,
    this.color = AppColors.primary,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 13)),
            Text(trailing, style: const TextStyle(color: AppColors.textPrimary, fontSize: 13, fontWeight: FontWeight.w600)),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: value.clamp(0, 1),
            minHeight: 8,
            backgroundColor: AppColors.primarySoft,
            valueColor: AlwaysStoppedAnimation(color),
          ),
        ),
      ],
    );
  }
}

/// Circular initials avatar, colored from a seed so it's stable per member.
class InitialsAvatar extends StatelessWidget {
  final String name;
  final int colorSeed;
  final double radius;

  const InitialsAvatar({
    super.key,
    required this.name,
    required this.colorSeed,
    this.radius = 20,
  });

  static const _palette = [
    AppColors.primary,
    AppColors.gold,
    Color(0xFF17B26A),
    Color(0xFFEE6C9C),
    Color(0xFF4AA9E0),
    Color(0xFFF2994A),
  ];

  @override
  Widget build(BuildContext context) {
    final initial = name.isNotEmpty ? name[0].toUpperCase() : '?';
    final color = _palette[colorSeed % _palette.length];
    return CircleAvatar(
      radius: radius,
      backgroundColor: color.withOpacity(0.15),
      child: Text(
        initial,
        style: TextStyle(color: color, fontWeight: FontWeight.w700),
      ),
    );
  }
}
