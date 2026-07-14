import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../widgets/responsive.dart';
import '../widgets/rounded_photo.dart';
import '../widgets/rounded_card.dart';
import '../services/instagram_post.dart';
import '../services/instagram_service.dart';

/// Sezione "Seguici su Instagram": carica i post reali dal Worker
/// e li mostra con lo stesso stile tondeggiante/palette del resto del sito.
///
/// Sostituisci [workerBaseUrl] con l'URL del tuo Worker deployato
/// (vedi instagram-worker/README.md).
class InstagramShowcase extends StatefulWidget {
  const InstagramShowcase({
    super.key,
    this.workerBaseUrl =
        'https://instagram-showcase-worker.instagram-showcase-worker-intherapy.workers.dev',
    this.instagramProfileUrl = 'https://www.instagram.com/luco.nazionale',
  });

  final String workerBaseUrl;
  final String instagramProfileUrl;

  @override
  State<InstagramShowcase> createState() => _InstagramShowcaseState();
}

class _InstagramShowcaseState extends State<InstagramShowcase> {
  late final InstagramService _service;
  late Future<List<InstagramPost>> _postsFuture;

  @override
  void initState() {
    super.initState();
    _service = InstagramService(workerBaseUrl: widget.workerBaseUrl);
    _postsFuture = _service.fetchRecentPosts();
  }

  Future<void> _retry() async {
    setState(() {
      _postsFuture = _service.fetchRecentPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final columns = gridColumns(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        RoundedPill(text: 'Seguici su Instagram', icon: Icons.camera_alt_rounded),
        const SizedBox(height: 18),
        Text(
          'I nostri ultimi post',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 28),
        FutureBuilder<List<InstagramPost>>(
          future: _postsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 40),
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            }

            if (snapshot.hasError || !snapshot.hasData) {
              return _ErrorState(onRetry: _retry);
            }

            final posts = snapshot.data!;
            if (posts.isEmpty) {
              return const Text('Nessun post disponibile al momento.');
            }

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: posts.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, i) => _InstagramPostCard(post: posts[i]),
            );
          },
        ),
        const SizedBox(height: 28),
        OutlinedButton.icon(
          onPressed: () => launchUrl(Uri.parse(widget.instagramProfileUrl)),
          icon: const Icon(Icons.open_in_new_rounded, size: 18),
          label: const Text('Vai al profilo Instagram'),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primary,
            side: const BorderSide(color: AppColors.primary, width: 2),
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
          ),
        ),
      ],
    );
  }
}

class _InstagramPostCard extends StatelessWidget {
  const _InstagramPostCard({required this.post});
  final InstagramPost post;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadius.md),
      onTap: () => launchUrl(Uri.parse(post.permalink)),
      child: RoundedPhoto(
        imageUrl: post.mediaUrl,
        aspectRatio: 1,
        borderRadius: AppRadius.md,
        borderColor: AppColors.secondary,
        borderWidth: 4,
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.onRetry});
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return RoundedCard(
      color: AppColors.secondarySoft,
      borderRadius: AppRadius.md,
      padding: const EdgeInsets.all(28),
      withShadow: false,
      child: Column(
        children: [
          const Icon(Icons.wifi_off_rounded, color: AppColors.primary, size: 32),
          const SizedBox(height: 12),
          Text(
            'Non riusciamo a caricare il feed Instagram in questo momento.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: onRetry, child: const Text('Riprova')),
        ],
      ),
    );
  }
}
