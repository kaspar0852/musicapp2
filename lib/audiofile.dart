import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';

class AudioFile extends StatefulWidget {
  final AudioPlayer advancePlayer;

  const AudioFile({Key? key, required this.advancePlayer}) : super(key: key);

  @override
  _AudioFileState createState() => _AudioFileState();
}

class _AudioFileState extends State<AudioFile> {
  Duration _duration = new Duration();
  Duration _position = new Duration();
  final String path =
      "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview115/v4/39/0e/6e/390e6e21-1e46-5947-e4cf-ca51b5f8c826/mzaf_2025710706695030556.plus.aac.p.m4a";
  bool isPlaying = false;
  bool isPaused = false;
  bool isRepeat = false;
  Color color = Colors.black;
  List<IconData> _icons = [
    Icons.play_circle_fill,
    Icons.pause_circle_filled,
  ];

  @override
  void initState() {
    super.initState();
    this.widget.advancePlayer.onDurationChanged.listen((d) {
      print('Max duration: $d');
      debugger(when: true);
      setState(() {
        _duration = d;
      });
    });
    this.widget.advancePlayer.onAudioPositionChanged.listen((p) {
      setState(() {
        _position = p;
      });
    });

    widget.advancePlayer.setUrl(path);

    this.widget.advancePlayer.onPlayerCompletion.listen((event) {
      setState(() {
        _position = Duration(seconds: 0);
        if (isRepeat == true) {
          isPlaying == true;
        } else {
          isPlaying == false;
          isRepeat == false;
        }
      });
    });
  }

  Widget btnStart() {
    //isplaying=bool;
    return IconButton(
      padding: const EdgeInsets.only(bottom: 10),
      icon: isPlaying == false
          ? Icon(
              _icons[0],
              size: 50,
              color: Colors.blueAccent,
            )
          : Icon(
              _icons[1],
              size: 50,
              color: Colors.blueAccent,
            ),
      onPressed: () {
        if (isPlaying == false) {
          this.widget.advancePlayer.play(path);
          setState(() {
            isPlaying = true;
          });
        } else if (isPlaying == true) {
          this.widget.advancePlayer.pause();
          setState(() {
            isPlaying == false;
          });
        }
      },
    );
  }

  Widget loadAsset() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          btnloop(),
          btnSlow(),
          btnStart(),
          btnFast(),
          btnRepeat(),
        ],
      ),
    );
  }

  Widget btnFast() {
    return IconButton(
      icon: ImageIcon(
        AssetImage('img/forward.png'),
        size: 15,
        color: Colors.black,
      ),
      onPressed: () {
        this.widget.advancePlayer.setPlaybackRate(1.5);
      },
    );
  }

  Widget btnSlow() {
    return IconButton(
      onPressed: () {
        this.widget.advancePlayer.setPlaybackRate(0.5);
      },
      icon: ImageIcon(
        AssetImage('img/backword.png'),
        size: 15,
        color: Colors.black,
      ),
    );
  }

  Widget btnloop() {
    return IconButton(
      icon: ImageIcon(
        AssetImage('img/loop.png'),
        size: 15,
        color: Colors.black,
      ),
      onPressed: () {},
    );
  }

  Widget btnRepeat() {
    return IconButton(
      icon: ImageIcon(
        AssetImage('img/repeat.png'),
        size: 15,
        color: color,
      ),
      onPressed: () {
        if (isRepeat == false) {
          this.widget.advancePlayer.setReleaseMode(ReleaseMode.LOOP);
          setState(() {
            isRepeat = true;
            color = Colors.blue;
          });
        } else if (isRepeat == true) {
          this.widget.advancePlayer.setReleaseMode(ReleaseMode.RELEASE);
          color = Colors.black;
          isRepeat = false;
        }
      },
    );
  }

  Widget slider() {
    return Slider(
      activeColor: Colors.red,
      inactiveColor: Colors.grey,
      value: _position.inSeconds.toDouble(),
      min: 0.0,
      max: _duration.inSeconds.toDouble(),
      onChanged: (double value) {
        setState(() {
          changeToSecond(value.toInt());
          value = value;
        });
      },
    );
  }

  void changeToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    this.widget.advancePlayer.seek(newDuration);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _position.toString().split(".")[0],
                  style: TextStyle(fontSize: 16),
                ),
                Text(
                  _duration.toString().split(".")[0],
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
          //slider(),
          loadAsset(),
        ],
      ),
    );
  }
}
