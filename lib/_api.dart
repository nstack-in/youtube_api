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
  Object options;
  static String baseURL = 'www.googleapis.com';

  API({this.key, this.type, this.maxResults, this.query});

  Uri searchUri(query, {String type}) {
    this.query = query;
    this.type = type ?? this.type;
    var options = getOption();
    Uri url = new Uri.https(baseURL, "youtube/v3/search", options);
    return url;
  }

  Uri channelUri(String channelId, String order) {
    this.order = order ?? 'date';
    var options = getChannelOption(channelId, this.order);
    Uri url = new Uri.https(baseURL, "youtube/v3/search", options);
    return url;
  }

//  For Getting Getting Next Page
  Uri nextPageUri() {
    var options = getOptions("pageToken", nextPageToken);
    Uri url = new Uri.https(baseURL, "youtube/v3/search", options);
    return url;
  }

//  For Getting Getting Next Page
  Uri prevPageUri() {
    var options = getOptions("pageToken", prevPageToken);
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

  void setNextPageToken(String token) => this.nextPageToken = token;
  void setPrevPageToken(String token) => this.nextPageToken = token;
}
