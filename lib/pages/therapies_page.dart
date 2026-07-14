import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/responsive.dart';
import '../widgets/rounded_photo.dart';
import '../widgets/rounded_card.dart';

class Therapy {
  const Therapy(this.title, this.description, this.duration, this.seed, this.icon);
  final String title;
  final String description;
  final String duration;
  final String seed;
  final IconData icon;
}

const List<Therapy> kTherapies = [
  Therapy(
    'Massaggio Rilassante',
    'Un trattamento dolce per sciogliere le tensioni muscolari e ritrovare calma.',
    '50 min',
    'therapy1',
    Icons.spa_rounded,
  ),
  Therapy(
    'Terapia Cognitivo-Comportamentale',
    'Percorso individuale per affrontare ansia, stress e pensieri disfunzionali.',
    '60 min',
    'therapy2',
    Icons.psychology_rounded,
  ),
  Therapy(
    'Riabilitazione Posturale',
    'Esercizi mirati per correggere la postura e prevenire dolori cronici.',
    '45 min',
    'therapy3',
    Icons.accessibility_new_rounded,
  ),
  Therapy(
    'Consulenza Nutrizionale',
    'Piani alimentari personalizzati per il tuo equilibrio psicofisico.',
    '40 min',
    'therapy4',
    Icons.eco_rounded,
  ),
  Therapy(
    'Mindfulness e Meditazione',
    'Tecniche guidate per allenare la presenza mentale e ridurre lo stress.',
    '30 min',
    'therapy5',
    Icons.self_improvement_rounded,
  ),
  Therapy(
    'Osteopatia',
    'Trattamento manuale dolce per il riequilibrio del sistema corporeo.',
    '55 min',
    'therapy6',
    Icons.healing_rounded,
  ),
];

class TherapiesPage extends StatelessWidget {
  const TherapiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final hPad = pageHorizontalPadding(context);
    final columns = gridColumns(context);

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RoundedPill(text: 'Le nostre Terapie', icon: Icons.spa_rounded),
          const SizedBox(height: 18),
          Text(
            'Percorsi pensati per te',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Text(
              'Dal corpo alla mente: una gamma di trattamenti per ogni '
              'esigenza, sempre guidati da mani esperte.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: 40),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: kTherapies.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              mainAxisSpacing: 28,
              crossAxisSpacing: 28,
              // Le card terapia hanno immagine + titolo + descrizione + durata,
              // quindi servono celle più alte del team per far stare tutto.
              childAspectRatio: cardAspectRatio(columns, single: 0.92),
            ),
            itemBuilder: (context, i) => _TherapyCard(therapy: kTherapies[i]),
          ),
        ],
      ),
    );
  }
}

class _TherapyCard extends StatelessWidget {
  const _TherapyCard({required this.therapy});
  final Therapy therapy;

  @override
  Widget build(BuildContext context) {
    return RoundedCard(
      color: AppColors.white,
      borderRadius: AppRadius.lg,
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          RoundedPhoto(
            imageUrl: 'https://picsum.photos/seed/${therapy.seed}/400/300',
            aspectRatio: 4 / 3,
            borderRadius: AppRadius.md,
            borderColor: AppColors.secondary,
            borderWidth: 4,
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Icon(therapy.icon, color: AppColors.white, size: 18),
              ),
              const SizedBox(width: 10),
              // Il titolo può andare su 2 righe senza traboccare.
              Expanded(
                child: Text(
                  therapy.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontSize: 16, height: 1.15),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Text(
              therapy.description,
              overflow: TextOverflow.ellipsis,
              maxLines: 5,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontSize: 13),
            ),
          ),
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: RoundedPill(
              text: therapy.duration,
              icon: Icons.schedule_rounded,
            ),
          ),
        ],
      ),
    );
  }
}
