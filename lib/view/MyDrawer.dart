import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:news_app/controller/FetchNews.dart';
import 'package:news_app/view/SearchScreen.dart';
import 'package:news_app/view/SourceScreen.dart';
import 'package:news_app/view/widget/AdWraper.dart';

import '../model/NewsArt.dart';
import 'NewsDetails.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  List sourcesId = [
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
    "the-washington-times",
    "time",
    "usa-today",
  ];

  bool isLoading = true;
  String country = 'IN';
  List<NewsArt> newsHeadList = <NewsArt>[];
  TextEditingController queryController=TextEditingController();

  @override
  void initState() {
    getHeadlines(country);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Drawer(
        child: AdWrapper(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  children: [
                     Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: TextField(
                          controller: queryController,
                          textInputAction: TextInputAction.search,
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            hintText: "Search for news",
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          if(queryController.text.isNotEmpty) {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen(query: queryController.text)));
                          }
                        },
                        icon: const Icon(
                          Icons.search,
                        ))
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                height: height / 5,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: sourcesId.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          SizedBox(
                            height: 110,
                            width: 190,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SourceScreen(
                                            source: sourcesId[index])));
                              },
                              child: Card(
                                  color: Colors.white.withOpacity(0.8),
                                  elevation: 5.0,
                                  child: Stack(
                                    children: [
                                      ClipRRect(
                                          child: Image.asset(
                                        "assets/images/wave.jpg",
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      )),
                                      Positioned.fill(
                                          child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                sourcesId[index]
                                                    .toString()
                                                    .replaceAll(
                                                        RegExp('[^A-Za-z]'), ' ')
                                                    .toUpperCase(),
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ))),
                                    ],
                                  )),
                            ),
                          ),
                        ],
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Container(
                      width: width / 1.6,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10)),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: country,
                          elevation: 5,
                          isExpanded: true,
                          // dropdownColor: Colors.grey.withOpacity(0.2),
                          onChanged: (String? newValue) {
                            setState(() {
                              country = newValue!;
                              isLoading = true;
                            });
                          },
                          items: <String>['IN', 'US']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              alignment: Alignment.center,
                              child: Text(
                                value,
                                style: const TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: OutlinedButton(
                      onPressed: (){
                        setState((){
                          getHeadlines(country);
                          isLoading = false;
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16.3),
                        side: const BorderSide(color: Colors.blue, width: 1.5),
                      ),
                      child: const Text(
                        'Apply',
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                      ),
                    )),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                    child: Row(
                  children: [
                    const Text(
                      "Top Headlines Of",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          letterSpacing: 0.5,
                          wordSpacing: 0.5,
                          fontFamily: 'Poppins'),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      country,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          letterSpacing: 0.5,
                          wordSpacing: 0.5),
                    ),
                  ],
                )),
              ),
              const SizedBox(
                height: 8,
              ),
              Expanded(
                flex: 3,
                child: SizedBox(
                  height: height,
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          itemCount: newsHeadList.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context, index) {
                            return SingleChildScrollView(
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  NewsDetailsScreen(
                                                      newsUrl: newsHeadList[index]
                                                          .newsUrl)));
                                    },
                                    child: Card(
                                      elevation: 0.5,
                                      child: ListTile(
                                        title: Text(
                                          newsHeadList[index].newsHead,
                                          style: const TextStyle(
                                              fontFamily: 'PoppinsLight',
                                              fontWeight: FontWeight.w600),
                                        ),
                                        trailing: SizedBox(
                                          height: 100,
                                          width: 100,
                                          child: newsHeadList[index].imgUrl==null?FadeInImage.assetNetwork(
                                            placeholder: "assets/images/news.jpg",
                                            image: newsHeadList[index].imgUrl,
                                            height: height,
                                            width: width / 3.5,
                                            fit: BoxFit.cover,
                                          ):Image.network(newsHeadList[index].imgUrl,height: height,
                                              width: width/3.5,fit:BoxFit.cover),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future getHeadlines(String country) async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=$country&apiKey=6a60e41b42c94b8a8d965abe5c6b3615";
    Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 400) {
      debugPrint("not found");
    }
    if (response.statusCode == 200) {
      newsHeadList.clear();
      Map data = jsonDecode(response.body);
      if(mounted){
      setState(() {
        data['articles'].forEach((element) {
          NewsArt newsHeadLineModel = NewsArt();
          newsHeadLineModel = NewsArt.fromAPItoApp(element);
          newsHeadList.add(newsHeadLineModel);
          setState(() {
            isLoading = false;
          });
        });
      });
    }
    } else {
      debugPrint("connection failed");
    }
  }
}
