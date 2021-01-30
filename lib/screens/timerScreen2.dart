import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vibrate/vibrate.dart';
import 'package:wakelock/wakelock.dart';
import '../userSettings.dart';

class TimerScreen2 extends StatefulWidget {
  final randomTopic;
  final fontSize;

  const TimerScreen2({Key key, this.randomTopic, this.fontSize,}) : super(key: key);

  @override
  _TimerScreen2State createState() => _TimerScreen2State();
}

class _TimerScreen2State extends State<TimerScreen2> {
  String change = "Speech Time";
  CountDownController controller = CountDownController();
  bool _isPause = false;

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
      body: SingleChildScrollView(
        child: Center(
          heightFactor: 0.95,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Text(
                widget.randomTopic,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: MediaQuery.of(context).size.height * widget.fontSize,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07
              ),
              Text(
                "$change",
                style: GoogleFonts.poppins(
                    fontSize: MediaQuery.of(context).size.height * 0.03
                ),
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.012
              ),
              Hero(
                tag: 1,
                child: CircularCountDownTimer(
                  controller: controller,
                  duration: time2 * 60,
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
                  isReverseAnimation: true,
                  onComplete: () async {
                    Navigator.pop(context);
                    setState(() {
                      change = "Speech Time";
                      Wakelock.disable();
                    });
                    bool canVibrate = await Vibrate.canVibrate;
                    final Iterable<Duration> pauses = [
                      const Duration(milliseconds: 500),
                      const Duration(milliseconds: 500),
                    ];
                    if(canVibrate && vibrate)
                    {
                      Vibrate.vibrateWithPauses(pauses);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
        floatingActionButton: playPause ? FloatingActionButton.extended(
            onPressed: () {
              HapticFeedback.mediumImpact();
              setState(() {
                if (_isPause) {
                  _isPause = false;
                  controller.resume();
                } else {
                  _isPause = true;
                  controller.pause();
                }
              });
            },
            icon: Icon(_isPause ? Icons.play_arrow : Icons.pause),
            label: Text(_isPause ? "Resume" : "Pause", style: GoogleFonts.poppins(),)
        ) : Container()
    );
  }
}
