import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:impromptu_generator2/screens/speechScreens/chooseTopicScreen.dart';
import 'package:impromptu_generator2/screens/speechScreens/mid_screen.dart';

import '../../userSettings.dart';

class TimerScreen1 extends StatefulWidget {
  final randomTopic;
  final randomTopic2;
  final randomTopic3;
  final double fontSize;

  const TimerScreen1({
    Key key,
    this.randomTopic,
    this.fontSize,
    this.randomTopic2,
    this.randomTopic3,
  }) : super(key: key);

  @override
  _TimerScreen1State createState() => _TimerScreen1State();
}

class _TimerScreen1State extends State<TimerScreen1> {
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: AutoSizeText(
                    "${widget.randomTopic}",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize:
                          MediaQuery.of(context).size.height * widget.fontSize,
                    ),
                    maxLines: widget.randomTopic.toString().length < 3 ? 1 : 7,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                Text(
                  "Prep Time",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: MediaQuery.of(context).size.height * 0.03),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.012),
                Hero(
                  tag: 1,
                  child: CircularCountDownTimer(
                    controller: controller,
                    duration: !customTime1 ? time1 * 60 : time1,
                    width: MediaQuery.of(context).size.height * 0.5,
                    height: MediaQuery.of(context).size.height * 0.35,
                    ringColor: Colors.white,
                    fillGradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.topRight,
                        colors: [Colors.blue[900], Colors.cyan]),
                    fillColor: Colors.blue,
                    initialDuration: 0,
                    strokeWidth: 5.0,
                    textStyle: GoogleFonts.poppins(
                      fontSize: MediaQuery.of(context).size.height * 0.06,
                      color: Colors.black,
                    ),
                    isReverse: true,
                    isReverseAnimation: true,
                    strokeCap: StrokeCap.round,
                    onComplete: () async {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return MidScreen(
                          randomTopic: widget.randomTopic,
                          fontSize: widget.fontSize,
                        );
                      }));
                      if (vibrate) {
                        await Future.delayed(Duration(milliseconds: 500));
                        HapticFeedback.vibrate();
                        await Future.delayed(Duration(milliseconds: 500));
                        HapticFeedback.vibrate();
                        await Future.delayed(Duration(milliseconds: 500));
                        HapticFeedback.vibrate();
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.09,
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.08,
                    width: MediaQuery.of(context).size.width * 0.5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              offset: Offset(0, 5),
                              spreadRadius: 5,
                              blurRadius: 20,
                              color: Colors.grey[300]),
                        ]),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          if (_isPause) {
                            _isPause = false;
                            controller.resume();
                          } else {
                            _isPause = true;
                            controller.pause();
                          }
                        });
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) {
                          return ChooseTopic(
                            topic1: widget.randomTopic,
                            topic2: widget.randomTopic2,
                            topic3: widget.randomTopic3,
                            fontSize: widget.fontSize,
                          );
                        }));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Change Topic",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.poppins(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.025,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: playPause
            ? FloatingActionButton.extended(
                backgroundColor: Colors.blue[600],
                elevation: 5,
                onPressed: () {
                  setState(() {
                    if (_isPause) {
                      _isPause = false;
                      controller.resume();
                    } else {
                      _isPause = true;
                      controller.pause();
                    }
                  });
                  HapticFeedback.mediumImpact();
                },
                icon: Icon(_isPause ? Icons.play_arrow : Icons.pause),
                label: Text(
                  _isPause ? "Resume" : "Pause",
                  style: GoogleFonts.poppins(),
                ))
            : Container());
  }
}
