# YouTube API (youtube_api)

[![pub package](https://img.shields.io/pub/v/youtube_api.svg)](https://pub.dartlang.org/packages/youtube_api)

A Flutter plugin for fetching interacting with YouTube Server to fetch data using API. Supports iOS and Android.

## Features:

- Search Video, Playlist, Channel on YouTube.
- Get Trending Videos based on region code.

## Usage

To use this plugin, add `youtube_api` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

[Complete Example Code](https://pub.dartlang.org/packages/youtube_api#-example-tab-)

### Example

![alt text](https://raw.githubusercontent.com/nstack-in/youtube_api/master/demo.jpg)

```dart

static String key = 'YOUR_API_KEY';
YoutubeAPI ytApi = new YoutubeAPI(key);
List<YouTubeVideo> videoResult = [];
```

To search for videos or Channels-

```dart
String query = "Flutter";
videoResult = await ytApi.search(query);
// data which are available in videoResult are shown below
```

To get Trending videos in your Country-

```dart
regionCode='YOUR_COUNTRY_REGION_CODE(apha-2)';
videoResult = await ytApi.getTrends(regionCode);
//make sure you assign alpha-2 region code
```

[You can find your Country Region Code here](https://www.iso.org/obp/ui/#search/code/)

These data are stored in videoResult

```json
[
  {
    "kind": "video",
    "id": "9vzd289Eedk",
    "channelTitle": "Java",
    "title": "WEBINAR - Programmatic Trading in Indian Markets using Python with Kite Connect API",
    "description": "For traders today, Python is the most preferred programming language for trading, as it provides great flexibility in terms of building and executing strategies.",
    "publishedAt": "2016-10-18T14:41:14.000Z",
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
    "channelurl": "https://www.youtube.com/channel/UC8kXgHG13XdgsigIPRmrIyA",
    "url": "https://www.youtube.com/watch?v=9vzd289Eedk"
  },
  {
    "kind": "video"
    // Data for your next result in a similar way
  },
  {
    // Data for your next result in a similar way
    "url": "https://www.youtube.com/watch?v=9vzd289Eedk"
  }
]
```

Default per-page result is 10 .

If you want search any specif out i.e video or playlist or channel.
For Channel only specify > Type : "channel"

For Video only specify > Type : "video"

For Playlist only specify > Type : "playlist"

maxResults(int) can be 1 - 50

```dart

int max = 25;

String type = "channel";

YoutubeAPI ytApi = new YoutubeAPI(key, maxResults: max, Type: type);

```

[Feedback welcome](https://github.com/nitishk72/youtube_api/issues) and
[Pull Requests](https://github.com/nitishk72/youtube_api/pulls) are most welcome!
