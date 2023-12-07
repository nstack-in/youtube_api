import 'package:youtube_api_client/enum/category.dart';
import 'package:youtube_api_client/enum/result_type.dart';
import 'package:youtube_api_client/enum/video/live_broadcast_content.dart';
import 'package:youtube_api_client/model/snippet.dart';
import 'package:youtube_api_client/model/thumbnails/thumbnail.dart';
import 'package:youtube_api_client/model/youtube_api_result.dart';

class VideoSnippet extends ChannelBelongSnippet {
  const VideoSnippet({
    super.publishedAt,
    super.channelId,
    super.title,
    super.description,
    super.thumbnails,
    super.channelTitle,
    this.tags,
    this.category,
    this.liveBroadcastContent,
    super.defaultLanguage,
    this.defaultAudioLanguage,
  });

  factory VideoSnippet.fromJsonData(Map<String, dynamic> data) {
    final thumbnails = Thumbnail.thumbnailsFromMap(data['thumbnails']);
    final tags = List<String>.from(data['tags'] ?? []);
    final publishedAt = DateTime.tryParse(data['publishedAt']);
    final description = data['description'];
    final title = data['title'];
    final channelId = data['channelId'];
    final channelTitle = data['channelTitle'];
    final category =
        Category.fromCategoryId(int.tryParse(data['categoryId'] ?? "") ?? -1);

    return VideoSnippet(
      thumbnails: thumbnails,
      tags: tags,
      publishedAt: publishedAt,
      description: description,
      title: title,
      channelId: channelId,
      channelTitle: channelTitle,
      category: category,
    );
  }

  /// A list of keyword tags associated with the video. Tags may contain spaces.
  /// The property value has a maximum length of 500 characters. Note the
  /// following rules regarding the way the character limit is calculated:
  ///
  /// `list`
  ///
  /// *   The property value is a list, and commas between items in the list
  ///     count toward the limit.
  /// *   If a tag contains a space, the API server handles the tag value as
  ///     though it were wrapped in quotation marks, and the quotation marks
  ///     count toward the character limit. So, for the purposes of character
  ///     limits, the tag **Foo-Baz** contains seven characters, but the tag
  ///     **Foo Baz** contains nine characters.
  final List<String>? tags;

  /// The YouTube video category associated with the video. You must set a value
  /// for this property if you call the `videos.update` method and are updating
  /// the `snippet` part of a `video` resource.
  ///
  /// `string`
  final Category? category;

  /// Indicates if the video is an upcoming/active live broadcast. Or it's
  /// "none" if the video is not an upcoming/active live broadcast.
  final LiveBroadcastContent? liveBroadcastContent;

  /// The `default_audio_language` property specifies the language spoken in the
  /// video's default audio track.
  final String? defaultAudioLanguage;

  String? get channelUrl => channelId == null
      ? null
      : ApiResult.getURL(ResultType.channel, channelId!);
}
