import 'dart:ui';

import 'package:youtube_api_client/enum/result_type.dart';

enum ThumbnailResolution {
  /// The default thumbnail image. The default thumbnail for a video – or a
  /// resource that refers to a video, such as a playlist item or search result
  /// – is 120px wide and 90px tall. The default thumbnail for a channel is 88px
  /// wide and 88px tall.
  default_,

  /// A higher resolution version of the thumbnail image. For a video (or a
  /// resource that refers to a video), this image is 320px wide and 180px tall.
  /// For a channel, this image is 240px wide and 240px tall.
  medium,

  /// A high resolution version of the thumbnail image. For a video (or a
  /// resource that refers to a video), this image is 480px wide and 360px tall.
  /// For a channel, this image is 800px wide and 800px tall.
  high,

  /// An even higher resolution version of the thumbnail image than the high
  /// resolution image. This image is available for some videos and other
  /// resources that refer to videos, like playlist items or search results.
  /// This image is 640px wide and 480px tall.
  standard,

  /// The highest resolution version of the thumbnail image. This image size is
  /// available for some videos and other resources that refer to videos, like
  /// playlist items or search results. This image is 1280px wide and 720px
  /// tall.
  maxres;

  Set<ThumbnailResolution> validValuesFor(ResultType type) => switch (type) {
        ResultType.video || ResultType.playlist => values.toSet(),
        ResultType.channel => {default_, medium, high},
      };

  /// Resolution size in pixels.
  Size getSizeFor(ResultType type) => switch (this) {
        default_ => switch (type) {
            ResultType.channel => Size.square(88),
            _ => Size(120, 90),
          },
        medium => switch (type) {
            ResultType.channel => Size.square(240),
            _ => Size(320, 180),
          },
        high => switch (type) {
            ResultType.channel => Size.square(800),
            _ => Size(480, 360),
          },
        standard => Size(640, 480),
        maxres => Size(1280, 720),
      };
}
