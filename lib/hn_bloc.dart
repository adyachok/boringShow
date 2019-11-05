import 'dart:collection';

import 'package:hacker_news/article.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;

class HackerNewsBloc {
  Stream<List<Article>> get articles => _articlesSubject.stream;
  final _articlesSubject = BehaviorSubject<UnmodifiableListView<Article>>();

  var _articles = <Article>[];
  
    HackerNewsBloc() {
      _updateArticles().then((_){
        _articlesSubject.add(UnmodifiableListView(_articles));
      });
    }
  
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

    Future<Null> _updateArticles() async {
      final futureArticles = _ids.map((id) => _getArticle(id));
      final articles = await Future.wait(futureArticles);
      _articles = articles;
    }
  
    Future<Article> _getArticle(int id) async {
      final storyUrl = 'https://hacker-news.firebaseio.com/v0/item/$id.json';
      final storyRes = await http.get(storyUrl);
      if (storyRes.statusCode == 200) {
        return Article.fromJson(storyRes.body);
      }
    }
  
  }
  
  class Articles {
}