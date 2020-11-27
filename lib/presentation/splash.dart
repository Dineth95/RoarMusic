import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roarmusic/models/app_model.dart';
import 'package:roarmusic/models/song_model.dart';
import 'package:roarmusic/presentation/homepage_view.dart';
import 'package:roarmusic/utils/router.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  startTimeout() {
    return new Timer(Duration(seconds: 2), handleTimeout);
  }

  void handleTimeout() {
    ///get songs from the phone storage
    Provider.of<App>(context, listen: false).getSongsList();
    ///set up the audio manager
    Provider.of<SongProvider>(context, listen: false).setupAudio();
    changeScreen();
  }

  changeScreen() async {
    MyRouter.pushPageReplacement(
      context,
      HomePageView(),
    );
  }

  @override
  void initState() {
    super.initState();
    startTimeout();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/logo.png",
              height: 200.0,
              width: 200.0,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
