class API {
  String Key;
  int maxResults;
  String order;
  String safeSearch;
  String Type;
  String videoDuration;
  String nextPageToken;
  String prevPageToken;
  String query;
  Object options;
  static String base_url = 'www.googleapis.com';

  API({this.Key, this.Type, this.maxResults, this.query});

  Uri searchUri(query, {String Type}) {
    this.query = query;
    this.Type = Type ?? this.Type;
    var options = getOption();
    Uri url = new Uri.https(base_url, "youtube/v3/search", options);
    return url;
  }

  Uri channelUri(String channelId, String order) {
    this.order = order ?? 'date';
    var options = getChannelOption(channelId, this.order);
    Uri url = new Uri.https(base_url, "youtube/v3/search", options);
    return url;
  }

//  For Getting Getting Next Page
  Uri nextPageUri() {
    var options = getOptions("pageToken", nextPageToken);
    Uri url = new Uri.https(base_url, "youtube/v3/search", options);
    return url;
  }

//  For Getting Getting Next Page
  Uri prevPageUri() {
    var options = getOptions("pageToken", prevPageToken);
    Uri url = new Uri.https(base_url, "youtube/v3/search", options);
    return url;
  }

  Object getOptions(String key, String value) {
    Object options = {
      key: value,
      "q": "${this.query}",
      "part": "snippet",
      "maxResults": "${this.maxResults}",
      "key": "${this.Key}",
      "type": "${this.Type}"
    };
    return options;
  }

  Object getOption() {
    Object options = {
      "q": "${this.query}",
      "part": "snippet",
      "maxResults": "${this.maxResults}",
      "key": "${this.Key}",
      "type": "${this.Type}"
    };
    return options;
  }

  Object getChannelOption(String channelId, String order) {
    Object options = {
      'channelId': channelId,
      "part": "snippet",
      'order': this.order,
      "maxResults": "${this.maxResults}",
      "key": "${this.Key}",
    };
    return options;
  }

  void setNextPageToken(String token) => this.nextPageToken = token;
  void setPrevPageToken(String token) => this.nextPageToken = token;
}
