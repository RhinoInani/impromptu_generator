import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:impromptu_generator2/screens/speechScreens/mid_screen.dart';
import 'package:impromptu_generator2/topics/abstract_topics.dart';
import 'package:impromptu_generator2/topics/concrete_topics.dart';
import 'package:impromptu_generator2/topics/quote_topics.dart';

import '../../userSettings.dart';

class LightningRounds extends StatefulWidget {
  const LightningRounds({Key? key}) : super(key: key);

  @override
  State<LightningRounds> createState() => _LightningRoundsState();
}

class _LightningRoundsState extends State<LightningRounds> {
  CountDownController controller = CountDownController();
  String randomTopic = "";
  late int maxLines;

  @override
  void initState() {
    generateRandomTopic();
    super.initState();
  }

  void generateRandomTopic() {
    var random = Random();
    if (topicGroupSelected == 1) {
      randomTopic = ConcreteTopics[random.nextInt(ConcreteTopics.length)];
      setState(() {
        maxLines = 1;
      });
    } else if (topicGroupSelected == 2) {
      randomTopic = AbstractTopics[random.nextInt(AbstractTopics.length)];
      setState(() {
        maxLines = 1;
      });
    } else if (topicGroupSelected == 3) {
      randomTopic = QuoteTopics[random.nextInt(QuoteTopics.length)];
      setState(() {
        maxLines = 3;
      });
    } else if (topicGroupSelected == 4) {
      int currentTopicGroup = random.nextInt(3);
      if (currentTopicGroup % 3 == 0) {
        randomTopic = ConcreteTopics[random.nextInt(ConcreteTopics.length)];
        setState(() {
          maxLines = 1;
        });
      } else if (currentTopicGroup % 3 == 1) {
        randomTopic = AbstractTopics[random.nextInt(AbstractTopics.length)];
        setState(() {
          maxLines = 1;
        });
      } else if (currentTopicGroup % 3 == 2) {
        randomTopic = QuoteTopics[random.nextInt(QuoteTopics.length)];
        setState(() {
          maxLines = 3;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
                height: size.height * 0.05,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                child: AutoSizeText(
                  "$randomTopic",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: MediaQuery.of(context).size.height * 0.05,
                      fontWeight: FontWeight.bold),
                  maxLines: maxLines,
                ),
              ),
              SizedBox(height: size.height * 0.06),
              CircularCountDownTimer(
                autoStart: true,
                controller: controller,
                duration: lightningRoundTime,
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
                onComplete: () async {
                  setState(() {
                    afterEffect = "lightning";
                  });
                  if (vibrate!) {
                    await Future.delayed(Duration(milliseconds: 500));
                    HapticFeedback.vibrate();
                    await Future.delayed(Duration(milliseconds: 500));
                    HapticFeedback.vibrate();
                    await Future.delayed(Duration(milliseconds: 500));
                    HapticFeedback.vibrate();
                  }
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (BuildContext context) {
                    return MidScreen(
                      randomTopic: "",
                    );
                  }));
                },
              ),
              SizedBox(
                height: size.height * 0.07,
              ),
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    afterEffect = "lightning";
                  });
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (BuildContext context) {
                    return MidScreen(
                      randomTopic: "",
                    );
                  }));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Next Round",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: size.height * 0.03,
                    ),
                  ),
                ),
                style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28)),
                    side: BorderSide(
                      color: Colors.black,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
