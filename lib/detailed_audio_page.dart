import 'package:flutter/material.dart';
import 'package:musicapp2/colors/app_colors.dart' as AppColors;
import 'package:audioplayers/audioplayers.dart';
import 'package:musicapp2/audiofile.dart';
import 'package:flutter/cupertino.dart';
import 'package:musicapp2/components/home_screen.dart';

class DetailedAudioPage extends StatefulWidget {
  const DetailedAudioPage({Key? key}) : super(key: key);

  @override
  _DetailedAudioPageState createState() => _DetailedAudioPageState();
}

class _DetailedAudioPageState extends State<DetailedAudioPage> {
  late AudioPlayer advancePlayer;
  @override
  void initState() {
    super.initState();
    advancePlayer = AudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.audioBluishBackground,
      body: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: screenHeight / 3,
              child: Container(
                color: AppColors.audioBlueBackground,
              )),
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.search),
                  ),
                ],
                backgroundColor: Colors.transparent,
                elevation: 0.0,
              )),
          Positioned(
              left: 0,
              right: 0,
              top: screenHeight * 0.2,
              height: screenHeight * 0.65,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: screenHeight * 0.1,
                    ),
                    Text(
                      "We are the champions",
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Avenir"),
                    ),
                    Text(
                      "Queen",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    AudioFile(advancePlayer: advancePlayer),
                  ],
                ),
              )),
          Positioned(
            top: screenHeight * 0.12,
            left: (screenHeight - 150) / 2,
            right: (screenHeight - 150) / 2,
            height: screenHeight * 0.16,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.audioGreyBackground,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    decoration: BoxDecoration(
                        //borderRadius: BorderRadius.circular(20),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        image: DecorationImage(
                            image: AssetImage("img/pic-1.png"),
                            fit: BoxFit.cover)),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
