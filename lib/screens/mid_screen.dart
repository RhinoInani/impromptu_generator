import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:impromptu_generator2/screens/timerScreen2.dart';

class MidScreen extends StatelessWidget {
  final randomTopic;
  final fontSize;

  const MidScreen({Key key, this.randomTopic, this.fontSize,}) : super(key: key);
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: GoogleFonts.poppins(color: Colors.black),
                children: [
                  TextSpan(
                    text: "get ready to\n", style: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.06,)
                  ),
                  TextSpan(text: "speak", style: TextStyle(fontWeight: FontWeight.bold,fontSize: MediaQuery.of(context).size.height * 0.08,)),
                ]
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
            Hero(
              tag:1,
              child: CircularCountDownTimer(
                duration: 10,
                width: MediaQuery.of(context).size.height * 0.5,
                height: MediaQuery.of(context).size.height * 0.35,
                color: Colors.white,
                fillColor: Colors.blue,
                strokeWidth: 5.0,
                textStyle: GoogleFonts.poppins(
                  fontSize: MediaQuery.of(context).size.height * 0.06,
                  color: Colors.black,
                ),
                isReverse: true,
                onComplete: (){
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder:(context){
                            return TimerScreen2(
                              randomTopic: randomTopic,
                              fontSize: fontSize,
                            );
                          }
                      )
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
