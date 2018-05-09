class API{
  String Key;
  int maxResults;
  String order;
  String safeSearch;
  String Type;
  String videoDuration;
  String nextPageToken;
  String prevPageToken;
  String query ;
  Object options;
  static String base_url = 'www.googleapis.com';

  API({this.Key,this.Type,this.maxResults,this.query});

  Uri searchUri(query,{String Type}) {
    this.query = query;
    this.Type = Type??this.Type;
    var options = getOtion();
    Uri url = new Uri.https(base_url, "youtube/v3/search",options);
    return url;
  }

//  For Getting Getting Next Page
  Uri nextPageUri(){
    var options = getOtions("pageToken",nextPageToken);
    Uri url = new Uri.https(base_url, "youtube/v3/search",options);
    return  url;
  }

//  For Getting Getting Next Page
  Uri prevPageUri(){
    var options = getOtions("pageToken",prevPageToken);
    Uri url = new Uri.https(base_url, "youtube/v3/search",options);
    return  url;
  }

  Object getOtions(String key, String value){
    Object options = {
      key:value,
      "q": "${this.query}",
      "part": "snippet",
      "maxResults": "${this.maxResults}",
      "key": "${this.Key}",
      "type":"${this.Type}"
    };
    return options;
  }
  Object getOtion(){
    Object options = {
      "q": "${this.query}",
      "part": "snippet",
      "maxResults": "${this.maxResults}",
      "key": "${this.Key}",
      "type":"${this.Type}"
    };
    return options;
  }
  void setNextPageToken(String token) =>this.nextPageToken =token;
  void setPrevPageToken(String token) =>this.nextPageToken =token;
}