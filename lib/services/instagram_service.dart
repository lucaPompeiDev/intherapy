import 'dart:convert';
import 'package:http/http.dart' as http;
import 'instagram_post.dart';

/// Client per il nostro Cloudflare Worker (vedi cartella instagram-worker/).
/// Non contiene alcun token: il Worker fa da proxy verso la Graph API,
/// il token resta sempre lato server.
class InstagramService {
  InstagramService({required this.workerBaseUrl});

  /// Es. https://instagram-showcase-worker.<tuo-account>.workers.dev
  final String workerBaseUrl;

  Future<List<InstagramPost>> fetchRecentPosts() async {
    final uri = Uri.parse('$workerBaseUrl/instagram-feed');
    final response = await http.get(uri);

    final statusCode = response.statusCode;
    if (response.statusCode != 200) {
      throw Exception(
        'Impossibile caricare il feed Instagram (status ${response.statusCode})',
      );
    }

    final decoded = jsonDecode(response.body) as Map<String, dynamic>;

    if (decoded['error'] != null) {
      throw Exception(decoded['error'] as String);
    }

    final rawPosts = decoded['posts'] as List<dynamic>? ?? [];
    return rawPosts
        .map((p) => InstagramPost.fromJson(p as Map<String, dynamic>))
        .toList();
  }
}
