# youtube_api

[![pub package](https://img.shields.io/pub/v/youtube_api.svg)](https://pub.dartlang.org/packages/youtube_api)

A Flutter plugin for fetching interacting with Youtube Server to fetch data using API. Supports iOS and Android.

## Usage
To use this plugin, add `youtube_api` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).

[Complete Example Code](https://pub.dartlang.org/packages/youtube_api#-example-tab-)

### Example

``` dart

static String key = 'YOUR_API_KEY';
YoutubeAPI ytApi = new YoutubeAPI(key);
List<YT_API> ytResult = [];

String query = "Flutter";
ytResult = await ytApi.Search(query);

```

Default Per-page result is 10 and by default it you search for video only.

Type(String) can be video, playlist , channel

maxResults(int) can be 1 - 50
``` dart
int max = 25;
String type = "channel";
YoutubeAPI ytApi = new YoutubeAPI(key,maxResults: max,Type: type);
```