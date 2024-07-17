import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

class SongWidget extends StatefulWidget {
  final Audio audio;
  const SongWidget({required this.audio, super.key});
  @override
  State<SongWidget> createState() => _SongWidgetState();
}

class _SongWidgetState extends State<SongWidget> {
  final assetsAudioPlayer = AssetsAudioPlayer();
  int valueEx = 0;
  @override
  void initState() {
    initPlayer();
    super.initState();
  }

  void initPlayer() async {
    assetsAudioPlayer.open(widget.audio, autoStart: false);
    assetsAudioPlayer.currentPosition.listen((event) {
      valueEx = event.inSeconds;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Container(
        width: 150,
        alignment: Alignment.centerRight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            StreamBuilder(
                stream: assetsAudioPlayer.realtimePlayingInfos,
                builder: (ctx, snapshots) {
                  if (snapshots.connectionState == ConnectionState.done) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshots.data == null) return const SizedBox.shrink();
                  return Text(
                    '${convertSeconds(valueEx)} / ${convertSeconds(snapshots.data?.duration.inSeconds ?? 0)}',
                    style: TextStyle(color: Colors.white),
                  );
                }),
            SizedBox(
              width: 10,
            ),
            getBtnWidget
          ],
        ),
      ),
      leading: CircleAvatar(
        child: Center(
          child: Text(
              '${widget.audio.metas.artist?.split(' ').first[0].toUpperCase()}${widget.audio.metas.artist?.split(' ').last[0].toLowerCase()}'),
        ),
      ),
      title: Text(
        widget.audio.metas.title ?? 'no title',
        style: TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        widget.audio.metas.artist ?? 'no artist',
        style: TextStyle(color: Colors.white),
      ),
      onTap: () {
        setState(() {});
      },
    );
  }

  String convertSeconds(int seconds) {
    String minutes = (seconds ~/ 60).toString();
    String secondsStr = (seconds % 60).toString();
    return '${minutes.padLeft(2, '0')}:${secondsStr.padLeft(2, '0')}';
  }

  Widget get getBtnWidget =>
      assetsAudioPlayer.builderIsPlaying(builder: (ctx, isPlaying) {
        return FloatingActionButton.small(
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
}
