import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roarmusic/components/home_song_item.dart';
import 'package:roarmusic/models/app_model.dart';

class HomePageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF08040D),
      body: Consumer<App>(
        builder: (BuildContext context, App app, Widget child) {
          if (app.status == home_status.songsLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Column(
              children: [
                Expanded(
                  flex: 1,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: app.songList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return HomeSongItem(songInfo: app.songList[index],index: index,);
                    },
                  ),
                ),

                ///bottom panel for play song
                app.showBottomBar
                    ? Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        child: Center(
                          child: Text(
                            "center",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        decoration: BoxDecoration(color: Color(0xFF08040D)),
                      )
                    : SizedBox(
                        height: 20,
                      )
              ],
            );
          }
        },
      ),
    );
  }
}
