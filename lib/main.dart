import 'package:flutter/material.dart';
import 'package:hacker_news/article.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<int> _ids = [
    21440526,
    21440508,
    21440582,
    21437334,
    21439192,
    21440180,
    21438418,
    21440684,
    21439340,
    21439918,
    21439089,
    21439659,
    21440578,
    21437551,
    21437409,
    21436245,
    21438588,
    21437908,
    21440327,
    21432480
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:  ListView(
          children: _ids.map(
            (i) => FutureBuilder<Article>(
              future: _getArticle(i),
              builder: (BuildContext context, AsyncSnapshot<Article> snapshot) {
                if(snapshot.connectionState == ConnectionState.done) {
                  return _buildItem(snapshot.data);
                } else {
                  return CircularProgressIndicator();
                }
            },
            )
          ).toList(),
        ),
      );
  }

  Future<Article> _getArticle(int id) async {
    final storyUrl = 'https://hacker-news.firebaseio.com/v0/item/$id.json';
    final storyRes = await http.get(storyUrl);
    if (storyRes.statusCode == 200) {
      return Article.fromJson(storyRes.body);
    }
  }

  Widget _buildItem(Article article) {
    return Padding(
      key: Key(article.title),
      padding: EdgeInsets.all(16.0),
      child: ExpansionTile(
        title: Text(article.title, style: TextStyle(fontSize: 24.0),),
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(article.type),
              IconButton(
                icon: Icon(Icons.launch),
                onPressed: () async {
                  final url = article.url;
                  if (await canLaunch(url)) {
                    launch(url);
                  }
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
