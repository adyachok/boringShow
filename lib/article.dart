library article;

import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'serializers.dart';
import 'package:http/http.dart' as http;
part 'article.g.dart';


abstract class Article implements Built<Article, ArticleBuilder> {

//  id	The item's unique id.
int get id;
// deleted	true if the item is deleted.
@nullable
bool get deleted;
// type	The type of item. One of "job", "story", "comment", "poll", or "pollopt".
String get type;
// by	The username of the item's author.
String get by;
// time	Creation date of the item, in Unix Time.
int get time;
// text	The comment, story or poll text. HTML.\
@nullable
String get text;
// dead	true if the item is dead.
@nullable
bool get dead;
// parent	The comment's parent: either another comment or the relevant story.
@nullable
int get parent;
// poll	The pollopt's associated poll.
@nullable
String get poll;
// kids	The ids of the item's comments, in ranked display order.
BuiltList<int> get kids;
// url	The URL of the story.
String get url;
// score	The story's score, or the votes for a pollopt.
int get score;
// title	The title of the story, poll or job.
String get title;
// parts	A list of related pollopts, in display order.
@nullable
BuiltList <String> get parts;
// descendants	In the case of stories or polls, the total comment count.
@nullable
int get descendants;

  Article._();

  factory Article([updates(ArticleBuilder b)]) = _$Article;

  String toJson() {
    return json.encode(serializers.serializeWith(Article.serializer, this));
  }

  static Article fromJson(String jsonString) {
    return serializers.deserializeWith(Article.serializer, json.decode(jsonString));
  }

  static Serializer<Article> get serializer => _$articleSerializer;

  static List<int> parseTopStories(String str) {
    // final url = 'https://hacker-news.firebaseio.com/v0/topstories.json';
    // final res = await http.get(url);
    // final parsed = json.jsonDecode(res.body);
    // return List<int>.from(parsed);
    return [];
  }
}