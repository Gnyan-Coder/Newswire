import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../controller/AdHelper.dart';

class CustomButton extends StatefulWidget {
  final Function() onPressed;
  const CustomButton({Key? key,required this.onPressed}) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  InterstitialAd? _interstitialAd;

  @override
  void initState() {
    super.initState();
    InterstitialAd.load(
      adUnitId: AdHelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              widget.onPressed();
            },
          );

          setState(() {
            _interstitialAd = ad;
          });
        },
        onAdFailedToLoad: (err) {
          debugPrint('Failed to load an interstitial ad: ${err.message}');
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.black),
        ),
        onPressed: () async {
          if (_interstitialAd != null) {
            _interstitialAd?.show();
          } else {
            widget.onPressed();
          }},
        child: const Text("Read More",style: TextStyle(fontFamily: "Poppins",fontSize: 10),)
    );
  }
}
