
import 'package:audio_manager/audio_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:provider/provider.dart';
import 'package:roarmusic/models/app_model.dart';
import 'package:roarmusic/models/song_model.dart';
import 'package:roarmusic/presentation/splash.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => App(
            audioQuery: FlutterAudioQuery()),
      ),
      ChangeNotifierProvider(
        create: (_)=>SongProvider(audioManagerInstance: AudioManager.instance),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}
