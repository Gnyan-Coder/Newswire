import 'dart:async';
import 'package:flutter/material.dart';
import 'package:news_app/view/widget/AdWraper.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailsScreen extends StatefulWidget {
  String newsUrl;
  NewsDetailsScreen({Key? key,required this.newsUrl}) : super(key: key);

  @override
  State<NewsDetailsScreen> createState() => _NewsDetailsScreenState();
}

class _NewsDetailsScreenState extends State<NewsDetailsScreen> {
  final Completer<WebViewController> controller=Completer<WebViewController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      widget.newsUrl=widget.newsUrl.contains("http:") ? widget.newsUrl.replaceAll("http:", "https:"):widget.newsUrl;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        elevation: 5.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:const [
            Text("News",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            Text("wire",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)
          ],
        ),
        // centerTitle: true,
      ),
      body: AdWrapper(
        child: SafeArea(
          child: WebView(
            initialUrl: widget.newsUrl,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController){
              setState(() {
                controller.complete(webViewController);
              });
            },
          ),
        ),
      ),
    );
  }
}
