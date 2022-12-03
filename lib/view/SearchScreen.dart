import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/view/widget/AdWraper.dart';
import 'package:news_app/view/widget/NewsContainer.dart';
import 'package:news_app/view/widget/Splash.dart';

import '../model/NewsArt.dart';
import 'MyDrawer.dart';
class SearchScreen extends StatefulWidget {
  final String query;
  const SearchScreen({Key? key,required this.query}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isLoading=true;
  List<NewsArt> newsList=<NewsArt>[];

  @override
  void initState() {
    getNewsQuery(widget.query.toLowerCase());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      drawer: SizedBox(
          width:width,
          child: const MyDrawer()),
      body: AdWrapper(
        child: SafeArea(
          child: PageView.builder(
              scrollDirection: Axis.vertical,
              controller: PageController(initialPage: 0),
              itemCount: newsList.length,
              itemBuilder: (context,index){
                return isLoading? const SplashScreen(): NewsContainerScreen(
                    imgUrl:newsList[index].imgUrl,
                    newsHead:newsList[index].newsHead,
                    newsCnt: newsList[index].newsCnt,
                    newsDes: newsList[index].newsDes,
                    publishAt:newsList[index].newsDate,
                    newsUrl: newsList[index].newsUrl
                );
              }),
        ),
      ),
    );
  }
  Future getNewsQuery(String query)async{
    String url="https://newsapi.org/v2/everything?q=$query&from=2022-12-01&sortBy=popularity&apiKey=6a60e41b42c94b8a8d965abe5c6b3615";
    http.Response response=await http.get(Uri.parse(url));
    if(response.statusCode==400){
      debugPrint("not found");
    }
    if(response.statusCode==200){
      newsList.clear();
      Map data=jsonDecode(response.body);
      setState(() {
        data['articles'].forEach((element){
          NewsArt newsSourceModel=NewsArt();
          newsSourceModel=NewsArt.fromAPItoApp(element);
          newsList.add(newsSourceModel);
          setState(() {
            isLoading=false;
          });
        });
      });
    }else{
      print("connection failed");
    }
  }
}
