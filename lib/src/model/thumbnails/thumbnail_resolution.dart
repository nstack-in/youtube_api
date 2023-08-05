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
  maxres,
}
