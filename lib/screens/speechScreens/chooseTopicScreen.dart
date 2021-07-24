import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:impromptu_generator2/components//topicCard.dart';
import 'package:impromptu_generator2/main.dart';
import 'package:impromptu_generator2/userSettings.dart';

class ChooseTopic extends StatefulWidget {
  final String topic1;
  final String topic2;
  final String topic3;
  final double fontSize;
  final int maxLines;

  const ChooseTopic({
    Key key,
    this.topic1,
    this.topic2,
    this.topic3,
    this.fontSize,
    this.maxLines,
  }) : super(key: key);

  @override
  _ChooseTopicState createState() => _ChooseTopicState();
}

class _ChooseTopicState extends State<ChooseTopic> {
  Timer _timer;
  int time = (!customTime1 ? time1 * 60 : time1) - timeRemaining;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (time == 0) {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return MainScreen();
          }));
          _timer.cancel();
        } else {
          setState(() {
            time--;
          });
        }
      },
    );
  }

  String formatHHMMSS(int seconds) {
    int hours = (seconds / 3600).truncate();
    seconds = (seconds % 3600).truncate();
    int minutes = (seconds / 60).truncate();

    String hoursStr = (hours).toString().padLeft(2, '0');
    String minutesStr = (minutes).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    if (hours == 0 && minutes == 0) {
      return "$secondsStr";
    } else if (hours == 0) {
      return "$minutesStr:$secondsStr";
    }

    return "$hoursStr:$minutesStr:$secondsStr";
  }

  @override
  void initState() {
    timeRemaining == 0 ? null : startTimer();
    super.initState();
  }

  @override
  void dispose() {
    timeRemaining == 0 ? null : _timer.cancel();
    super.dispose();
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
        actions: [
          timeRemaining == 0
              ? Container()
              : Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 30.0, vertical: 15),
                  child: Text(
                    "${formatHHMMSS(time)}",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: MediaQuery.of(context).size.height * 0.02,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
        ],
        backgroundColor: Colors.cyan[50],
      ),
      backgroundColor: Colors.cyan[50],
      body: SingleChildScrollView(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: "Select a ",
                        style: GoogleFonts.poppins(
                            fontSize: 30, color: Colors.black)),
                    TextSpan(
                      text: "Topic",
                      style: GoogleFonts.poppins(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ]),
                ),
                TopicCard(
                  topic: widget.topic1,
                  topic1: widget.topic1,
                  topic2: widget.topic2,
                  topic3: widget.topic3,
                  fontSize: widget.fontSize,
                  maxLines: widget.maxLines,
                  timeRe: time,
                ),
                TopicCard(
                  topic: widget.topic2,
                  topic1: widget.topic2,
                  topic2: widget.topic1,
                  topic3: widget.topic3,
                  fontSize: widget.fontSize,
                  maxLines: widget.maxLines,
                  timeRe: time,
                ),
                TopicCard(
                  topic: widget.topic3,
                  topic1: widget.topic3,
                  topic2: widget.topic1,
                  topic3: widget.topic2,
                  fontSize: widget.fontSize,
                  maxLines: widget.maxLines,
                  timeRe: time,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
