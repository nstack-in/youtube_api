import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_api/_api.dart';

class YoutubeAPI {
  static const MethodChannel _channel = const MethodChannel('youtube_api');
  String Key;
  String Type;
  String Query;
  String prevPageToken;
  String nextPageToken;
  int maxResults;
  API api;
  int page;

//  Constructor
  YoutubeAPI(this.Key, {String type, int maxResults: 10}) {
    page = 0;
    this.Type = type;
    this.maxResults = maxResults;
    api = new API(Key: this.Key, maxResults: this.maxResults, Type: this.Type);
  }

//  For Searching on YouTube
  Future<List> Search(String query, {String type}) async {
    this.Query = query;
    Uri url = api.searchUri(query, Type: type);
    var res = await http.get(url, headers: {"Accept": "application/json"});
    var jsonData = json.decode(res.body);
    List<YT_API> result = _getResultFromJson(jsonData);
    return result;
  }

// For getting all videos from youtube channel
  Future<List> Channel(String channelId, {String order}) async {
    Uri url = api.channelUri(channelId, order);
    var res = await http.get(url, headers: {"Accept": "application/json"});
    var jsonData = json.decode(res.body);
    List<YT_API> result = _getResultFromJson(jsonData);
    return result;
  }

  List<YT_API> _getResultFromJson(jsonData) {
    List<YT_API> result = [];
    if (jsonData == null) return [];
    nextPageToken = jsonData['nextPageToken'];
    api.setNextPageToken(nextPageToken);
    int total = jsonData['pageInfo']['totalResults'] <
            jsonData['pageInfo']['resultsPerPage']
        ? jsonData['pageInfo']['totalResults']
        : jsonData['pageInfo']['resultsPerPage'];
    for (int i = 0; i < total; i++) {
      result.add(new YT_API(jsonData['items'][i]));
    }
    page = 1;
    return result;
  }

// To go on Next Page
  Future<List> NextPage() async {
    List<YT_API> result = [];
    Uri url = api.nextPageUri();
    print(url);
    var res = await http.get(url, headers: {"Accept": "application/json"});
    var jsonData = json.decode(res.body);
    if (jsonData == null) return [];
    nextPageToken = jsonData['nextPageToken'];
    prevPageToken = jsonData['prevPageToken'];
    api.setNextPageToken(nextPageToken);
    api.setPrevPageToken(prevPageToken);
    int total = jsonData['pageInfo']['totalResults'] <
            jsonData['pageInfo']['resultsPerPage']
        ? jsonData['pageInfo']['totalResults']
        : jsonData['pageInfo']['resultsPerPage'];
    for (int i = 0; i < total; i++) {
      result.add(new YT_API(jsonData['items'][i]));
    }
    page++;
    if (total == 0) {
      return null;
    }
    return result;
  }

  Future<List> PrevPage() async {
    List<YT_API> result = [];
    Uri url = api.nextPageUri();
    print(url);
    var res = await http.get(url, headers: {"Accept": "application/json"});
    var jsonData = json.decode(res.body);
    if (jsonData == null) return [];
    nextPageToken = jsonData['nextPageToken'];
    prevPageToken = jsonData['prevPageToken'];
    api.setNextPageToken(nextPageToken);
    api.setPrevPageToken(prevPageToken);
    int total = jsonData['pageInfo']['totalResults'] <
            jsonData['pageInfo']['resultsPerPage']
        ? jsonData['pageInfo']['totalResults']
        : jsonData['pageInfo']['resultsPerPage'];
    for (int i = 0; i < total; i++) {
      result.add(new YT_API(jsonData['items'][i]));
    }
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
  set setKey(String Key) => api.Key = Key;

  String get getKey => api.Key;

//  Getter and Setter for query
  set setQuery(String query) => api.query = query;

  String get getQuery => api.query;

//  Getter and Setter for type
  set setType(String type) => api.Type = type;

  String get getType => api.Type;
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
      url;

  YT_API(dynamic data) {
    thumbnail = {
      'default': data['snippet']['thumbnails']['default'],
      'medium': data['snippet']['thumbnails']['medium'],
      'high': data['snippet']['thumbnails']['high']
    };
    kind = data['id']['kind'].substring(8);
    id = data['id'][data['id'].keys.elementAt(1)];
    url = getURL(kind, id);
    publishedAt = data['snippet']['publishedAt'];
    channelId = data['snippet']['channelId'];
    channelurl = "https://www.youtube.com/channel/${channelId}";
    title = data['snippet']['title'];
    description = data['snippet']['description'];
    channelTitle = data['snippet']['channelTitle'];
  }

  String getURL(String kind, String id) {
    String base_url = "https://www.youtube.com/";
    switch (kind) {
      case 'channel':
        return "${base_url}watch?v=${id}";
        break;
      case 'video':
        return "${base_url}watch?v=${id}";
        break;
      case 'playlist':
        return "${base_url}watch?v=${id}";
        break;
    }
    return base_url;
  }
}
