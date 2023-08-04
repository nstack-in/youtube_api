import 'package:youtube_api/youtube_api.dart';

/// The `type` parameter restricts a search query to only retrieve a
/// particular type of resource. The value is a comma-separated list of
/// resource types. The default value is `video,channel,playlist`.
///
/// `string`
///
/// Acceptable values are:
///
/// *   `channel`
/// *   `playlist`
/// *   `video`
enum ResultType {
  video,
  channel,
  playlist;

  static ResultType fromType(Type type) {
    switch (type) {
      case YouTubeVideo:
        return video;
      case YouTubeChannel:
        return channel;
      case YouTubePlaylist:
        return playlist;
      default:
        throw Exception('Invalid type.');
    }
  }

  String get unencodedPath {
    const base = 'youtube/v3/';
    switch (this) {
      case video:
        return '${base}videos';
      case channel:
        return '${base}channels';
      case playlist:
        return '${base}playlists';
    }
  }
}
