import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RecordAudioPage extends StatefulWidget {
  final String audioToPlay;
  const RecordAudioPage(this.audioToPlay);

  @override
  State<RecordAudioPage> createState() => _RecordAudioPageState();
}

class _RecordAudioPageState extends State<RecordAudioPage> {
  int maxDuraction = 1;
  int currentPost = 0;
  String currentPostLabel = "00:00";
  bool isPlaying = false;
  bool audioPlayed = false;
  late Uint8List audioBytes;
  final AudioPlayer _player = AudioPlayer();
  @override
  void initState() {
    Future.delayed(Duration.zero, () async {
      ByteData bytes = await rootBundle.load(widget.audioToPlay);

      audioBytes =
          bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes);
      // convert ByteData to Uint8List
      _player.onDurationChanged.listen((event) {
        maxDuraction = event.inMilliseconds;
        setState(() {});
      });
    });
    _player.onPositionChanged.listen((event) {
      currentPost = event.inMilliseconds;
      // labels
      int shours = Duration(milliseconds: currentPost).inHours;
      int sminutes = Duration(milliseconds: currentPost).inMinutes;
      int sseconds = Duration(milliseconds: currentPost).inSeconds;

      int rhours = shours;
      int rminutes = sminutes - (shours * 60);
      int rseconds = sseconds - (sminutes * 60 + shours * 60 * 60);
      currentPostLabel = "$rhours:$rminutes:$rseconds";
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        /*Padding(
          padding:
          const EdgeInsetsDirectional.fromSTEB(
              16, 0, 16, 8),
          child: Slider(
              value: double.parse(
                  currentPost.toString()),
              min: 0,
              max: double.parse(
                  maxDuraction.toString()),
              divisions: maxDuraction,
              label: currentPostLabel,
              onChanged: (double value) async {
                int seekval = value.round();
                await _player.seek(
                      Duration(milliseconds: seekval));
                setState(() {
                  currentPost = seekval;
                });
              }),
        ),*/
        Padding(
            padding:
            const EdgeInsetsDirectional.fromSTEB(
                16, 0, 16, 8),
            child: Wrap(
              spacing: 10,
              children: [
                ElevatedButton.icon(
                    onPressed: () async {
                      if (!isPlaying &&
                          !audioPlayed) {
                        await _player.play(
                            UrlSource(widget.audioToPlay));
                        print("Playing");
                        setState(() {
                          isPlaying = true;
                          audioPlayed = true;
                        });
                      } else {
                        await _player.pause();
                        print("Good");

                        setState(() {
                          isPlaying = false;
                          audioPlayed = false;
                        });
                      }
                    },
                    icon: Icon(isPlaying
                        ? Icons.pause
                        : Icons.play_arrow),
                    label: Text(isPlaying
                        ? "Pause"
                        : "Play")),
                ElevatedButton.icon(
                  onPressed: () async {
                    _player.stop();
                    setState(() {
                      isPlaying = false;
                      audioPlayed = false;
                    });
                  },
                  icon: const Icon(Icons.stop),
                  label: const Text("Stop"),
                )
              ],
            ))
      ],
    );
  }
}
