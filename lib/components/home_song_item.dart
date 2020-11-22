import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:roarmusic/models/app_model.dart';

class HomeSongItem extends StatelessWidget {

  final SongInfo songInfo;
  final App app;
  final int index;

  HomeSongItem(
      {@required this.songInfo,@required this.app,@required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(0),
      child: Column(
        children: [
          ListTile(
            onTap: () {
              print("list item tapped");
            },
            leading: SizedBox(
              height: 80,
              width: 80,
              child: songInfo.albumArtwork==null ? Image.asset(
                "assets/images/cover.jpg",
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ) :Image.file(File(songInfo.albumArtwork ))
            ),
            title: Text(
              songInfo.title,
              style: TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              songInfo.artist ?? "" + "\t" + parseToMinutesSeconds(int.parse(songInfo.duration)),
              style: TextStyle(color: Color(0xFF663961)),
            ),
            trailing: CircleAvatar(
                backgroundColor: Color(0xFFA03D72),
                child: IconButton(
                  onPressed: () {
                    ///bottom bar open
                    Provider.of<App>(context, listen: false).playSong(index) ;
                  },
                  icon: Provider.of<App>(context, listen: false).playingIndex==this.index ? Icon(
                    Icons.pause, 
                    color: Colors.black,
                  ) : Icon(
                    Icons.play_arrow,
                    color: Colors.black,
                  ),
                )),
            dense: true,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Divider(
              color: Colors.white,
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
    );
  }

  ///convert duration into readable format
  String parseToMinutesSeconds(int ms) {
    String data;
    Duration duration = Duration(milliseconds: ms);

    int minutes = duration.inMinutes;
    int seconds = (duration.inSeconds) - (minutes * 60);

    data = minutes.toString() + ":";
    if (seconds <= 9) data += "0";

    data += seconds.toString();
    return data;
  }
}
