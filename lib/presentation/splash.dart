import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roarmusic/models/app_model.dart';
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
    Provider.of<App>(context, listen: false).getSongsList();
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
              "assets/images/cover.jpg",
              height: 300.0,
              width: 300.0,
            ),
          ],
        ),
      ),
    );
  }
}
