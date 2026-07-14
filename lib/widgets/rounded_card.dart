import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Contenitore generico dagli angoli molto arrotondati, usato per
/// sezioni, card del team e card delle terapie.
class RoundedCard extends StatelessWidget {
  const RoundedCard({
    super.key,
    required this.child,
    this.color = AppColors.white,
    this.padding = const EdgeInsets.all(24),
    this.borderRadius = AppRadius.lg,
    this.withShadow = true,
    this.border,
  });

  final Widget child;
  final Color color;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final bool withShadow;
  final Border? border;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
        border: border,
        boxShadow: withShadow
            ? [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.10),
                  blurRadius: 24,
                  offset: const Offset(0, 12),
                ),
              ]
            : null,
      ),
      child: child,
    );
  }
}

/// Pillola/badge tondeggiante, utile per etichette ("Categoria",
/// durata di una terapia, ruolo del team, ecc.)
class RoundedPill extends StatelessWidget {
  const RoundedPill({
    super.key,
    required this.text,
    this.background = AppColors.secondary,
    this.foreground = AppColors.textDark,
    this.icon,
  });

  final String text;
  final Color background;
  final Color foreground;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16, color: foreground),
            const SizedBox(width: 6),
          ],
          Flexible(
            child: Text(
              text,
              softWrap: true,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: foreground,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
