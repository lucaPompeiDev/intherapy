import 'package:flutter/material.dart';
import 'package:intherapy/widgets/instagram_showcase.dart';
import '../theme/app_theme.dart';
import '../widgets/responsive.dart';
import '../widgets/rounded_photo.dart';
import '../widgets/rounded_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.onNavigate});

  /// Callback per navigare ad un'altra voce di menu (es. dai bottoni CTA).
  final ValueChanged<int> onNavigate;

  @override
  Widget build(BuildContext context) {
    final mobile = isMobile(context);
    final hPad = pageHorizontalPadding(context);

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _HeroSection(mobile: mobile, onNavigate: onNavigate),
          const SizedBox(height: 64),
          _AboutStrip(mobile: mobile),
          const SizedBox(height: 64),
          _PreviewSection(
            mobile: mobile,
            title: 'Il nostro Team',
            subtitle:
                'Professionisti qualificati ed empatici, pronti ad accompagnarti nel tuo percorso di benessere.',
            buttonLabel: 'Scopri il team',
            onPressed: () => onNavigate(1),
          ),
          const SizedBox(height: 40),
          _PreviewSection(
            mobile: mobile,
            title: 'Le nostre Terapie',
            subtitle:
                'Percorsi personalizzati, dal rilassamento profondo al supporto psicologico specialistico.',
            buttonLabel: 'Vedi le terapie',
            onPressed: () => onNavigate(2),
          ),
          const SizedBox(height: 64),
          const InstagramShowcase(),
          const SizedBox(height: 48),
        ],
      ),
    );
  }
}

class _HeroSection extends StatelessWidget {
  const _HeroSection({required this.mobile, required this.onNavigate});
  final bool mobile;
  final ValueChanged<int> onNavigate;

  @override
  Widget build(BuildContext context) {
    final textCol = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment:
          mobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        RoundedPill(
            text: 'Benessere • Ascolto • Cura', icon: Icons.favorite_rounded),
        const SizedBox(height: 20),
        Text(
          'Prenditi cura di te,\nun passo alla volta',
          textAlign: mobile ? TextAlign.center : TextAlign.left,
          // Font ridotto su mobile per non traboccare su schermi stretti.
          style: Theme.of(context)
              .textTheme
              .displaySmall
              ?.copyWith(fontSize: mobile ? 30 : 40),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: mobile ? null : 480,
          child: Text(
            'Uno studio dedicato al tuo equilibrio psicofisico: '
            'terapie su misura, in un ambiente accogliente e professionale.',
            textAlign: mobile ? TextAlign.center : TextAlign.left,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
        const SizedBox(height: 28),
        Wrap(
          alignment: mobile ? WrapAlignment.center : WrapAlignment.start,
          spacing: 16,
          runSpacing: 16,
          children: [
            ElevatedButton(
              onPressed: () => onNavigate(2),
              child: const Text('Scopri le terapie'),
            ),
            OutlinedButton(
              onPressed: () => onNavigate(1),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.primary, width: 2),
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
              ),
              child: const Text('Conosci il team'),
            ),
          ],
        ),
      ],
    );

    final photo = RoundedPhoto(
      imageUrl: 'https://picsum.photos/seed/serenastudio/700/700',
      aspectRatio: 1,
      borderRadius: AppRadius.xl,
      borderColor: AppColors.secondary,
    );

    if (mobile) {
      return Column(
        children: [
          SizedBox(width: 260, child: photo),
          const SizedBox(height: 32),
          textCol,
        ],
      );
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(flex: 6, child: textCol),
        const SizedBox(width: 48),
        Expanded(
          flex: 5,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),
            child: photo,
          ),
        ),
      ],
    );
  }
}

class _AboutStrip extends StatelessWidget {
  const _AboutStrip({required this.mobile});
  final bool mobile;

  @override
  Widget build(BuildContext context) {
    final items = const [
      (Icons.verified_rounded, 'Professionisti certificati'),
      (Icons.self_improvement_rounded, 'Percorsi personalizzati'),
      (Icons.meeting_room_rounded, 'Ambiente accogliente'),
    ];

    return RoundedCard(
      color: AppColors.secondarySoft,
      borderRadius: AppRadius.lg,
      padding: const EdgeInsets.all(28),
      // Su mobile impila in verticale SENZA Expanded (che in un flex verticale
      // dentro uno scroll darebbe "unbounded height"); su desktop usa Expanded
      // per distribuire le tre colonne in modo equo.
      child: mobile
          ? Column(
              children: [
                for (final item in items)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: _AboutItem(icon: item.$1, label: item.$2),
                  ),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final item in items)
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: _AboutItem(icon: item.$1, label: item.$2),
                    ),
                  ),
              ],
            ),
    );
  }
}

class _AboutItem extends StatelessWidget {
  const _AboutItem({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Icon(icon, color: AppColors.white),
        ),
        const SizedBox(height: 12),
        Text(
          label,
          textAlign: TextAlign.center,
          style:
              Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 16),
        ),
      ],
    );
  }
}

class _PreviewSection extends StatelessWidget {
  const _PreviewSection({
    required this.mobile,
    required this.title,
    required this.subtitle,
    required this.buttonLabel,
    required this.onPressed,
  });

  final bool mobile;
  final String title;
  final String subtitle;
  final String buttonLabel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final textCol = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment:
          mobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: mobile ? TextAlign.center : TextAlign.left,
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(color: AppColors.white),
        ),
        const SizedBox(height: 10),
        Text(
          subtitle,
          textAlign: mobile ? TextAlign.center : TextAlign.left,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: AppColors.white.withOpacity(0.9)),
        ),
      ],
    );

    final button = ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.secondary,
        foregroundColor: AppColors.textDark,
      ),
      child: Text(buttonLabel),
    );

    return RoundedCard(
      color: AppColors.primary,
      borderRadius: AppRadius.lg,
      padding: const EdgeInsets.all(36),
      // Niente Expanded in verticale: su mobile impiliamo testo e bottone.
      child: mobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                textCol,
                const SizedBox(height: 20),
                button,
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: textCol),
                const SizedBox(width: 24),
                button,
              ],
            ),
    );
  }
}
