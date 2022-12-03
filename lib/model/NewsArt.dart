class NewsArt{
  String imgUrl;
  String newsHead;
  String newsDes;
  String newsCnt;
  String newsUrl;
  String newsDate;
  NewsArt({this.imgUrl="https://cdn.pixabay.com/photo/2020/05/25/17/21/link-5219567__340.jpg",
    this.newsHead="--",
    this.newsDes="--",
    this.newsCnt="--",
    this.newsUrl='https://cdn.pixabay.com/photo/2020/05/25/17/21/link-5219567__340.jpg',
    this.newsDate="--"
  });
 static NewsArt fromAPItoApp(Map<String,dynamic> article){
    return NewsArt(
        imgUrl: article["urlToImage"] ?? "https://cdn.pixabay.com/photo/2020/05/25/17/21/link-5219567__340.jpg",
        newsHead: article["title"] ?? "--",
        newsDes: article["description"] ?? "--",
        newsCnt: article["content"] ?? "--",
        newsUrl: article["url"] ?? "https://news.google.com/topstories?hl=en-IN&gl=IN&ceid=IN:en",
        newsDate: article["publishedAt"] ?? "--"
    );
  }
}