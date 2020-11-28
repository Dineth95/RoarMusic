import 'dart:ui';

import 'package:flutter/material.dart';

class HomeBottomPanel extends StatelessWidget {

  var songProvider;
  HomeBottomPanel({this.songProvider});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: <Widget>[
            SizedBox(width: 10,),
            Text(
              _formatDuration(songProvider.position),
              style: TextStyle(
                color: Colors.white
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5),
                child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 2,
                      thumbColor: Color(0xFFA03D72),
                      overlayColor: Color(0xFFA03D72),
                      thumbShape: RoundSliderThumbShape(
                        disabledThumbRadius: 5,
                        enabledThumbRadius: 5,
                      ),
                      overlayShape: RoundSliderOverlayShape(
                        overlayRadius: 10,
                      ),
                      activeTrackColor: Color(0xFFA03D72),
                      inactiveTrackColor: Colors.grey,
                    ),
                    child: Slider(
                      value: songProvider.slider ?? 0,
                      onChanged: (value) {
                        songProvider.slider=value;
                      },
                      onChangeEnd: (value) {
                        if (songProvider.audioManagerInstance.duration != null) {
                          Duration msec = Duration(
                              milliseconds:
                              (songProvider.audioManagerInstance.duration.inMilliseconds *
                                  value)
                                  .round());
                          songProvider.audioManagerInstance.seekTo(msec);
                        }
                      },
                    )),
              ),
            ),
            Text(
              _formatDuration(songProvider.audioManagerInstance.duration),
              style: TextStyle(
                  color: Colors.white
              ),
            ),
            SizedBox(width: 10,)
          ],
        ),
        SizedBox(height: 5,),

        ///control buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            CircleAvatar(
              child: Center(
                child: IconButton(
                    icon: Icon(
                      Icons.skip_previous,
                      color: Colors.white,
                    ),
                    onPressed: () => songProvider.audioManagerInstance.previous()),
              ),
              backgroundColor: Color(0xFFA03D72).withOpacity(0.3),
            ),
            CircleAvatar(
              backgroundColor: Color(0xFFA03D72).withOpacity(0.3),
              radius: 30,
              child: Center(
                child: IconButton(
                  onPressed: () async {
                    /*if(songProvider.isPlaying)
                      songProvider.audioManagerInstance.toPause();*/
                    songProvider.audioManagerInstance.playOrPause();
                  },
                  padding: const EdgeInsets.all(0.0),
                  icon: Icon(
                    songProvider.isPlaying
                        ? Icons.pause
                        : Icons.play_arrow,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            CircleAvatar(
              backgroundColor: Color(0xFFA03D72).withOpacity(0.3),
              child: Center(
                child: IconButton(
                    icon: Icon(
                      Icons.skip_next,
                      color: Colors.white,
                    ),
                    onPressed: () => songProvider.audioManagerInstance.next()),
              ),
            ),
          ],
        ),
        SizedBox(height: 10,)
      ],
    );
  }

  String _formatDuration(Duration d) {
    if (d == null) return "--:--";
    int minute = d.inMinutes;
    int second = (d.inSeconds > 60) ? (d.inSeconds % 60) : d.inSeconds;
    String format = ((minute < 10) ? "0$minute" : "$minute") +
        ":" +
        ((second < 10) ? "0$second" : "$second");
    return format;
  }
}
