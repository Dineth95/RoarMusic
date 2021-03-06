import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

///homepage states
enum home_status{songsLoading,songsLoaded,error,songPlaying}

class App with ChangeNotifier,DiagnosticableTreeMixin{

  List<SongInfo> songList;
  home_status status;
  bool showBottomBar=false;
  int playingIndex;
  final FlutterAudioQuery audioQuery;

  App({@required this.audioQuery});

  ///get songs from phone
  Future<void> getSongsList()async{
    status=home_status.songsLoading;
    notifyListeners();
    songList = await audioQuery.getSongs();
    if(songList.isEmpty || songList==null){
      status=home_status.error;
      notifyListeners();
    }else{
      status=home_status.songsLoaded;
      notifyListeners();
    }
  }

  ///for debugging values
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('song list',songList.toString()));
  }
}