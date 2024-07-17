import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:r3_app/widgets/song_widget.dart';

class PlayListPage extends StatefulWidget {
  final Playlist playlist;
  const PlayListPage({required this.playlist, super.key});

  @override
  State<PlayListPage> createState() => _PlayListPageState();
}

class _PlayListPageState extends State<PlayListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('PlayList'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
              child: ListView(children: [
            for (var track in widget.playlist.audios)
              Card(
                color: Colors.brown,
                child: SongWidget(audio: track,)
              ) // Create a Card for each track, with a ListTile containing the track title and onTap to play the track
          ] // Convert list of tracks to ListView children
                  )),
        ));
  }
}
