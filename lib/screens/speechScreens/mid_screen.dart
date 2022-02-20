import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:impromptu_generator2/screens/settingsScreens/lightningRounds.dart';
import 'package:impromptu_generator2/screens/speechScreens/timerScreen2.dart';

import '../../userSettings.dart';

class MidScreen extends StatefulWidget {
  final randomTopic;

  const MidScreen({
    Key? key,
    required this.randomTopic,
  }) : super(key: key);

  @override
  State<MidScreen> createState() => _MidScreenState();
}

class _MidScreenState extends State<MidScreen> {
  late String header1;
  late String header2;
  late Function function;

  @override
  void initState() {
    if (afterEffect == "normal") {
      header1 = "get ready to\n";
      header2 = "speak";
      function = () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return TimerScreen2(
            randomTopic: widget.randomTopic,
          );
        }));
      };
    }
    if (afterEffect == "lightning") {
      header1 = "take a \n";
      header2 = "break";
      function = () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return LightningRounds();
        }));
      };
    }
    if (afterEffect == "recording" || recording!) {
      header1 = "get ready to\n";
      header2 = "speak";
      function = () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) {
          return TimerScreen2(
            randomTopic: widget.randomTopic,
          );
          // return SpeechRecorder(
          //   randomTopic: widget.randomTopic,
          // );
        }));
      };
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.cyan[50],
      ),
      backgroundColor: Colors.cyan[50],
      body: Center(
        heightFactor: 0.95,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  style: GoogleFonts.poppins(color: Colors.black),
                  children: [
                    TextSpan(
                        text: header1,
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.06,
                        )),
                    TextSpan(
                        text: header2,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.height * 0.08,
                        )),
                  ]),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            CircularCountDownTimer(
              duration: 10,
              width: MediaQuery.of(context).size.height * 0.5,
              height: MediaQuery.of(context).size.height * 0.35,
              ringColor: Colors.white,
              fillColor: Colors.blue,
              fillGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: [Colors.blue[900]!, Colors.cyan]),
              strokeWidth: 5.0,
              strokeCap: StrokeCap.round,
              textStyle: GoogleFonts.poppins(
                fontSize: MediaQuery.of(context).size.height * 0.06,
                color: Colors.black,
              ),
              isReverse: true,
              isReverseAnimation: true,
              onComplete: () {
                function.call();
              },
            ),
          ],
        ),
      ),
    );
  }
}
