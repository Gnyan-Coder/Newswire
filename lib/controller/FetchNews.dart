import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart';
import 'package:news_app/model/NewsArt.dart';
class FetchNews{
  static List sourcesId = [
    "abc-news",
    "bbc-news",
    "bbc-sport",
    "business-insider",
    "engadget",
    "entertainment-weekly",
    "espn",
    "espn-cric-info",
    "financial-post",
    "fox-news",
    "fox-sports",
    "globo",
    "google-news",
    "google-news-in",
    "medical-news-today",
    "national-geographic",
    "news24",
    "new-scientist",
    "new-york-magazine",
    "next-big-future",
    "techcrunch",
    "techradar",
    "the-hindu",
    "the-wall-street-journal",
    "the-washington-times",
    "time",
    "usa-today",
  ];
  static Future<NewsArt> fetchNews()async{
    final random=Random();
   var sourceID=sourcesId[random.nextInt(sourcesId.length)];
    String url="https://newsapi.org/v2/top-headlines?sources=$sourceID&apiKey=6a60e41b42c94b8a8d965abe5c6b3615";
    Response response=await get(Uri.parse(url));
    Map data=jsonDecode(response.body);
    List articles=data["articles"];
    final newRandom= Random();
    var myArticles=articles[newRandom.nextInt(articles.length)];
    return NewsArt.fromAPItoApp(myArticles);
  }
}