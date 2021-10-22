import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:impromptu_generator2/screens/settingsScreens/lightningRounds.dart';
import 'package:impromptu_generator2/screens/speechScreens/timerScreen2.dart';

class MidScreen extends StatelessWidget {
  final randomTopic;
  final fontSize;
  final bool lightning;

  const MidScreen({
    Key? key,
    required this.randomTopic,
    required this.fontSize,
    required this.lightning,
  }) : super(key: key);
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
                        text: lightning ? "take a \n" : "get ready to\n",
                        style: TextStyle(
                          fontSize: MediaQuery.of(context).size.height * 0.06,
                        )),
                    TextSpan(
                        text: lightning ? "break" : "speak",
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
                lightning
                    ? Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                        return LightningRounds();
                      }))
                    : Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                        return TimerScreen2(
                          randomTopic: randomTopic,
                          fontSize: fontSize,
                        );
                      }));
              },
            ),
          ],
        ),
      ),
    );
  }
}
