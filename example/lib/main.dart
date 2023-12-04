import 'package:flutter/material.dart';
import 'package:youtube_api_client/youtube_api.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DemoApp(),
    );
  }
}

class DemoApp extends StatefulWidget {
  @override
  _DemoAppState createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {
  static String _key = "YOUR_API_KEY";

  final _youtube = YoutubeApi(_key);
  List<ApiResult> _result = [];

  Future<void> callAPI() async {
    String query = "Flutter";
    _result = await _youtube.search(
      query,
      options: SearchOptions(
        order: Order.relevance,
        videoDuration: VideoDuration.any,
      ),
    );
    _result = await _youtube.search(
      query,
      options: SearchOptions(
        type: [ResultType.channel],
      ),
    );
    _result = (await _youtube.nextPage()) ?? [];
    _result = await _youtube.searchVideosById([
      "4AoFA19gbLo"
    ], parts: {
      VideoPart.snippet,
      VideoPart.contentDetails,
    });
    _result = await _youtube
        .searchPlaylistsById(["PLjxrf2q8roU0WrDTm4tUB430Mja7dQEVP"]);
    _result = await _youtube.searchChannelsById([
      "UCwXdFgeE9KYzlDdR7TG9cMw"
    ], parts: {
      ChannelPart.snippet,
      ChannelPart.brandingSettings,
    });
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    callAPI();
    print('hello');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        title: Text('Youtube API'),
      ),
      body: ListView(
        children: _result.map<Widget>(listItem).toList(),
      ),
    );
  }

  Widget listItem(ApiResult obj) {
    return Card(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 7.0),
        padding: EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (obj.snippet != null) ...[
              if (obj.snippet!.thumbnails != null)
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Image.network(
                    obj.snippet!.thumbnails![ThumbnailResolution.default_]
                            ?.url ??
                        '',
                    width: 120.0,
                  ),
                ),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    obj.url,
                    softWrap: true,
                  ),
                  if (obj is YoutubeVideo)
                    ..._buildVideoElements(obj)
                  else if (obj is YoutubeChannel)
                    ..._buildChannelElements(obj)
                  else if (obj is YoutubePlaylist)
                    ..._buildPlaylistElements(obj)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _buildVideoElements(YoutubeVideo obj) => [
        if (obj.snippet != null) ...[
          Text(
            obj.snippet!.title ?? '',
            style: TextStyle(fontSize: 18.0),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 3.0),
            child: Text(
              obj.snippet!.channelTitle ?? '',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Text("publishedAt: ${obj.snippet!.publishedAt}"),
          Text("tags: ${obj.snippet!.tags?.take(3).join(", ")}"),
          Text("category: ${obj.snippet!.category?.name}"),
        ],
        if (obj.contentDetails != null) ...[
          Text("duration: ${obj.contentDetails?.duration}"),
        ],
      ];

  List<Widget> _buildChannelElements(YoutubeChannel obj) => [
        if (obj.snippet != null) ...[
          Text(
            obj.snippet!.title ?? '',
            style: TextStyle(fontSize: 18.0),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 3.0),
            child: Text(
              obj.snippet!.customUrl ?? '',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Text("publishedAt: ${obj.snippet!.publishedAt}"),
          Text("description: ${obj.snippet!.description}"),
        ],
        if (obj.brandingSettings != null) ...[
          Text(
            obj.brandingSettings!.country ?? '',
            style: TextStyle(fontSize: 18.0),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 3.0),
            child: Text(
              obj.brandingSettings!.keywords.toString(),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Text("moderateComments: ${obj.brandingSettings!.moderateComments}"),
          Text(
              "unsubscribedTrailer: ${obj.brandingSettings!.unsubscribedTrailer}"),
        ],
      ];
  List<Widget> _buildPlaylistElements(YoutubePlaylist obj) => [
        if (obj.snippet != null) ...[
          Text(
            obj.snippet!.title ?? '',
            style: TextStyle(fontSize: 18.0),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 3.0),
            child: Text(
              obj.snippet!.channelTitle ?? '',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Text("publishedAt: ${obj.snippet!.publishedAt}"),
        ],
      ];
}
