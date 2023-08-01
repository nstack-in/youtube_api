import 'package:enum_to_string/enum_to_string.dart';
import 'package:youtube_api/src/model/thumbnails.dart';
import 'package:youtube_api/src/enum/category.dart';

abstract class YoutubeApiResult {
  late Thumbnails thumbnail;
  late YoutubeApiResultKind kind;
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
    url = getURL(YoutubeApiResultKind.fromType(this.runtimeType), id);
    publishedAt = data['snippet']['publishedAt'];
    description = data['snippet']['description'];
    title = data['snippet']['title'];
    channelId = data['snippet']['channelId'];
    channelUrl =
        YoutubeApiResult.getURL(YoutubeApiResultKind.channel, channelId);
    channelTitle = data['snippet']['channelTitle'];
  }

  factory YoutubeApiResult.fromMap(dynamic data,
      {bool isSingleResult = false}) {
    YoutubeApiResultKind kind;
    if (isSingleResult) {
      kind = YoutubeApiResultKind.video;
    } else {
      kind = EnumToString.fromString(
          YoutubeApiResultKind.values, data['id']['kind'].substring(8))!;
    }
    switch (kind) {
      case YoutubeApiResultKind.video:
        return YouTubeVideo(data, isSingleResult: isSingleResult);
      case YoutubeApiResultKind.channel:
        return YouTubeChannel(data, isSingleResult: isSingleResult);
      case YoutubeApiResultKind.playlist:
        return YouTubePlaylist(data, isSingleResult: isSingleResult);
    }
  }

  static String getURL(YoutubeApiResultKind kind, String id) {
    switch (kind) {
      case YoutubeApiResultKind.channel:
        return "${baseURL}channel/$id";
      case YoutubeApiResultKind.video:
        return "${baseURL}watch?v=$id";
      case YoutubeApiResultKind.playlist:
        return "${baseURL}playlist?list=$id";
    }
  }
}

class YouTubeVideo extends YoutubeApiResult {
  YouTubeVideo(data, {bool isSingleResult = false})
      : super(data, isSingleResult: isSingleResult) {
    kind = YoutubeApiResultKind.video;
    category = Category.fromCategoryId(
        int.tryParse(data['snippet']['categoryId'] ?? "") ?? -1);
  }
  Duration? duration;
  Category? category;

  String getURL() => YoutubeApiResult.getURL(YoutubeApiResultKind.video, id);
}

class YouTubeChannel extends YoutubeApiResult {
  YouTubeChannel(data, {bool isSingleResult = false})
      : super(data, isSingleResult: isSingleResult) {
    kind = YoutubeApiResultKind.channel;
  }
}

class YouTubePlaylist extends YoutubeApiResult {
  YouTubePlaylist(data, {bool isSingleResult = false})
      : super(data, isSingleResult: isSingleResult) {
    kind = YoutubeApiResultKind.playlist;
  }
}

enum YoutubeApiResultKind {
  video,
  channel,
  playlist;

  static YoutubeApiResultKind fromType(Type type) {
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
}
