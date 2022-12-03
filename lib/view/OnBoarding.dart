import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

import 'Home.dart';
class OnBoarding extends StatelessWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: IntroductionScreen(
          pages: [
            PageViewModel(
              title: ' Welcome To Newswire',
              body: '"In a world where everyone else is learning, if you don’t take your learning seriously you will fall behind ."',
              image: buildImage('assets/images/newspapaer.png',),
              decoration: getPageDecoration(),
            ),
            PageViewModel(
              title: "Let's Connect To World",
              body: '"Starting early with your learning will mean that you have time to'
                  ' deal with things in small steps. Even a large goal is more approachable if you break it down into smaller ones and just get started ."',
              image: buildImage('assets/images/readingnews.png'),
              decoration: getPageDecoration(),
            ),
          ],
          done: const Text('Read', style: TextStyle(fontWeight: FontWeight.w600,fontFamily: 'Poppins',fontSize: 15,color: Colors.blue)),
          onDone: () => goToHome(context),
          showSkipButton: true,
          skip: const Text('Skip',style: TextStyle(color: Colors.blue,fontFamily: 'Poppins',fontSize: 15),),
          next: const Icon(Icons.arrow_forward_ios,color: Colors.blue),
          dotsDecorator: getDotDecoration(),
          globalBackgroundColor:Colors.white,
          animationDuration: 1000,
        )
    );

  }
  void goToHome(context) => Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (_) => const HomeScreen()),
  );
  Widget buildImage(String path) =>
      Center(child: Image.asset(path, width: 300));

  DotsDecorator getDotDecoration() => DotsDecorator(
    color: Colors.black,
    activeColor: Colors.blue,
    size: const Size(10, 10),
    activeSize: const Size(22, 10),
    activeShape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(24),
    ),
  );

  PageDecoration getPageDecoration() => const PageDecoration(
    titleTextStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.bold,fontFamily: 'Poppins'),
    bodyTextStyle: TextStyle(fontSize: 15,fontFamily: 'PoppinsLight'),
    // descriptionPadding: const EdgeInsets.all(16).copyWith(bottom: 0),
    imagePadding: EdgeInsets.all(24),
    pageColor: Colors.white,
  );
}
