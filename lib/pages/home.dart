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
    initPlayer();
    super.initState();
  }

  void initPlayer() async {
    await assetsAudioPlayer.open(
        Playlist(audios: [
          Audio('assets/audios/1.mp3', metas: Metas(title: 'first song')),
          Audio('assets/audios/2.mp3', metas: Metas(title: 'second song')),
          Audio('assets/audios/3.mp3', metas: Metas(title: 'third song')),
        ]),
        autoStart: false);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
                height: 300,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blue,
                ),
                child: Center(
                    child: StreamBuilder(
                        stream: assetsAudioPlayer.realtimePlayingInfos,
                        builder: (context, snapShots) {
                          if (snapShots.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          return Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  assetsAudioPlayer.getCurrentAudioTitle == ' '
                                      ? 'please play your audio'
                                      : assetsAudioPlayer.getCurrentAudioTitle,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        snapShots.data?.current?.index == 0
                                            ? null
                                            : assetsAudioPlayer.previous();
                                      },
                                      icon: Icon(Icons.skip_previous),
                                    ),
                                    getBtnWidget,
                                    IconButton(
                                      onPressed: () {
                                        snapShots.data?.current?.index ==
                                                (assetsAudioPlayer.playlist
                                                            ?.audios.length ??
                                                        0) -
                                                    1
                                            ? null
                                            : assetsAudioPlayer.next(
                                                keepLoopMode: false);
                                      },
                                      icon: Icon(Icons.skip_next),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Slider(
                                    value: snapShots
                                            .data?.currentPosition.inSeconds
                                            .toDouble() ??
                                        0.0,
                                    min: 0,
                                    max: snapShots.data?.duration.inSeconds
                                            .toDouble() ??
                                        0.0,
                                    onChanged: (value) {
                                      assetsAudioPlayer
                                          .seek(Duration(seconds: value.toInt()));
                                    }),
                                Text(
                                    '${convertSeconds(snapShots.data?.currentPosition.inSeconds ?? 0)}   /  ${convertSeconds(snapShots.data?.duration.inSeconds ?? 0)}',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15))
                              ]);
                        }))),
          ]),
        ),
      ),
    );
  }

  Widget get getBtnWidget =>
      assetsAudioPlayer.builderIsPlaying(builder: (ctx, isPlaying) {
        return FloatingActionButton.large(
          child: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
          onPressed: () {
            if (isPlaying) {
              assetsAudioPlayer.pause();
            } else {
              assetsAudioPlayer.play();
            }
            setState(() {});
          },
          shape: CircleBorder(),
        );
      });
  String convertSeconds(int seconds) {
    String minutes = (seconds ~/ 60).toString();
    String secondsStr = (seconds % 60).toString();
    return '${minutes.padLeft(2, '0')}:${secondsStr.padLeft(2, '0')}';
  }
}
