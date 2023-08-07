import 'package:youtube_api/src/model/thumbnails/thumbnail.dart';
import 'package:youtube_api/src/model/thumbnails/thumbnail_resolution.dart';

abstract class Snippet {
  const Snippet({
    this.publishedAt,
    this.title,
    this.description,
    this.thumbnails,
    this.defaultLanguage,
  });

  /// The date and time that the video was published. Note that this time might
  /// be different than the time that the video was uploaded. For example, if a
  /// video is uploaded as a private video and then made public at a later time,
  /// this property will specify the time that the video was made public.
  ///
  /// `datetime`
  ///
  /// There are a couple of special cases:
  ///
  /// *   If a video is uploaded as a private video and the video metadata is
  ///     retrieved by the channel owner, then the property value specifies the
  ///     date and time that the video was uploaded.
  /// *   If a video is uploaded as an unlisted video, the property value also
  ///     specifies the date and time that the video was uploaded. In this case,
  ///     anyone who knows the video's unique video ID can retrieve the video
  ///     metadata.
  ///
  /// The value is specified in [ISO 8601](https://www.w3.org/TR/NOTE-datetime)
  /// format.
  final DateTime? publishedAt;

  /// The video's title. The property value has a maximum length of 100
  /// characters and may contain all valid UTF-8 characters except `<` and `>`.
  /// You must set a value for this property if you call the `videos.update`
  /// method and are updating the `snippet` part of a `video` resource.
  final String? title;

  /// The video's description. The property value has a maximum length of 5000
  /// bytes and may contain all valid UTF-8 characters except `<` and `>`.
  final String? description;

  /// A map of thumbnail images associated with the video. For each object in
  /// the map, the key is the name of the thumbnail image, and the value is an
  /// object that contains other information about the thumbnail.
  final Map<ThumbnailResolution, Thumbnail>? thumbnails;

  /// The language of the text in the `video` resource's `snippet.title` and
  /// `snippet.description` properties.
  final String? defaultLanguage;

  // TODO(hyungtaecf): Implement localized
  //   "localized": {
  //     "title": string,
  //     "description": string
  //   },
}

abstract class ChannelBelongSnippet extends Snippet {
  const ChannelBelongSnippet({
    super.publishedAt,
    super.title,
    super.description,
    super.thumbnails,
    super.defaultLanguage,
    this.channelId,
    this.channelTitle,
  });

  /// The ID that YouTube uses to uniquely identify the channel that the video
  /// was uploaded to.
  final String? channelId;

  /// Channel title for the channel that the video belongs to.
  final String? channelTitle;
}
