import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:impromptu_generator2/screens/splashScreen.dart';
import 'package:impromptu_generator2/topics/abstract_topics.dart';
import 'package:impromptu_generator2/topics/concrete_topics.dart';
import 'package:impromptu_generator2/topics/quote_topics.dart';
import 'package:impromptu_generator2/screens/ChooseTopicScreen.dart';
import 'package:impromptu_generator2/screens/setting_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      darkTheme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: SplashScreen(),
    )
  );
}

class MainScreen extends StatefulWidget {
  final int time1;
  final int time2;
  final bool playPause;

  const MainScreen({Key key, this.time1, this.time2, this.playPause}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    Color textColor;
    Color mainColor;
    final Brightness brightnessValue = MediaQuery.of(context).platformBrightness;
    bool isDark = brightnessValue == Brightness.dark;
    if(isDark){
      textColor = Colors.white;
      mainColor = Color.fromRGBO(22, 65, 122, 0.9);
    }
    else{
      textColor = Colors.black;
      mainColor = Colors.cyan[50];
    }
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/background1.JPG"),
              fit: BoxFit.fill,
            ),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            RichText(
              text: TextSpan(
                  style: GoogleFonts.poppins(textStyle: TextStyle(fontSize: MediaQuery.of(context).size.height * 0.04), color: Colors.black),
                  children: [
                    TextSpan(
                      text: "impromptu\n",
                    ),
                    TextSpan(
                      text: " generator",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RawMaterialButton(
                  onPressed: () {
                    var random = Random();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder:(context){
                              String topic1 = ConcreteTopics[random.nextInt(ConcreteTopics.length)];
                              String topic2 = ConcreteTopics[random.nextInt(ConcreteTopics.length)];
                              String topic3 = ConcreteTopics[random.nextInt(ConcreteTopics.length)];
                              if(topic1 == topic2){
                                topic2 = ConcreteTopics[random.nextInt(ConcreteTopics.length)];
                                if(topic1 == topic2){
                                  topic2 = ConcreteTopics[random.nextInt(ConcreteTopics.length)];
                                  if(topic1 == topic2){
                                    topic2 = ConcreteTopics[random.nextInt(ConcreteTopics.length)];
                                  }
                                }
                              }
                              if(topic1 == topic3){
                                topic3 = ConcreteTopics[random.nextInt(ConcreteTopics.length)];
                                if(topic1 == topic3){
                                  topic3 = ConcreteTopics[random.nextInt(ConcreteTopics.length)];
                                  if(topic1 == topic3){
                                    topic3 = ConcreteTopics[random.nextInt(ConcreteTopics.length)];
                                  }
                                }
                              }
                              if(topic2 == topic3){
                                topic3 = ConcreteTopics[random.nextInt(ConcreteTopics.length)];
                                if(topic2 == topic3){
                                  topic3 = ConcreteTopics[random.nextInt(ConcreteTopics.length)];
                                  if(topic2 == topic3){
                                    topic3 = ConcreteTopics[random.nextInt(ConcreteTopics.length)];
                                  }
                                }
                              }
                              return ChooseTopic(
                                topic1: topic1,
                                topic2: topic2,
                                topic3: topic3,
                                fontSize: 0.06,
                                time1: widget.time1 ?? 2,
                                time2: widget.time2 ?? 5,
                                playPause: widget.playPause ?? true,
                                maxLines: 1,
                              );
                            }
                        )
                    );
                  },
                  animationDuration: Duration(seconds: 10),
                  elevation: 7.0,
                  fillColor: Colors.cyan[50],
                  hoverColor: Colors.blue,
                  focusColor: Colors.blue,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: Text(
                      "concrete",
                      style: GoogleFonts.poppins(
                          fontSize: MediaQuery.of(context).size.width * 0.06,
                        color: Colors.black,
                      ),
                  ),
                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.11),
                  shape: CircleBorder(),
                ),
                RawMaterialButton(
                  onPressed: () {
                    var random = Random();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder:(context){
                              return ChooseTopic(
                                topic1: AbstractTopics[random.nextInt(AbstractTopics.length)],
                                topic2: AbstractTopics[random.nextInt(AbstractTopics.length)],
                                topic3: AbstractTopics[random.nextInt(AbstractTopics.length)],
                                fontSize: 0.06,
                                time1: widget.time1 ?? 2,
                                time2: widget.time2 ?? 5,
                                playPause: widget.playPause ?? true,
                                maxLines: 1,
                              );
                            }
                        )
                    );
                  },
                  animationDuration: new Duration(seconds: 10),
                  elevation: 7.0,
                  fillColor: Colors.cyan[50],
                  hoverColor: Colors.blue,
                  focusColor: Colors.blue,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  child: Text(
                      "abstract",
                      style: GoogleFonts.poppins(
                          fontSize: MediaQuery.of(context).size.width * 0.06
                      )
                  ),
                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.11),
                  shape: CircleBorder(),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RawMaterialButton(
                  onPressed: () {
                    var random = Random();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder:(context){
                              return ChooseTopic(
                                topic1: QuoteTopics[random.nextInt(QuoteTopics.length)],
                                topic2: QuoteTopics[random.nextInt(QuoteTopics.length)],
                                topic3: QuoteTopics[random.nextInt(QuoteTopics.length)],
                                fontSize: 0.025,
                                time1: widget.time1 ?? 2,
                                time2: widget.time2 ?? 5,
                                playPause: widget.playPause ?? true,
                                maxLines: 7,
                              );
                            }
                        )
                    );
                  },
                  fillColor: Colors.cyan[50],
                  hoverColor: Colors.blue,
                  focusColor: Colors.blue,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  animationDuration: new Duration(seconds: 10),
                  elevation: 7.0,
                  child: Text(
                      "quotes",
                      style: GoogleFonts.poppins(
                          fontSize: MediaQuery.of(context).size.width * 0.06
                      )
                  ),
                  padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.11),
                  shape: CircleBorder(),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        height: MediaQuery.of(context).size.height * 0.07,
        width: MediaQuery.of(context).size.height * 0.07,
        child: FloatingActionButton(
          splashColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          backgroundColor: Colors.cyan[50],
          child: Icon(
            Icons.settings,
            size: MediaQuery.of(context).size.height * 0.03,
            color: Colors.black,
          ),
          elevation: 7.0,
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder:(context){
                      return SettingScreen();
                    }
                )
            );
          },
        ),
      ),
    );
  }
}


