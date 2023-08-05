import 'package:youtube_api/src/model/snippet.dart';
import 'package:youtube_api/src/model/thumbnails/thumbnail.dart';

class ChannelSnippet extends Snippet {
  ChannelSnippet({
    super.publishedAt,
    super.title,
    super.description,
    super.thumbnails,
    super.defaultLanguage,
    this.customUrl,
    this.country,
  });

  factory ChannelSnippet.fromJsonData(Map<String, dynamic> data) {
    final thumbnails = Thumbnail.thumbnailsFromMap(data['thumbnails']);
    final publishedAt = DateTime.tryParse(data['publishedAt']);
    final description = data['description'];
    final title = data['title'];
    final customUrl = data['customUrl'];
    final country = data['country'];

    return ChannelSnippet(
      thumbnails: thumbnails,
      publishedAt: publishedAt,
      description: description,
      title: title,
      customUrl: customUrl,
      country: country,
    );
  }

  /// The channel's custom URL. The [YouTube Help
  /// Center](https://support.google.com/youtube/answer/2657968) explains
  /// eligibility requirements for getting a custom URL as well as how to set up
  /// the URL.
  final String? customUrl;

  /// The country with which the channel is associated. To set this property's
  /// value, update the value of the `brandingSettings.channel.country`
  /// property.
  final String? country;
}
