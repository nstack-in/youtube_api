import 'package:flutter/material.dart';
import 'package:youtube_api/youtube_api.dart';

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

  final _youtube = YoutubeAPI(_key);
  List<YoutubeApiResult> _result = [];

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
    _result = await _youtube.searchById(["4AoFA19gbLo"]);
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

  Widget listItem(YoutubeApiResult obj) {
    return Card(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 7.0),
        padding: EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Image.network(
                obj.thumbnail.small.url ?? '',
                width: 120.0,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    obj.title,
                    softWrap: true,
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 3.0),
                    child: Text(
                      obj.channelTitle,
                      softWrap: true,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    obj.url,
                    softWrap: true,
                  ),
                  Text(
                    "tags: ${obj.tags.join(", ")}",
                    softWrap: true,
                  ),
                  if (obj is YouTubeVideo) ...[
                    Text(
                      "duration: ${obj.duration}",
                      softWrap: true,
                    ),
                    Text(
                      "category: ${obj.category?.name}",
                      softWrap: true,
                    ),
                  ]
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
