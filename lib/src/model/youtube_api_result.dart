import 'package:enum_to_string/enum_to_string.dart';
import 'package:youtube_api/src/enum/result_type.dart';
import 'package:youtube_api/src/model/channel/youtube_channel.dart';
import 'package:youtube_api/src/model/playlist/youtube_playlist.dart';
import 'package:youtube_api/src/model/snippet.dart';
import 'package:youtube_api/src/model/video/youtube_video.dart';

abstract class ApiResult {
  late String id;

  late final Snippet? snippet;

  static const baseURL = "https://www.youtube.com/";

  ApiResult(data, {bool isSingleResult = false}) {
    id = isSingleResult ? data['id'] : data['id'][data['id'].keys.elementAt(1)];
  }

  factory ApiResult.fromMap(dynamic data, {bool isSpecificKind = false}) {
    final type = EnumToString.fromString(
        ResultType.values,
        ((isSpecificKind ? data['kind'] : data['id']['kind']) as String)
            .split('#')
            .last)!;
    return switch (type) {
      ResultType.video => YoutubeVideo(data, isSingleResult: isSpecificKind),
      ResultType.channel =>
        YoutubeChannel(data, isSingleResult: isSpecificKind),
      ResultType.playlist =>
        YoutubePlaylist(data, isSingleResult: isSpecificKind),
    };
  }

  ResultType get type;

  String get url => getURL(type, id);

  static String getURL(ResultType kind, String id) => switch (kind) {
        ResultType.channel => "${baseURL}channel/$id",
        ResultType.video => "${baseURL}watch?v=$id",
        ResultType.playlist => "${baseURL}playlist?list=$id",
      };
}
