import 'package:flutter/material.dart';
import 'package:intherapy/shared/context_extension.dart';
import 'theme/app_theme.dart';
import 'widgets/nav_bar.dart';
import 'widgets/responsive.dart';
import 'pages/home_page.dart';
import 'pages/team_page.dart';
import 'pages/therapies_page.dart';

/// Scaffold radice: contiene la navbar in alto, il body con la pagina
/// selezionata e un footer. Mantiene la stessa struttura su tutte le
/// dimensioni di schermo, cambiando solo il layout interno di ogni pagina.
class RootShell extends StatefulWidget {
  const RootShell({super.key});

  @override
  State<RootShell> createState() => _RootShellState();
}

class _RootShellState extends State<RootShell> {
  int _index = 0;

  void _select(int i) => setState(() => _index = i);

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(onNavigate: _select),
      const TeamPage(),
      const TherapiesPage(),
    ];

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: TopNavBar(currentIndex: _index, onSelect: _select),
      endDrawer: isMobile(context)
          ? AppEndDrawer(currentIndex: _index, onSelect: _select)
          : null,
      body: Column(
        children: [
          Expanded(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 250),
              child: KeyedSubtree(
                key: ValueKey(_index),
                child: pages[_index],
              ),
            ),
          ),
          const _Footer(),
        ],
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    final hPad = pageHorizontalPadding(context);

    final brand = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.spa_rounded, color: AppColors.white),
        const SizedBox(width: 10),
        // Flexible: il nome studio può andare a capo invece di traboccare.
        Flexible(
          child: Text(
            context.l10n.studioNameExtended,
            textAlign: mobile ? TextAlign.center : TextAlign.start,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: AppColors.white, fontSize: 16, height: 1.2),
          ),
        ),
      ],
    );

    final copyright = Text(
      context.l10n.copyrightText,
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .bodyMedium
          ?.copyWith(color: AppColors.white.withOpacity(0.85), fontSize: 13),
    );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 28),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppRadius.xl)),
      ),
      child: mobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                brand,
                const SizedBox(height: 16),
                copyright,
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(child: brand),
                const SizedBox(width: 24),
                Flexible(child: copyright),
              ],
            ),
    );
  }
}
