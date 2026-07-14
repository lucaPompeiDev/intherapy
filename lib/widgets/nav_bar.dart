import 'package:flutter/material.dart';
import 'package:intherapy/shared/context_extension.dart';
import '../theme/app_theme.dart';
import 'responsive.dart';

class NavItem {
  const NavItem(this.label, this.icon);
  final String label;
  final IconData icon;
}

const List<NavItem> kNavItems = [
  NavItem('Home', Icons.home_rounded),
  NavItem('Team', Icons.groups_rounded),
  NavItem('Terapie', Icons.spa_rounded),
];

/// Barra di navigazione in alto: su desktop/tablet mostra le voci
/// come pillole orizzontali; su mobile mostra logo + pulsante menu
/// che apre il Drawer (gestito dallo Scaffold nella shell principale).
class TopNavBar extends StatelessWidget implements PreferredSizeWidget {
  const TopNavBar({
    super.key,
    required this.currentIndex,
    required this.onSelect,
  });

  final int currentIndex;
  final ValueChanged<int> onSelect;

  @override
  Size get preferredSize => const Size.fromHeight(88);

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    final hPad = pageHorizontalPadding(context);

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(hPad, 14, hPad, 8),
        child: Row(
          children: [
            // Expanded: il logo prende lo spazio disponibile e spinge il menu
            // a destra, permettendo al nome studio di andare a capo se serve.
            const Expanded(child: _Logo()),
            const SizedBox(width: 12),
            if (!mobile)
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: AppColors.secondarySoft,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(kNavItems.length, (i) {
                    final item = kNavItems[i];
                    final selected = i == currentIndex;
                    return _NavPill(
                      item: item,
                      selected: selected,
                      onTap: () => onSelect(i),
                    );
                  }),
                ),
              )
            else
              Builder(
                builder: (context) => IconButton(
                  onPressed: () => Scaffold.of(context).openEndDrawer(),
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                    padding: const EdgeInsets.all(12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                  icon: const Icon(Icons.menu_rounded),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: const Icon(Icons.spa_rounded, color: AppColors.white, size: 22),
        ),
        const SizedBox(width: 12),
        // Flexible + maxLines: il nome può andare a capo su 2 righe
        // invece di traboccare orizzontalmente.
        Flexible(
          child: Text(
            context.l10n.studioNameExtended,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontSize: mobile ? 15 : 18, height: 1.15),
          ),
        ),
      ],
    );
  }
}

class _NavPill extends StatelessWidget {
  const _NavPill({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final NavItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              item.icon,
              size: 18,
              color: selected ? AppColors.white : AppColors.primary,
            ),
            const SizedBox(width: 8),
            Text(
              item.label,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: selected ? AppColors.white : AppColors.textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Drawer per la navigazione mobile, con le stesse voci del menu.
class AppEndDrawer extends StatelessWidget {
  const AppEndDrawer({
    super.key,
    required this.currentIndex,
    required this.onSelect,
  });

  final int currentIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(left: Radius.circular(32)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _Logo(),
              const SizedBox(height: 32),
              ...List.generate(kNavItems.length, (i) {
                final item = kNavItems[i];
                final selected = i == currentIndex;
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Material(
                    color: selected ? AppColors.primary : AppColors.secondarySoft,
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      onTap: () {
                        Navigator.of(context).pop();
                        onSelect(i);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              item.icon,
                              color: selected ? AppColors.white : AppColors.primary,
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Text(
                                item.label,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: selected
                                      ? AppColors.white
                                      : AppColors.textDark,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
