import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_api/_api.dart';
import 'package:youtube_api/yt_video.dart';

export 'package:youtube_api/yt_video.dart';

class YoutubeAPI {
  String type;
  String query;
  String prevPageToken;
  String nextPageToken;
  int maxResults;
  API api;
  int page;
  String regionCode;
  bool getTrending;

  YoutubeAPI(key, {String type, int maxResults: 10}) {
    page = 0;
    this.type = type;
    this.maxResults = maxResults;
    api = new API(key: key, maxResults: this.maxResults, type: this.type);
  }

  Future<List<YT_API>> getTrends({@required String regionCode}) async {
    this.regionCode = regionCode;
    this.getTrending = true;
    Uri url = api.trendingUri(regionCode: this.regionCode);
    var res = await http.get(url, headers: {"Accept": "application/json"});
    var jsonData = json.decode(res.body);
    if (jsonData['error'] != null) {
      throw jsonData['error']['message'];
    }
    if (jsonData['pageInfo']['totalResults'] == null) return <YT_API>[];
    List<YT_API> result = await _getResultFromJson(jsonData);
    return result;
  }

  Future<List<YT_API>> search(String query, {String type}) async {
    this.getTrending = false;
    this.query = query;
    Uri url = api.searchUri(query, type: type);
    var res = await http.get(url, headers: {"Accept": "application/json"});
    var jsonData = json.decode(res.body);
    if (jsonData['error'] != null) {
      throw jsonData['error']['message'];
    }
    if (jsonData['pageInfo']['totalResults'] == null) return <YT_API>[];
    List<YT_API> result = await _getResultFromJson(jsonData);
    return result;
  }

  Future<List<YT_API>> channel(String channelId, {String order}) async {
    this.getTrending = false;
    Uri url = api.channelUri(channelId, order);
    var res = await http.get(url, headers: {"Accept": "application/json"});
    var jsonData = json.decode(res.body);
    if (jsonData['error'] != null) {
      throw jsonData['error']['message'];
    }
    if (jsonData['pageInfo']['totalResults'] == null) return <YT_API>[];
    List<YT_API> result = await _getResultFromJson(jsonData);
    return result;
  }

  /*
  Get video details from video Id
   */
  Future<List<YT_VIDEO>> video(List<String> videoId) async {
    List<YT_VIDEO> result = [];
    Uri url = api.videoUri(videoId);
    var res = await http.get(url, headers: {"Accept": "application/json"});
    var jsonData = json.decode(res.body);

    if (jsonData == null) return [];

    int total = jsonData['pageInfo']['totalResults'] <
            jsonData['pageInfo']['resultsPerPage']
        ? jsonData['pageInfo']['totalResults']
        : jsonData['pageInfo']['resultsPerPage'];

    for (int i = 0; i < total; i++) {
      result.add(new YT_VIDEO(jsonData['items'][i]));
    }
    return result;
  }

  Future<List<YT_API>> _getResultFromJson(jsonData) async {
    List<YT_API> result = [];
    if (jsonData == null) return [];
    nextPageToken = jsonData['nextPageToken'];
    api.setNextPageToken(nextPageToken);
    int total = jsonData['pageInfo']['totalResults'] <
            jsonData['pageInfo']['resultsPerPage']
        ? jsonData['pageInfo']['totalResults']
        : jsonData['pageInfo']['resultsPerPage'];
    result = await _getListOfYTAPIs(jsonData, total);
    page = 1;
    return result;
  }

  Future<List<YT_API>> _getListOfYTAPIs(dynamic data, int total) async {
    List<YT_API> result = [];
    List<String> videoIdList = [];
    for (int i = 0; i < total; i++) {
      YT_API ytApiObj =
          new YT_API(data['items'][i], getTrendingVideo: getTrending);
      if (ytApiObj.kind == "video") videoIdList.add(ytApiObj.id);
      result.add(ytApiObj);
    }
    List<YT_VIDEO> videoList = await video(videoIdList);
    await Future.forEach(videoList, (YT_VIDEO ytVideo) {
      YT_API ytAPIObj = result.singleWhere((ytAPI) => ytAPI.id == ytVideo.id,
          orElse: () => null);
      ytAPIObj.duration = getDuration(ytVideo?.duration ?? "") ?? "";
    });
    return result;
  }

  Future<List<YT_API>> nextPage() async {
    this.getTrending = false;
    if (api.nextPageToken == null) return null;
    List<YT_API> result = [];
    Uri url = api.nextPageUri(this.getTrending);
    var res = await http.get(url, headers: {"Accept": "application/json"});
    var jsonData = json.decode(res.body);

    if (jsonData['pageInfo']['totalResults'] == null) return <YT_API>[];

    if (jsonData == null) return <YT_API>[];

    nextPageToken = jsonData['nextPageToken'];
    prevPageToken = jsonData['prevPageToken'];
    api.setNextPageToken(nextPageToken);
    api.setPrevPageToken(prevPageToken);
    int total = jsonData['pageInfo']['totalResults'] <
            jsonData['pageInfo']['resultsPerPage']
        ? jsonData['pageInfo']['totalResults']
        : jsonData['pageInfo']['resultsPerPage'];
    result = await _getListOfYTAPIs(jsonData, total);
    page++;
    if (total == 0) {
      return <YT_API>[];
    }
    return result;
  }

  Future<List<YT_API>> prevPage() async {
    if (api.prevPageToken == null) return null;
    List<YT_API> result = [];
    Uri url = api.prevPageUri(this.getTrending);
    var res = await http.get(url, headers: {"Accept": "application/json"});
    var jsonData = json.decode(res.body);

    if (jsonData['pageInfo']['totalResults'] == null) return <YT_API>[];

    if (jsonData == null) return <YT_API>[];

    nextPageToken = jsonData['nextPageToken'];
    prevPageToken = jsonData['prevPageToken'];
    api.setNextPageToken(nextPageToken);
    api.setPrevPageToken(prevPageToken);
    int total = jsonData['pageInfo']['totalResults'] <
            jsonData['pageInfo']['resultsPerPage']
        ? jsonData['pageInfo']['totalResults']
        : jsonData['pageInfo']['resultsPerPage'];
    result = await _getListOfYTAPIs(jsonData, total);
    if (total == 0) {
      return <YT_API>[];
    }
    page--;
    return result;
  }

  int get getPage => page;

  set setmaxResults(int maxResults) => this.maxResults = maxResults;

  get getmaxResults => this.maxResults;

  set setKey(String key) => api.key = key;

  String get getKey => api.key;

  set setQuery(String query) => api.query = query;

  String get getQuery => api.query;

  set setType(String type) => api.type = type;

  String get getType => api.type;
}
