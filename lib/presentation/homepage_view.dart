import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:roarmusic/components/home_bottom_panel.dart';
import 'package:roarmusic/components/home_song_item.dart';
import 'package:roarmusic/models/app_model.dart';
import 'package:roarmusic/models/song_model.dart';

class HomePageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xFF08040D),
          body: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              ListTile(
                leading: Text("Library"
                ,style: TextStyle(
                    color: Colors.white,
                    fontSize: 23
                  ),),
              ),
              SizedBox(
                height: 10,
              ),

              ///song list view
              Consumer<App>(
                  builder: (BuildContext context, App app, Widget child) {
                if (app.status == home_status.songsLoading) {
                  return Expanded(
                    flex: 1,
                    child: Center(child: CircularProgressIndicator()),
                  );
                } else {
                  return Expanded(
                    flex: 1,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: app.songList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return HomeSongItem(
                          songInfo: app.songList[index],
                          index: index,
                        );
                      },
                    ),
                  );
                }
              }),
              Consumer<SongProvider>(builder: (BuildContext context,
                  SongProvider songProvider, Widget child) {
                if (songProvider.isPlaying) {
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
                }
              }),
            ],
          )),
    );
  }
}
