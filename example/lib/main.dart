import 'package:flutter/material.dart';
import 'package:youtube_api/youtube_api.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}


class _MyAppState extends State<MyApp> {
  static String key = 'YOUTUBE_API_KEY';
  YoutubeAPI ytApi = new YoutubeAPI(key);
  List<YT_API> ytResult = [];

  call_API() async {
    print('UI callled');
    String query = "Flutter";
    ytResult = await ytApi.Search(query);
    setState(() {
      print('UI Updated');
    });
  }
  @override
  void initState() {
    super.initState();
    call_API();
    print('hello');
  }
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
          appBar: new AppBar(
            title: Text('Youtube API'),
          ),
          body: new Container(
            child: ListView.builder(
                itemCount: ytResult.length,
                itemBuilder: (_, int index) => ListItem(ytResult[index].title)
            ),
          )
      ),
    );
  }
  Widget ListItem(title){
    return new Card(
      child: new Container(
        margin: EdgeInsets.symmetric(vertical: 7.0),
        padding: EdgeInsets.all(12.0),
        child: new Text(
          title,
          softWrap: true,
        ),
      ),
    );
  }
}
