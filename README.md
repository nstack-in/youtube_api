# youtube_api

[![pub package](https://img.shields.io/pub/v/youtube_api.svg)](https://pub.dartlang.org/packages/youtube_api)

A Flutter plugin for fetching interacting with Youtube Server to fetch data using API. Supports iOS and Android.

## Features:

* Search Video, Playlist, Channel on youtube.
* Play Youtube Video [Coming Soon]

## Usage
To use this plugin, add `youtube_api` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

[Complete Example Code](https://pub.dartlang.org/packages/youtube_api#-example-tab-)

### Example

![alt text](https://raw.githubusercontent.com/nitishk72/youtube_api/master/demo.png)
``` dart

static String key = 'YOUR_API_KEY';
YoutubeAPI ytApi = new YoutubeAPI(key);
List<YT_API> ytResult = [];

String query = "Flutter";
ytResult = await ytApi.Search(query);
// ytResult has 
```
These data are stored in 
```json
[
    {
        "kind": "video",
        "id": "9vzd289Eedk",
        "channelTitle": "Java",
        "title": "WEBINAR - Programmatic Trading in Indian Markets using Python with Kite Connect API",
         "description": "For traders today, Python is the most preferred programming language for trading, as it provides great flexibility in terms of building and executing strategies.",
        "publishedAt":"2016-10-18T14:41:14.000Z",
        "channelId": "UC8kXgHG13XdgsigIPRmrIyA",
        "thumbnails": {
             "default": {
              "url": "https://i.ytimg.com/vi/9vzd289Eedk/default.jpg",
              "width": 120,
              "height": 90
             },
             "medium": {
              "url": "https://i.ytimg.com/vi/9vzd289Eedk/mqdefault.jpg",
              "width": 320,
              "height": 180
             },
             "high": {
              "url": "https://i.ytimg.com/vi/9vzd289Eedk/hqdefault.jpg",
              "width": 480,
              "height": 360
             }
        },
        "channelurl":"https://www.youtube.com/channel/UC8kXgHG13XdgsigIPRmrIyA",
        "url":"https://www.youtube.com/watch?v=9vzd289Eedk"
    },
    {
      "kind": "video"
       // Here will you next result
    },
    {
       // Here will you next result
    },
    {
       // Here will you next result
        "url":"https://www.youtube.com/watch?v=9vzd289Eedk"
    }
 ]
```

Default Per-page result is 10 and by default it you search for video only.

Type(String) can be video, playlist , channel

maxResults(int) can be 1 - 50
``` dart
int max = 25;
String type = "channel";
YoutubeAPI ytApi = new YoutubeAPI(key,maxResults: max,Type: type);
```

*Note*: This plugin is still under development, and some APIs might not be available yet.
[Feedback welcome](https://github.com/nitishk72/youtube_api/issues) and
[Pull Requests](https://github.com/nitishk72/youtube_api/pulls) are most welcome!