import 'package:audio_manager/audio_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum song_status{
  playing,
  pause,
  stopped,
  skipped
}

class SongProvider with ChangeNotifier,DiagnosticableTreeMixin{

  int playingSongIndex;
  song_status songStatus;
  double slider=0;
  Duration duration=Duration(milliseconds: 0);
  Duration position=Duration(milliseconds: 0);
  double _sliderVolume=0;
  String _error;
  bool isPlaying = false;
  final AudioManager audioManagerInstance;
  SongProvider({@required this.audioManagerInstance});

  ///set up the audio manager at the beginning
  void setupAudio()async{
    //audioManagerInstance.intercepter = true;
    //PlayMode playMode = AudioManager.instance.playMode;
    audioManagerInstance.play(auto: true);

    audioManagerInstance.onEvents((events, args) {
      print("$events, $args");
      switch (events) {
        case AudioManagerEvents.start:
          position = audioManagerInstance.position;
          duration = audioManagerInstance.duration;
          slider = 0;
          notifyListeners();
          break;
        case AudioManagerEvents.ready:
          print("ready to play");
          _error = null;
          _sliderVolume = audioManagerInstance.volume;
          position = audioManagerInstance.position;
          duration = audioManagerInstance.duration;
          notifyListeners();
          // if you need to seek times, must after AudioManagerEvents.ready event invoked
          // AudioManager.instance.seekTo(Duration(seconds: 10));
          break;
        case AudioManagerEvents.seekComplete:
          position = audioManagerInstance.position;
          slider = position.inMilliseconds / duration.inMilliseconds;
          notifyListeners();
          print("seek event is completed. position is [$args]/ms");
          break;
        case AudioManagerEvents.buffering:
          print("buffering $args");
          break;
        case AudioManagerEvents.playstatus:
          isPlaying = audioManagerInstance.isPlaying;
          notifyListeners();
          break;
        case AudioManagerEvents.timeupdate:
          position = audioManagerInstance.position;
          slider = position.inMilliseconds / duration.inMilliseconds;
          notifyListeners();
          audioManagerInstance.updateLrc(args["position"].toString());
          break;
        case AudioManagerEvents.error:
          _error = args;
          notifyListeners();
          break;
        case AudioManagerEvents.ended:
          audioManagerInstance.next();
          break;
        case AudioManagerEvents.volumeChange:
          _sliderVolume = audioManagerInstance.volume;
          notifyListeners();
          break;
        default:
          break;
      }
    });
  }

  void playSong(int index,String filePath,String title,String displayName,String cover){
      this.playingSongIndex=index;
      audioManagerInstance
          .start("file://$filePath",title,
          desc: displayName,
          auto: true,
          cover: "assets/images/cover.jpg")
          .then((err) {
        print(err);
      });

      audioManagerInstance.playOrPause();
      notifyListeners();
  }

  ///for debugging values
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('playing index',playingSongIndex));
  }
}