import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Immagine con bordi tondeggianti e cornice colorata coordinata,
/// come richiesto: "foto in accordo con lo stesso bordo".
///
/// [imageUrl] può essere un URL di rete oppure, se [assetPath] è
/// fornito, verrà usata un'immagine locale da asset.
class RoundedPhoto extends StatelessWidget {
  const RoundedPhoto({
    super.key,
    required this.imageUrl,
    this.assetPath,
    this.size,
    this.aspectRatio,
    this.borderRadius = AppRadius.lg,
    this.borderColor = AppColors.secondary,
    this.borderWidth = 6,
    this.circle = false,
  });

  final String imageUrl;
  final String? assetPath;
  final double? size;
  final double? aspectRatio;
  final double borderRadius;
  final Color borderColor;
  final double borderWidth;
  final bool circle;

  @override
  Widget build(BuildContext context) {
    final radius = circle ? 999.0 : borderRadius;

    final image = assetPath != null
        ? Image.asset(assetPath!, fit: BoxFit.cover)
        : Image.network(
            imageUrl,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return Container(
                color: AppColors.secondarySoft,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(
                  color: AppColors.primary,
                  strokeWidth: 2,
                ),
              );
            },
            errorBuilder: (context, error, stack) => Container(
              color: AppColors.secondarySoft,
              alignment: Alignment.center,
              child: const Icon(
                Icons.image_rounded,
                color: AppColors.primary,
                size: 40,
              ),
            ),
          );

    Widget content = ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: image,
    );

    if (aspectRatio != null) {
      content = AspectRatio(aspectRatio: aspectRatio!, child: content);
    }

    Widget framed = Container(
      padding: EdgeInsets.all(borderWidth),
      decoration: BoxDecoration(
        color: borderColor,
        borderRadius: BorderRadius.circular(radius + borderWidth),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: content,
    );

    if (size != null) {
      framed = SizedBox(width: size, height: size, child: framed);
    }

    return framed;
  }
}
