import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:impromptu_generator2/components/shortcuts.dart';
import 'package:impromptu_generator2/main.dart';
import 'package:impromptu_generator2/screens/speechScreens/chooseTopicScreen.dart';
import 'package:impromptu_generator2/topics/abstract_topics.dart';
import 'package:impromptu_generator2/topics/concrete_topics.dart';
import 'package:impromptu_generator2/topics/quote_topics.dart';
import 'package:impromptu_generator2/userSettings.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _getDataFromSharedPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getInt('time1') == null) {
      prefs.setInt('time1', 2);
    }
    if (prefs.getInt('time2') == null) {
      prefs.setInt('time2', 5);
    }
    if (prefs.getBool('playPause') == null) {
      prefs.setBool('playPause', true);
    }
    if (prefs.getBool('vibrate') == null) {
      prefs.setBool('vibrate', true);
    }
    if (prefs.getStringList('customTopics') == null) {
      prefs.setStringList('customTopics', []);
    }
    if (prefs.getBool('customTime1') == null) {
      prefs.setBool('customTime1', false);
    }
    if (prefs.getBool('customTime2') == null) {
      prefs.setBool('customTime2', false);
    }
    if (prefs.getBool('recording') == null) {
      prefs.setBool('recording', false);
    }

    if (prefs.getBool('continuous') == null) {
      prefs.setBool('continuous', false);
    }
    // if (DateTime.now().isAfter(date)) {}
    customTime1 = prefs.getBool('customTime1');
    customTime2 = prefs.getBool('customTime2');
    playPause = prefs.getBool('playPause');
    vibrate = prefs.getBool('vibrate');
    time1 = prefs.getInt('time1');
    time2 = prefs.getInt('time2');
    customTopics = prefs.getStringList('customTopics');
    recording = prefs.getBool('recording');
    continuous = prefs.getBool('continuous');
    // print(articles[0]);
  }

  @override
  void initState() {
    super.initState();
    action = "";
    Timer(Duration(milliseconds: 1200), () async {
      final QuickActions quickActions = QuickActions();

      quickActions.initialize((type) {
        if (type == null) {}

        if (type == 'action_concrete') {
          action = "";
          action = "concrete";
        }

        if (type == 'action_abstract') {
          action = "";
          action = "abstract";
        }

        if (type == 'action_quotes') {
          action = "";
          action = "quote";
        }
      });
      quickActions.setShortcutItems(ShortCuts.shortcutItems);

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        _getDataFromSharedPrefs();
        return MainScreen();
      }));

      if (action == "concrete") {
        var random = Random();
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          String topic1 = ConcreteTopics[random.nextInt(ConcreteTopics.length)];
          String topic2 = ConcreteTopics[random.nextInt(ConcreteTopics.length)];
          String topic3 = ConcreteTopics[random.nextInt(ConcreteTopics.length)];
          if (topic1 == topic2) {
            topic2 = ConcreteTopics[random.nextInt(ConcreteTopics.length)];
          }
          if (topic1 == topic3) {
            topic3 = ConcreteTopics[random.nextInt(ConcreteTopics.length)];
          }
          if (topic2 == topic3) {
            topic3 = ConcreteTopics[random.nextInt(ConcreteTopics.length)];
          }
          timeRemaining = 0;
          return ChooseTopic(
            topic1: topic1,
            topic2: topic2,
            topic3: topic3,
          );
        }));
      }

      if (action == "abstract") {
        var random = Random();
        time1 ??= 2;
        time2 ??= 5;
        String topic1 = AbstractTopics[random.nextInt(AbstractTopics.length)];
        String topic2 = AbstractTopics[random.nextInt(AbstractTopics.length)];
        String topic3 = AbstractTopics[random.nextInt(AbstractTopics.length)];
        if (topic1 == topic2) {
          topic2 = AbstractTopics[random.nextInt(AbstractTopics.length)];
        }
        if (topic1 == topic3) {
          topic3 = AbstractTopics[random.nextInt(AbstractTopics.length)];
        }
        if (topic2 == topic3) {
          topic3 = AbstractTopics[random.nextInt(AbstractTopics.length)];
        }
        timeRemaining = 0;
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ChooseTopic(
            topic1: topic1,
            topic2: topic2,
            topic3: topic3,
          );
        }));
      }

      if (action == "quote") {
        time1 ??= 2;
        time2 ??= 5;
        var random = Random();
        String topic1 = QuoteTopics[random.nextInt(QuoteTopics.length)];
        String topic2 = QuoteTopics[random.nextInt(QuoteTopics.length)];
        String topic3 = QuoteTopics[random.nextInt(QuoteTopics.length)];
        if (topic1 == topic2) {
          topic2 = QuoteTopics[random.nextInt(QuoteTopics.length)];
        }
        if (topic1 == topic3) {
          topic3 = QuoteTopics[random.nextInt(QuoteTopics.length)];
        }
        if (topic2 == topic3) {
          topic3 = QuoteTopics[random.nextInt(QuoteTopics.length)];
        }
        timeRemaining = 0;
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ChooseTopic(
            topic1: topic1,
            topic2: topic2,
            topic3: topic3,
          );
        }));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: MediaQuery.of(context).size.height * 0.07),
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: MediaQuery.of(context).size.height * 0.1,
                        backgroundImage: AssetImage("assets/icon.png"),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                      ),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            style: GoogleFonts.poppins(
                                textStyle:
                                    Theme.of(context).textTheme.headline4,
                                color: Colors.black),
                            children: [
                              TextSpan(
                                text: "impromptu\n",
                              ),
                              TextSpan(
                                text: "generator",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ]),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.07),
                            Image(
                              image: AssetImage("assets/loading3.gif"),
                              height: MediaQuery.of(context).size.height * 0.4,
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
