import 'dart:async';
import 'dart:convert';
import 'package:collection/collection.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_api/src/model/video.dart';
import 'package:youtube_api/src/model/youtube_video.dart';
export 'package:youtube_api/src/model/youtube_video.dart';
import 'package:youtube_api/src/util/_api.dart';
import 'package:youtube_api/src/util/get_duration.dart';

class YoutubeAPI {
  String? type;
  String? query;
  String? prevPageToken;
  String? nextPageToken;
  int maxResults;
  ApiHelper? api;
  int page = 0;
  String? regionCode;
  bool? getTrending;
  final headers = {"Accept": "application/json"};
  YoutubeAPI(
    String key, {
    this.type,
    this.maxResults = 10,
  }) {
    this.type = type;
    this.maxResults = maxResults;
    api = ApiHelper(key: key, maxResults: this.maxResults, type: this.type);
  }

  Future<List<YouTubeVideo>> getTrends({
    required String regionCode,
  }) async {
    this.regionCode = regionCode;
    this.getTrending = true;
    final url = api!.trendingUri(regionCode: regionCode);
    final res = await http.get(url, headers: headers);
    final jsonData = json.decode(res.body);
    if (jsonData['error'] != null) {
      throw jsonData['error']['message'];
    }
    if (jsonData['pageInfo']['totalResults'] == null) return <YouTubeVideo>[];
    final result = await _getResultFromJson(jsonData);
    return result;
  }

  Future<List<YouTubeVideo>> search(
    String query, {
    String type = 'video,channel,playlist',
    String order = 'relevance',
    String videoDuration = 'any',
    String? regionCode,
  }) async {
    this.getTrending = false;
    this.query = query;
    final url = api!.searchUri(
      query,
      type: type,
      videoDuration: videoDuration,
      order: order,
      regionCode: regionCode,
    );
    var res = await http.get(url, headers: headers);
    var jsonData = json.decode(res.body);
    if (jsonData['error'] != null) {
      throw jsonData['error']['message'];
    }
    if (jsonData['pageInfo']['totalResults'] == null) return <YouTubeVideo>[];
    List<YouTubeVideo> result = await _getResultFromJson(jsonData);
    return result;
  }

  Future<List<YouTubeVideo>> channel(String channelId, {String? order}) async {
    this.getTrending = false;
    final url = api!.channelUri(channelId, order);
    var res = await http.get(url, headers: headers);
    var jsonData = json.decode(res.body);
    if (jsonData['error'] != null) {
      throw jsonData['error']['message'];
    }
    if (jsonData['pageInfo']['totalResults'] == null) return <YouTubeVideo>[];
    List<YouTubeVideo> result = await _getResultFromJson(jsonData);
    return result;
  }

  /*
   Get YouTubeVideos from video Id
    */
  Future<List<YouTubeVideo>> videosById(List<String> videoIds) async {
    this.getTrending = true;
    final url = api!.videoUri(videoIds);
    var res = await http.get(url, headers: headers);
    var jsonData = json.decode(res.body);
    if (jsonData['error'] != null) {
      throw jsonData['error']['message'];
    }
    if (jsonData['pageInfo']['totalResults'] == null) return <YouTubeVideo>[];
    List<YouTubeVideo> result = await _getResultFromJson(jsonData);
    return result;
  }

  /*
  Get video details from video Id
   */
  Future<List<Video>> video(List<String> videoId) async {
    List<Video> result = [];
    final url = api!.videoUri(videoId);
    var res = await http.get(url, headers: headers);
    var jsonData = json.decode(res.body);

    if (jsonData == null) return [];

    int total = jsonData['pageInfo']['totalResults'] <
            jsonData['pageInfo']['resultsPerPage']
        ? jsonData['pageInfo']['totalResults']
        : jsonData['pageInfo']['resultsPerPage'];

    for (int i = 0; i < total; i++) {
      result.add(new Video(jsonData['items'][i]));
    }
    return result;
  }

  Future<List<YouTubeVideo>> _getResultFromJson(jsonData) async {
    List<YouTubeVideo>? result = [];
    if (jsonData == null) return [];
    nextPageToken = jsonData['nextPageToken'];
    api!.setNextPageToken(nextPageToken!);
    int total = jsonData['pageInfo']['totalResults'] <
            jsonData['pageInfo']['resultsPerPage']
        ? jsonData['pageInfo']['totalResults']
        : jsonData['pageInfo']['resultsPerPage'];
    result = await _getListOfYTAPIs(jsonData, total);
    page = 1;
    return result ?? [];
  }

  Future<List<YouTubeVideo>?> _getListOfYTAPIs(dynamic data, int total) async {
    List<YouTubeVideo> result = [];
    List<String> videoIdList = [];
    for (int i = 0; i < total; i++) {
      YouTubeVideo ytApiObj =
          new YouTubeVideo(data['items'][i], getTrendingVideo: getTrending!);
      if (ytApiObj.kind == "video") videoIdList.add(ytApiObj.id!);
      result.add(ytApiObj);
    }
    List<Video> videoList = await video(videoIdList);
    await Future.forEach(videoList, (Video ytVideo) {
      YouTubeVideo? ytAPIObj =
          result.firstWhereOrNull((ytAPI) => ytAPI.id == ytVideo.id);
      ytAPIObj?.duration = getDuration(ytVideo.duration ?? "") ?? "";
    });
    return result;
  }

  Future<List<YouTubeVideo>> nextPage() async {
    this.getTrending = false;
    if (api!.nextPageToken == null) return [];
    List<YouTubeVideo>? result = [];
    final url = api!.nextPageUri(this.getTrending!);
    var res = await http.get(url, headers: headers);
    var jsonData = json.decode(res.body);

    if (jsonData['pageInfo']['totalResults'] == null) return <YouTubeVideo>[];

    if (jsonData == null) return <YouTubeVideo>[];

    nextPageToken = jsonData['nextPageToken'];
    prevPageToken = jsonData['prevPageToken'];
    api!.setNextPageToken(nextPageToken!);
    api!.setPrevPageToken(prevPageToken!);
    int total = jsonData['pageInfo']['totalResults'] <
            jsonData['pageInfo']['resultsPerPage']
        ? jsonData['pageInfo']['totalResults']
        : jsonData['pageInfo']['resultsPerPage'];
    result = await _getListOfYTAPIs(jsonData, total);
    page++;
    if (total == 0) {
      return <YouTubeVideo>[];
    }
    return result ?? [];
  }

  Future<List<YouTubeVideo>?> prevPage() async {
    if (api!.prevPageToken == null) return null;
    List<YouTubeVideo> result = [];
    final url = api!.prevPageUri(this.getTrending!);
    var res = await http.get(url, headers: headers);
    var jsonData = json.decode(res.body);

    if (jsonData['pageInfo']['totalResults'] == null) return <YouTubeVideo>[];

    if (jsonData == null) return <YouTubeVideo>[];

    nextPageToken = jsonData['nextPageToken'];
    prevPageToken = jsonData['prevPageToken'];
    api!.setNextPageToken(nextPageToken!);
    api!.setPrevPageToken(prevPageToken!);
    int total = jsonData['pageInfo']['totalResults'] <
            jsonData['pageInfo']['resultsPerPage']
        ? jsonData['pageInfo']['totalResults']
        : jsonData['pageInfo']['resultsPerPage'];
    result = await _getListOfYTAPIs(jsonData, total) ?? [];
    if (total == 0) {
      return <YouTubeVideo>[];
    }
    page--;
    return result;
  }

  int get getPage => page;

  set setMaxResults(int maxResults) => this.maxResults = maxResults;

  get getMaxResults => this.maxResults;

  set setKey(String key) => api!.key = key;

  set setQuery(String query) => api!.query = query;

  String? get getQuery => api!.query;

  set setType(String type) => api!.type = type;

  String? get getType => api!.type;
}
