/// Rappresenta un singolo post Instagram così come restituito
/// dal nostro Worker (già normalizzato: vedi instagram-worker/src/index.js).
class InstagramPost {
  const InstagramPost({
    required this.id,
    required this.caption,
    required this.mediaType,
    required this.mediaUrl,
    required this.permalink,
    required this.timestamp,
  });

  final String id;
  final String caption;
  final String mediaType; // IMAGE | VIDEO | CAROUSEL_ALBUM
  final String mediaUrl;
  final String permalink;
  final String timestamp;

  factory InstagramPost.fromJson(Map<String, dynamic> json) {
    return InstagramPost(
      id: json['id'] as String? ?? '',
      caption: json['caption'] as String? ?? '',
      mediaType: json['mediaType'] as String? ?? 'IMAGE',
      mediaUrl: json['mediaUrl'] as String? ?? '',
      permalink: json['permalink'] as String? ?? '',
      timestamp: json['timestamp'] as String? ?? '',
    );
  }
}
