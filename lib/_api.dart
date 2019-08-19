class API {
  String key;
  int maxResults;
  String order;
  String safeSearch;
  String type;
  String videoDuration;
  String nextPageToken;
  String prevPageToken;
  String query;
  String channelId;
  Object options;
  static String baseURL = 'www.googleapis.com';

  API({this.key, this.type, this.maxResults, this.query});

  Uri searchUri(query, {String type}) {
    this.query = query;
    this.type = type ?? this.type;
    this.channelId = null;
    var options = getOption();
    Uri url = new Uri.https(baseURL, "youtube/v3/search", options);
    return url;
  }

  Uri channelUri(String channelId, String order) {
    this.order = order ?? 'date';
    this.channelId = channelId;
    var options = getChannelOption(channelId, this.order);
    Uri url = new Uri.https(baseURL, "youtube/v3/search", options);
    return url;
  }

  Uri videoUri(List<String> videoId) {
    int length = videoId.length;
    String videoIds = videoId.join(',');
    var options = getVideoOption(videoIds, length);
    Uri url = new Uri.https(baseURL, "youtube/v3/videos", options);
    return url;
  }

//  For Getting Getting Next Page
  Uri nextPageUri() {
    var options = this.channelId == null ? getOptions("pageToken", nextPageToken) : getChannelPageOption(channelId, "pageToken", nextPageToken);
    Uri url = new Uri.https(baseURL, "youtube/v3/search", options);
    return url;
  }

//  For Getting Getting Previous Page
  Uri prevPageUri() {
    var options = this.channelId == null ? getOptions("pageToken", prevPageToken) : getChannelPageOption(channelId, "pageToken", prevPageToken);
    Uri url = new Uri.https(baseURL, "youtube/v3/search", options);
    return url;
  }

  Object getOptions(String key, String value) {
    Object options = {
      key: value,
      "q": "${this.query}",
      "part": "snippet",
      "maxResults": "${this.maxResults}",
      "key": "${this.key}",
      "type": "${this.type}"
    };
    return options;
  }

  Object getOption() {
    Object options = {
      "q": "${this.query}",
      "part": "snippet",
      "maxResults": "${this.maxResults}",
      "key": "${this.key}",
      "type": "${this.type}"
    };
    return options;
  }

  Object getChannelOption(String channelId, String order) {
    Object options = {
      'channelId': channelId,
      "part": "snippet",
      'order': this.order,
      "maxResults": "${this.maxResults}",
      "key": "${this.key}",
    };
    return options;
  }

  Object getChannelPageOption(String channelId, String key, String value) {
    Object options = {
      key: value,
      'channelId': channelId,
      "part": "snippet",
      "maxResults": "${this.maxResults}",
      "key": "${this.key}",
    };
    return options;
  }

  Object getVideoOption(String videoIds, int length) {
    Object options = {
      "part": "contentDetails",
      "id": videoIds,
      "maxResults": "$length",
      "key": "${this.key}",
    };
    return options;
  }

  void setNextPageToken(String token) => this.nextPageToken = token;
  void setPrevPageToken(String token) => this.nextPageToken = token;
}
