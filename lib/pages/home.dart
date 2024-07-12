import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final assetsAudioPlayer = AssetsAudioPlayer();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          IconButton(
              onPressed: () async {
                await assetsAudioPlayer.open(
                  Audio('assets/audios/1.mp3'),
                );
                setState(() {});
              },
              icon:assetsAudioPlayer.builderIsPlaying(builder: (context,isPlaying){
                return Icon(isPlaying
                  ? Icons.pause
                  : Icons.play_arrow);})
          )]
      ),
    );
  }
}
