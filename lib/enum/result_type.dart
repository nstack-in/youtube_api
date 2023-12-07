import 'package:youtube_api_client/model/channel/youtube_channel.dart';
import 'package:youtube_api_client/model/playlist/youtube_playlist.dart';
import 'package:youtube_api_client/model/video/youtube_video.dart';
import 'package:youtube_api_client/model/youtube_api_result.dart';

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

  static ResultType fromType<T extends ApiResult>() => switch (T) {
        YoutubeVideo => video,
        YoutubeChannel => channel,
        YoutubePlaylist => playlist,
        _ => throw Exception('Invalid type.'),
      };

  String get unencodedPath {
    const base = 'youtube/v3/';
    return switch (this) {
      video => '${base}videos',
      channel => '${base}channels',
      playlist => '${base}playlists',
    };
  }
}
