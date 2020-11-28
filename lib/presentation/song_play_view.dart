import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:roarmusic/components/home_bottom_panel.dart';
import 'package:roarmusic/models/song_model.dart';

class SongPlayView extends StatelessWidget {
  final SongInfo songInfo;

  SongPlayView({@required this.songInfo});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFF08040D),
        body: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            ListTile(
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.arrow_back),
                color: Colors.white,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width*0.9,
              height: 100,
              child: TyperAnimatedTextKit(
                speed: Duration(milliseconds: 1900),
                  onTap: () {
                    print("Tap Event");
                  },
                  text: [
                    songInfo.title
                  ],
                  textStyle: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white
                  ),
                  textAlign: TextAlign.start,
                  alignment: AlignmentDirectional.topStart // or Alignment.topLeft
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.2,
                backgroundImage: AssetImage(
                        "assets/images/cover.jpg",
                      )
              )
            ]),
            SizedBox(
              height: 20,
            ),
            Consumer<SongProvider>(builder: (BuildContext context,
                SongProvider songProvider, Widget child) {
              /*if (songProvider.isPlaying) {
                return Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Color(0xFF663961),
                        blurRadius: 25.0, // soften the shadow
                        spreadRadius: 5.0, //extend the shadow
                        offset: Offset(
                          15.0, // Move to right 10  horizontally
                          15.0, // Move to bottom 10 Vertically
                        ),
                      )
                    ]),
                    child: HomeBottomPanel(
                      songProvider: songProvider,
                    ));
              } else {
                return SizedBox(
                  height: 10,
                );
              }*/
              return Container(
                width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Color(0xFF663961),
                      blurRadius: 25.0, // soften the shadow
                      spreadRadius: 5.0, //extend the shadow
                      offset: Offset(
                        15.0, // Move to right 10  horizontally
                        15.0, // Move to bottom 10 Vertically
                      ),
                    )
                  ]),
                  child: HomeBottomPanel(
                    songProvider: songProvider,
                  ));
            }),
          ],
        ),
      ),
    );
  }
}
