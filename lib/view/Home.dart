import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:news_app/controller/FetchNews.dart';
import 'package:news_app/model/NewsArt.dart';
import 'package:news_app/view/MyDrawer.dart';
import 'package:news_app/view/widget/AdWraper.dart';
import 'package:news_app/view/widget/NewsContainer.dart';
import 'package:news_app/view/widget/Splash.dart';

import '../controller/LocalNotificationService.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late NewsArt  newsArt;
  bool isLoading=true;

  getNews()async{
    newsArt=await FetchNews.fetchNews();
    setState(() {
      isLoading=false;
    });
  }
  @override
  void initState(){
    getNews();
    FirebaseMessaging.instance.getInitialMessage().then(
          (message) {
            debugPrint("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          debugPrint("New Notification");
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
        }
      },
    );
    FirebaseMessaging.onMessage.listen(
          (message) {
            debugPrint("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          debugPrint(message.notification!.title);
          debugPrint(message.notification!.body);
          debugPrint("message.data11 ${message.data}");
          LocalNotificationService.createanddisplaynotification(message);

        }
      },
    );
    FirebaseMessaging.onMessageOpenedApp.listen(
          (message) {
            debugPrint("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          debugPrint(message.notification!.title);
          debugPrint(message.notification!.body);
          debugPrint("message.data22 ${message.data['_id']}");
        }
      },
    );

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
            onPageChanged: (value){
              setState(() {
                isLoading=true;
              });
              getNews();
            },
            controller: PageController(initialPage: 0),
              itemBuilder: (context,index){
              return isLoading? const SplashScreen(): NewsContainerScreen(
                  imgUrl:newsArt.imgUrl,
                  newsHead:newsArt.newsHead,
                  newsCnt: newsArt.newsCnt,
                  newsDes: newsArt.newsDes,
                  publishAt:newsArt.newsDate,
                  newsUrl: newsArt.newsUrl
              );
              }),
        ),
      ),
    );
  }
}
