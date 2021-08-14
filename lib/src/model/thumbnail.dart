import 'dart:convert';

class Thumbnail {
  final String? url;
  final int? width;
  final int? height;
  Thumbnail({
    required this.url,
    required this.width,
    required this.height,
  });

  Map<String, dynamic> toMap() {
    return {
      'url': url,
      'width': width,
      'height': height,
    };
  }

  factory Thumbnail.fromMap(Map<String, dynamic> map) {
    return Thumbnail(
      url: map['url'],
      width: map['width'],
      height: map['height'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Thumbnail.fromJson(String source) => Thumbnail.fromMap(json.decode(source));
}
