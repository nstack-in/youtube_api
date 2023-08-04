import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:youtube_api/src/model/options.dart';
import 'package:youtube_api/src/model/search_options.dart';
import 'package:youtube_api/src/model/video.dart';
import 'package:youtube_api/src/model/video_options.dart';
import 'package:youtube_api/src/model/youtube_video.dart';
import 'package:youtube_api/src/util/get_duration.dart';

export 'package:youtube_api/src/enum/category.dart';
export 'package:youtube_api/src/enum/result_type.dart';
export 'package:youtube_api/src/model/thumbnails.dart';
export 'package:youtube_api/src/model/youtube_video.dart';
export 'package:youtube_api/src/model/options.dart';
export 'package:youtube_api/src/model/search_options.dart';
export 'package:youtube_api/src/model/video_options.dart';

class YoutubeAPI {
  late SearchOptions searchOptions;
  VideoOptions? videoOptions;
  String key;
  String? nextPageToken;
  String? prevPageToken;
  static const baseURL = 'www.googleapis.com';
  static const searchUnencodedPath = "youtube/v3/search";
  int page = 0;
  final headers = {"Accept": "application/json"};
  YoutubeAPI(
    this.key, {
    int maxResults = 10,
  }) {
    searchOptions = SearchOptions(maxResults: maxResults);
  }

  Future<List<YoutubeApiResult>> getTrends({
    required String regionCode,
  }) async {
    final url = _getTrendingVideosUri(regionCode: regionCode);
    final res = await http.get(url, headers: headers);
    final jsonData = json.decode(res.body);
    if (jsonData['error'] != null) {
      throw jsonData['error']['message'];
    }
    if (jsonData['pageInfo']['totalResults'] == null)
      return <YoutubeApiResult>[];
    return _getResults(jsonData, onlyVideos: true, newPage: 1);
  }

  Future<List<YoutubeApiResult>> search(
    String query, {
    SearchOptions options = const SearchOptions(
      type: ResultType.values,
      order: Order.relevance,
      videoDuration: VideoDuration.any,
    ),
  }) async {
    searchOptions = options.copyWith(query: query);
    final url = _getSearchUri(options: searchOptions);
    var res = await http.get(url, headers: headers);
    var jsonData = json.decode(res.body);
    if (jsonData['error'] != null) {
      throw jsonData['error']['message'];
    }
    if (jsonData['pageInfo']['totalResults'] == null)
      return <YoutubeApiResult>[];
    return _getResults(jsonData, newPage: 1);
  }

  Future<List<YoutubeApiResult>> channel(String channelId,
      {Order? order}) async {
    final url = _getSearchInChannelUri(channelId, order);
    var res = await http.get(url, headers: headers);
    var jsonData = json.decode(res.body);
    if (jsonData['error'] != null) {
      throw jsonData['error']['message'];
    }
    if (jsonData['pageInfo']['totalResults'] == null)
      return <YoutubeApiResult>[];
    return _getResults(jsonData, newPage: 1);
  }

  /// Get results by ID
  Future<List<T>> searchById<T extends YoutubeApiResult>(
      List<String> ids) async {
    final url = _getVideoUri(ids, part: DataPart.snippet);
    var res = await http.get(url, headers: headers);
    var jsonData = json.decode(res.body);
    if (jsonData['error'] != null) {
      throw jsonData['error']['message'];
    }
    if (jsonData['pageInfo']['totalResults'] == null) return <T>[];
    final result = List.castFrom<YoutubeApiResult, T>(
        await _getResults(jsonData, onlyVideos: true, newPage: 1));
    return result;
  }

  /// Get video details from video Id
  Future<List<VideoDetails>> getVideoDetails(List<String> videoId) async {
    List<VideoDetails> result = [];
    final url = _getVideoUri(videoId);
    var res = await http.get(url, headers: headers);
    var jsonData = json.decode(res.body);

    if (jsonData == null) return [];

    int total = jsonData['pageInfo']['totalResults'] <
            jsonData['pageInfo']['resultsPerPage']
        ? jsonData['pageInfo']['totalResults']
        : jsonData['pageInfo']['resultsPerPage'];

    for (int i = 0; i < total; i++) {
      result.add(new VideoDetails(jsonData['items'][i]));
    }
    return result;
  }

  Future<List<YoutubeApiResult>> _getResults(dynamic data,
      {bool onlyVideos = false, int? newPage}) async {
    if (newPage != null) page = newPage;
    if (data['pageInfo']['totalResults'] == null) return [];

    if (data == null) return <YoutubeApiResult>[];

    nextPageToken = data['nextPageToken'];
    prevPageToken = data['prevPageToken'];
    int total =
        data['pageInfo']['totalResults'] < data['pageInfo']['resultsPerPage']
            ? data['pageInfo']['totalResults']
            : data['pageInfo']['resultsPerPage'];

    final result = <YoutubeApiResult>[];
    for (int i = 0; i < total; i++) {
      YoutubeApiResult ytApiObj =
          YoutubeApiResult.fromMap(data['items'][i], onlyVideos: onlyVideos);
      result.add(ytApiObj);
    }
    final videoIdList =
        result.whereType<YouTubeVideo>().map((e) => e.id).toList();

    final videoList = await getVideoDetails(videoIdList);
    for (final ytVideo in videoList) {
      final ytAPIObj =
          result.firstWhere((ytAPI) => ytAPI.id == ytVideo.id) as YouTubeVideo;
      ytAPIObj.duration = getDuration(ytVideo.duration ?? "");
    }
    return result;
  }

  Future<List<YoutubeApiResult>?> prevPage(
      {bool isTrendingVideos = false}) async {
    if (prevPageToken == null) return null;
    final url = _getPrevPageUri(onlyVideos: isTrendingVideos);
    var res = await http.get(url, headers: headers);
    var jsonData = json.decode(res.body);

    return _getResults(jsonData,
        onlyVideos: isTrendingVideos, newPage: page - 1);
  }

  Future<List<YoutubeApiResult>?> nextPage(
      {bool isTrendingVideos = false}) async {
    if (nextPageToken == null) return null;
    final url = _getNextPageUri(onlyVideos: isTrendingVideos);
    var res = await http.get(url, headers: headers);
    var jsonData = json.decode(res.body);
    return _getResults(jsonData,
        onlyVideos: isTrendingVideos, newPage: page + 1);
  }

  int get getPage => page;

  Uri _getTrendingVideosUri({required String regionCode}) {
    final options = _getTrendingOption(regionCode).getMap(key);
    Uri url = Uri.https(baseURL, ResultType.video.unencodedPath, options);
    return url;
  }

  Uri _getVideoUri(List<String> videoIds, {DataPart? part}) {
    videoOptions = VideoOptions(
      part: part ?? DataPart.contentDetails,
      id: videoIds,
      maxResults: videoIds.length,
    );
    Uri url = Uri.https(
        baseURL, ResultType.video.unencodedPath, videoOptions!.getMap(key));
    return url;
  }

  Uri _getSearchInChannelUri(String channelId, Order? order) {
    searchOptions = SearchOptions(
      channelId: channelId,
      order: order ?? Order.date,
      maxResults: searchOptions.maxResults,
    );
    return Uri.https(baseURL, searchUnencodedPath, searchOptions.getMap(key));
  }

  Uri _getSearchUri({required SearchOptions options}) =>
      Uri.https(baseURL, searchUnencodedPath, options.getMap(key));

  ///  For Getting Getting Previous Page
  Uri _getPrevPageUri({bool onlyVideos = false}) {
    Uri url;
    if (onlyVideos) {
      videoOptions = _getTrendingPageOption(prevPageToken!);
      url = Uri.https(
          baseURL, ResultType.video.unencodedPath, videoOptions!.getMap(key));
    } else {
      searchOptions = SearchOptions(
        query: searchOptions.query,
        pageToken: prevPageToken!,
        channelId: searchOptions.channelId,
        maxResults: searchOptions.maxResults,
      );
      url = Uri.https(baseURL, searchUnencodedPath, searchOptions.getMap(key));
    }
    return url;
  }

  ///  For Getting Getting Next Page
  Uri _getNextPageUri({bool onlyVideos = false}) {
    Uri url;
    if (onlyVideos) {
      videoOptions = _getTrendingPageOption(nextPageToken!);
      url = Uri.https(
          baseURL, ResultType.video.unencodedPath, videoOptions!.getMap(key));
    } else {
      searchOptions = SearchOptions(
        query: searchOptions.query,
        pageToken: nextPageToken!,
        channelId: searchOptions.channelId,
        maxResults: searchOptions.maxResults,
      );
      url = Uri.https(baseURL, searchUnencodedPath, searchOptions.getMap(key));
    }
    return url;
  }

  VideoOptions _getTrendingOption(String regionCode) => VideoOptions(
        part: DataPart.snippet,
        chart: Chart.mostPopular,
        maxResults: searchOptions.maxResults,
        regionCode: regionCode,
      );

  VideoOptions _getTrendingPageOption(String token) => VideoOptions(
        chart: Chart.mostPopular,
        maxResults: searchOptions.maxResults,
        regionCode: searchOptions.regionCode,
        pageToken: token,
      );
}
