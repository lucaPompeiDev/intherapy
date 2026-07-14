import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/responsive.dart';
import '../widgets/rounded_photo.dart';
import '../widgets/rounded_card.dart';

class TeamMember {
  const TeamMember(this.name, this.role, this.bio, this.seed);
  final String name;
  final String role;
  final String bio;
  final String seed;
}

const List<TeamMember> kTeam = [
  TeamMember(
    'Dott.ssa Elena Bianchi',
    'Psicoterapeuta',
    'Specializzata in terapia cognitivo-comportamentale e gestione dello stress.',
    'team1',
  ),
  TeamMember(
    'Dott. Marco Rossi',
    'Fisioterapista',
    'Esperto in riabilitazione posturale e trattamenti manuali.',
    'team2',
  ),
  TeamMember(
    'Dott.ssa Giulia Verdi',
    'Nutrizionista',
    'Percorsi alimentari su misura per il benessere psicofisico.',
    'team3',
  ),
  TeamMember(
    'Dott. Luca Ferrari',
    'Osteopata',
    'Trattamenti dolci per il riequilibrio del sistema muscolo-scheletrico.',
    'team4',
  ),
];

class TeamPage extends StatelessWidget {
  const TeamPage({super.key});

  @override
  Widget build(BuildContext context) {
    final hPad = pageHorizontalPadding(context);
    final columns = gridColumns(context);

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: hPad, vertical: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RoundedPill(text: 'Il nostro Team', icon: Icons.groups_rounded),
          const SizedBox(height: 18),
          Text(
            'Persone prima che professionisti',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 12),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Text(
              'Un gruppo affiatato di specialisti che condivide un unico '
              'obiettivo: il tuo benessere, con ascolto e competenza.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: 40),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: kTeam.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              mainAxisSpacing: 28,
              crossAxisSpacing: 28,
              // Celle più alte quando le colonne (e quindi le celle) si
              // restringono, così la bio ha spazio per andare su più righe.
              childAspectRatio: cardAspectRatio(columns, single: 1.05),
            ),
            itemBuilder: (context, i) => _TeamCard(member: kTeam[i]),
          ),
        ],
      ),
    );
  }
}

class _TeamCard extends StatelessWidget {
  const _TeamCard({required this.member});
  final TeamMember member;

  @override
  Widget build(BuildContext context) {
    return RoundedCard(
      color: AppColors.white,
      borderRadius: AppRadius.lg,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          RoundedPhoto(
            imageUrl: 'https://picsum.photos/seed/${member.seed}/300/300',
            circle: true,
            size: 120,
            borderColor: AppColors.secondary,
            borderWidth: 5,
          ),
          const SizedBox(height: 16),
          Text(
            member.name,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style:
                Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 17),
          ),
          const SizedBox(height: 6),
          RoundedPill(
            text: member.role,
            background: AppColors.primary,
            foreground: AppColors.white,
          ),
          const SizedBox(height: 10),
          // Expanded qui è corretto: la cella della griglia ha altezza
          // limitata, quindi la bio riempie lo spazio residuo e va a capo.
          Expanded(
            child: Text(
              member.bio,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 5,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
