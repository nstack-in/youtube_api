import 'dart:convert';

import 'package:youtube_api_client/model/thumbnails/thumbnail_resolution.dart';

class Thumbnail {
  Thumbnail({
    required this.url,
    required this.width,
    required this.height,
  });

  factory Thumbnail.fromMap(Map<String, dynamic> map) {
    return Thumbnail(
      url: map['url'],
      width: map['width'],
      height: map['height'],
    );
  }

  /// The image's URL.
  final String? url;

  /// The image's width.
  final int? width;

  /// The image's height.
  final int? height;

  Map<String, dynamic> toMap() => {
        'url': url,
        'width': width,
        'height': height,
      };

  static Map<ThumbnailResolution, Thumbnail> thumbnailsFromMap(
      Map<String, dynamic> map) {
    final default_ = map['default'];
    final medium = map['medium'];
    final high = map['high'];
    final standard = map['standard'];
    final maxres = map['maxres'];
    return {
      if (default_ != null)
        ThumbnailResolution.default_: Thumbnail.fromMap(default_),
      if (medium != null) ThumbnailResolution.medium: Thumbnail.fromMap(medium),
      if (high != null) ThumbnailResolution.high: Thumbnail.fromMap(high),
      if (standard != null)
        ThumbnailResolution.standard: Thumbnail.fromMap(standard),
      if (maxres != null) ThumbnailResolution.maxres: Thumbnail.fromMap(maxres),
    };
  }

  String toJson() => json.encode(toMap());

  factory Thumbnail.fromJson(String source) =>
      Thumbnail.fromMap(json.decode(source));
}
