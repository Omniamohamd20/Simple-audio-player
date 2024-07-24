import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:r3_app/pages/play_list.dart';
import 'package:r3_app/widgets/sound_player_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final assetsAudioPlayer = AssetsAudioPlayer();
  int valueEx = 0;
  double volumeEx = 0.0;
  double playSpeedEx = 1.0;
  
   final playlist = Playlist(audios: [
    Audio('assets/audios/1.mp3', metas: Metas(
      title: 'first song',
    artist: 'Artist 1')),
    Audio('assets/audios/2.mp3', metas: Metas(title: 'second song',artist: 'Artist 2')),
   
    Audio('assets/audios/3.mp3', metas: Metas(title: 'third song',artist: 'Artist 3')),
  ]);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (_) => PlayListPage(playlist: playlist)) );
              },
              icon: const Icon(Icons.playlist_add_check_circle_sharp))
        ],
      ),
      body: SoundPlayerWidget(
          playlist: playlist,
       ));
  }
}
