import 'package:flutter/material.dart';
import 'package:news_app/view/widget/AdWraper.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;
    return Scaffold(
      body: AdWrapper(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/images/weather.png",width:width/2,color: Colors.blue,),
                Image.asset("assets/images/arrow.gif",width: width/15,),
                const SizedBox(height: 5,),
                const Icon(Icons.phone_android,size: 150,color: Colors.blue,),
                const SizedBox(height: 25,),
                const Text("Loading Newswire...",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,fontFamily: "Poppins"),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
