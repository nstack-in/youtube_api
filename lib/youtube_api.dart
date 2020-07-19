import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_api/_api.dart';

class YoutubeAPI {
  static const MethodChannel _channel = const MethodChannel('youtube_api');
  String key;
  String type;
  String query;
  String prevPageToken;
  String nextPageToken;
  int maxResults;
  API api;
  int page;
  String regionCode;
  bool getTrending;

//  Constructor
  YoutubeAPI(this.key, {String type, int maxResults: 10}) {
    page = 0;
    this.type = type;
    this.maxResults = maxResults;
    api = new API(key: this.key, maxResults: this.maxResults, type: this.type);
  }

  // For getting all Trending Videos on Youtube
  Future<List> getTrends({@required String regionCode}) async {
    this.regionCode = regionCode;
    this.getTrending = true;
    Uri url = api.trendingUri(regionCode: this.regionCode);
    var res = await http.get(url, headers: {"Accept": "application/json"});
    var jsonData = json.decode(res.body);
    if (jsonData['error'] != null) {
      print(jsonData['error']);
      return [];
    }
    if (jsonData['pageInfo']['totalResults'] == null) return [];
    List<YT_API> result = await _getResultFromJson(jsonData);
    return result;
  }

//  For Searching on YouTube
  Future<List> search(String query, {String type}) async {
    this.getTrending = false;
    this.query = query;
    Uri url = api.searchUri(query, type: type);
    var res = await http.get(url, headers: {"Accept": "application/json"});
    var jsonData = json.decode(res.body);
    if (jsonData['error'] != null) {
      print(jsonData['error']);
      return [];
    }
    if (jsonData['pageInfo']['totalResults'] == null) return [];
    List<YT_API> result = await _getResultFromJson(jsonData);
    return result;
  }

// For getting all videos from youtube channel
  Future<List> channel(String channelId, {String order}) async {
    this.getTrending = false;
    Uri url = api.channelUri(channelId, order);
    var res = await http.get(url, headers: {"Accept": "application/json"});
    var jsonData = json.decode(res.body);
    if (jsonData['error'] != null) {
      print(jsonData['error']);
      return [];
    }
    if (jsonData['pageInfo']['totalResults'] == null) return [];
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
      ytAPIObj.duration = _getDuration(ytVideo?.duration ?? "") ?? "";
    });
    return result;
  }

// To go on Next Page
  Future<List> nextPage() async {
    this.getTrending = false;
    if (api.nextPageToken == null) return null;
    List<YT_API> result = [];
    Uri url = api.nextPageUri(this.getTrending);
    print(url);
    var res = await http.get(url, headers: {"Accept": "application/json"});
    var jsonData = json.decode(res.body);

    if (jsonData['pageInfo']['totalResults'] == null) return [];

    if (jsonData == null) return [];

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
      return null;
    }
    return result;
  }

  Future<List> prevPage() async {
    if (api.prevPageToken == null) return null;
    List<YT_API> result = [];
    Uri url = api.prevPageUri(this.getTrending);
    print(url);
    var res = await http.get(url, headers: {"Accept": "application/json"});
    var jsonData = json.decode(res.body);

    if (jsonData['pageInfo']['totalResults'] == null) return [];

    if (jsonData == null) return [];

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
      return null;
    }
    page--;
    return result;
  }

//  Get Current Page
  int get getPage => page;

//  Getter and Setter for Max Result Per page
  set setmaxResults(int maxResults) => this.maxResults = maxResults;

  get getmaxResults => this.maxResults;

//  Getter and Setter Key
  set setKey(String key) => api.key = key;

  String get getKey => api.key;

//  Getter and Setter for query
  set setQuery(String query) => api.query = query;

  String get getQuery => api.query;

//  Getter and Setter for type
  set setType(String type) => api.type = type;

  String get getType => api.type;
}

String _getDuration(String duration) {
  if (duration.isEmpty) return null;
  duration = duration.replaceFirst("PT", "");

  var validDuration = ["H", "M", "S"];
  if (!duration.contains(new RegExp(r'[HMS]'))) {
    return null;
  }
  var hour = 0, min = 0, sec = 0;
  for (int i = 0; i < validDuration.length; i++) {
    var index = duration.indexOf(validDuration[i]);
    if (index != -1) {
      var valInString = duration.substring(0, index);
      var val = int.parse(valInString);
      if (i == 0)
        hour = val;
      else if (i == 1)
        min = val;
      else if (i == 2) sec = val;
      duration = duration.substring(valInString.length + 1);
    }
  }
  List buff = [];
  if (hour != 0) {
    buff.add(hour);
  }
  if (min == 0) {
    if (hour != 0) buff.add(min.toString().padLeft(2, '0'));
  } else {
    buff.add(min.toString().padLeft(2, '0'));
  }
  buff.add(sec.toString().padLeft(2, '0'));

  return buff.join(":");
}

//To Reduce import
// I added this here
class YT_API {
  dynamic thumbnail;
  String kind,
      id,
      publishedAt,
      channelId,
      channelurl,
      title,
      description,
      channelTitle,
      url,
      duration;

  YT_API(dynamic data, {bool getTrendingVideo: false}) {
    thumbnail = {
      'default': data['snippet']['thumbnails']['default'],
      'medium': data['snippet']['thumbnails']['medium'],
      'high': data['snippet']['thumbnails']['high']
    };
    if (getTrendingVideo) {
      kind = 'video'; //data['kind'].substring(8)
      id = data['id'];
    } else {
      kind = data['id']['kind'].substring(8);
      id = data['id'][data['id'].keys.elementAt(1)];
    }
    print(data['id'].keys.elementAt(1));
    print(id);
    url = getURL(kind, id);
    publishedAt = data['snippet']['publishedAt'];
    channelId = data['snippet']['channelId'];
    channelurl = "https://www.youtube.com/channel/$channelId";
    title = data['snippet']['title'];
    description = data['snippet']['description'];
    channelTitle = data['snippet']['channelTitle'];
  }

  String getURL(String kind, String id) {
    String baseURL = "https://www.youtube.com/";
    switch (kind) {
      case 'channel':
        return "${baseURL}channel/$id";
        break;
      case 'video':
        return "${baseURL}watch?v=$id";
        break;
      case 'playlist':
        return "${baseURL}playlist?list=$id";
        break;
    }
    return baseURL;
  }
}

class YT_VIDEO {
  String duration;
  String id;

  YT_VIDEO(dynamic data) {
    id = data['id'];
    duration = data['contentDetails']['duration'];
  }
}
