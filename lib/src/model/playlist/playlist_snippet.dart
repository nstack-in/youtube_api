import 'package:youtube_api/src/model/snippet.dart';
import 'package:youtube_api/src/model/thumbnails/thumbnail.dart';

class PlaylistSnippet extends ChannelBelongSnippet {
  PlaylistSnippet({
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
