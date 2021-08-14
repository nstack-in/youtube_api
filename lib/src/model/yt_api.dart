@Deprecated('Use YoutubeVide class instead of YT_API')
class YT_API {
  Map<String,dynamic>? thumbnail;
  String? kind;
  String? id;
  String? publishedAt;
  String? channelId;
  String? channelUrl;
  late String title;
  String? description;
  late String channelTitle;
  late String url;
  String? duration;

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
    url = getURL(kind!, id!);
    publishedAt = data['snippet']['publishedAt'];
    channelId = data['snippet']['channelId'];
    channelUrl = "https://www.youtube.com/channel/$channelId";
    title = data['snippet']['title'];
    description = data['snippet']['description'];
    channelTitle = data['snippet']['channelTitle'];
  }

  String getURL(String kind, String id) {
    String baseURL = "https://www.youtube.com/";
    switch (kind) {
      case 'channel':
        return "${baseURL}channel/$id";
      case 'video':
        return "${baseURL}watch?v=$id";
      case 'playlist':
        return "${baseURL}playlist?list=$id";
    }
    return baseURL;
  }
}
@Deprecated('Use Video class instead of YT_VIDEO')
class YT_VIDEO {
  String? duration;
  String? id;

  YT_VIDEO(dynamic data) {
    id = data['id'];
    duration = data['contentDetails']['duration'];
  }
}

String? getDuration(String duration) {
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
