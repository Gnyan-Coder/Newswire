import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/view/widget/AdWraper.dart';
import 'package:news_app/view/widget/NewsContainer.dart';
import 'package:news_app/view/widget/Splash.dart';

import '../model/NewsArt.dart';
import 'MyDrawer.dart';

class SourceScreen extends StatefulWidget {
  final String source;
  const SourceScreen({Key? key,required this.source}) : super(key: key);

  @override
  State<SourceScreen> createState() => _SourceScreenState();
}

class _SourceScreenState extends State<SourceScreen> {
  bool isLoading=true;
  List<NewsArt> newsList=<NewsArt>[];
  @override
  void initState() {
    getNewsSource(widget.source);
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
            itemCount: newsList.length,
              scrollDirection: Axis.vertical,
              controller: PageController(initialPage: 0),
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
 Future getNewsSource(String source)async{
    String url="https://newsapi.org/v2/top-headlines?sources=$source&apiKey=6a60e41b42c94b8a8d965abe5c6b3615";
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
