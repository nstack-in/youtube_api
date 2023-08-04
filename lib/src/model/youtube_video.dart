import 'package:enum_to_string/enum_to_string.dart';
import 'package:youtube_api/src/enum/result_type.dart';
import 'package:youtube_api/src/model/thumbnails.dart';
import 'package:youtube_api/src/enum/category.dart';

abstract class YoutubeApiResult {
  late Thumbnails thumbnail;
  late ResultType kind;
  late String id;
  String? publishedAt;
  String? description;
  late String url;
  late List<String> tags;
  late String title;
  late String channelId;
  String? channelUrl;
  late String channelTitle;

  static const baseURL = "https://www.youtube.com/";

  YoutubeApiResult(data, {bool isSingleResult = false}) {
    id = isSingleResult ? data['id'] : data['id'][data['id'].keys.elementAt(1)];
    thumbnail = Thumbnails.fromMap(data['snippet']['thumbnails']);
    tags = List<String>.from(data['snippet']['tags'] ?? []);
    url = getURL(ResultType.fromType(this.runtimeType), id);
    publishedAt = data['snippet']['publishedAt'];
    description = data['snippet']['description'];
    title = data['snippet']['title'];
    channelId = data['snippet']['channelId'];
    channelUrl = YoutubeApiResult.getURL(ResultType.channel, channelId);
    channelTitle = data['snippet']['channelTitle'];
  }

  factory YoutubeApiResult.fromMap(dynamic data, {bool onlyVideos = false}) {
    ResultType kind;
    if (onlyVideos) {
      kind = ResultType.video;
    } else {
      kind = EnumToString.fromString(
          ResultType.values, data['id']['kind'].substring(8))!;
    }
    switch (kind) {
      case ResultType.video:
        return YouTubeVideo(data, isSingleResult: onlyVideos);
      case ResultType.channel:
        return YouTubeChannel(data, isSingleResult: onlyVideos);
      case ResultType.playlist:
        return YouTubePlaylist(data, isSingleResult: onlyVideos);
    }
  }

  static String getURL(ResultType kind, String id) {
    switch (kind) {
      case ResultType.channel:
        return "${baseURL}channel/$id";
      case ResultType.video:
        return "${baseURL}watch?v=$id";
      case ResultType.playlist:
        return "${baseURL}playlist?list=$id";
    }
  }
}

class YouTubeVideo extends YoutubeApiResult {
  YouTubeVideo(data, {bool isSingleResult = false})
      : super(data, isSingleResult: isSingleResult) {
    kind = ResultType.video;
    category = Category.fromCategoryId(
        int.tryParse(data['snippet']['categoryId'] ?? "") ?? -1);
  }
  Duration? duration;
  Category? category;

  String getURL() => YoutubeApiResult.getURL(ResultType.video, id);
}

class YouTubeChannel extends YoutubeApiResult {
  YouTubeChannel(data, {bool isSingleResult = false})
      : super(data, isSingleResult: isSingleResult) {
    kind = ResultType.channel;
  }
}

class YouTubePlaylist extends YoutubeApiResult {
  YouTubePlaylist(data, {bool isSingleResult = false})
      : super(data, isSingleResult: isSingleResult) {
    kind = ResultType.playlist;
  }
}
