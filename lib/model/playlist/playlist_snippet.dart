import 'package:youtube_api_client/model/snippet.dart';
import 'package:youtube_api_client/model/thumbnails/thumbnail.dart';

class PlaylistSnippet extends ChannelBelongSnippet {
  const PlaylistSnippet({
    super.publishedAt,
    super.title,
    super.description,
    super.thumbnails,
    super.defaultLanguage,
    super.channelId,
    super.channelTitle,
  });
  factory PlaylistSnippet.fromJsonData(Map<String, dynamic> data) {
    final thumbnails = Thumbnail.thumbnailsFromMap(data['thumbnails']);
    final publishedAt = DateTime.tryParse(data['publishedAt']);
    final description = data['description'];
    final title = data['title'];

    return PlaylistSnippet(
      thumbnails: thumbnails,
      publishedAt: publishedAt,
      description: description,
      title: title,
    );
  }
}
