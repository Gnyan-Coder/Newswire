import 'package:flutter/material.dart';
import 'package:news_app/view/NewsDetails.dart';

import 'Button.dart';

class NewsContainerScreen extends StatelessWidget {
  final String imgUrl;
  final String newsCnt;
  final String newsHead;
  final String newsDes;
  final String publishAt;
  final String newsUrl;
  const NewsContainerScreen({Key? key,required this.imgUrl,required this.newsCnt,required this.newsHead,
  required this.newsDes,required this.publishAt,required this.newsUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return  SizedBox(
    height:height,
    width:width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
              child: imgUrl!=null?FadeInImage.assetNetwork(placeholder: "assets/images/news.jpg",
                image:imgUrl,height: 200,width:width,fit: BoxFit.cover,):Image.network(imgUrl,height: 200,width:width,fit: BoxFit.cover,)
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0)),
                color: Colors.black,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5.0,
                  ),
                ],

              ),
              child:const Padding(
                padding:EdgeInsets.all(5.0),
                child: Text("Newswire",style: TextStyle(fontSize: 9,fontWeight: FontWeight.bold,color: Colors.white,fontFamily: "Poppins"),),
              ),
            ),
          ),
          const SizedBox(height: 5,),
          Container(
          width: width,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(newsCnt !="--"?newsHead.length>70 ?"${newsHead.substring(0,70)}...":newsHead:newsHead,
                style:const TextStyle(fontSize: 20,fontFamily: 'Poppins'),),
              const SizedBox(height: 10,),
              Text(newsCnt !="--"?newsDes.length>70 ?"${newsDes.substring(0,70)}...":newsDes:newsDes,style: const TextStyle(fontSize: 16,color: Colors.grey),),
              const SizedBox(height: 10,),
              Text(newsCnt !="--"?newsCnt.length>250 ? newsCnt.substring(0,250):"${newsCnt.toString().substring(0,newsCnt.length-15)} ...":newsCnt,
                style:const TextStyle(fontSize: 16,fontFamily: 'PoppinsLight'),),
            ],
          ),
            ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(publishAt.substring(0,10),style: const TextStyle(fontWeight: FontWeight.w500,fontFamily: "Poppins",fontSize: 12),),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child:CustomButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsDetailsScreen(newsUrl: newsUrl)));
                  },
                )
              ),
            ],
          ),
          const SizedBox(height: 10,),
        ],
      ),
    );
  }


}