import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:impromptu_generator2/main.dart';
import 'package:impromptu_generator2/userSettings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 1500), () {
      _getDataFromSharedPrefs() async{
        final prefs = await SharedPreferences.getInstance();
        if(prefs.getInt('time1') == null) {
          prefs.setInt('time1', 2);
        }
        if(prefs.getInt('time2') == null) {
          prefs.setInt('time2', 5);
        }
        if(prefs.getBool('playPause') == null){
            prefs.setBool('playPause', true);
        }
        if(prefs.getBool('vibrate') == null){
          prefs.setBool('vibrate', true);
        }
        playPause = prefs.getBool('playPause');
        vibrate = prefs.getBool('vibrate');
        time1 = prefs.getInt('time1');
        time2 = prefs.getInt('time2');
      }
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context){
            _getDataFromSharedPrefs();
            return MainScreen();
          }
          )
      );
    }
    );
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
                      Padding(padding: EdgeInsets.only(top: 10),),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                            style: GoogleFonts.poppins(textStyle: Theme.of(context).textTheme.headline4, color: Colors.black),
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
                            ]
                        ),
                      ),
                      Expanded(flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                            Image(image: AssetImage("assets/loading3.gif"), height: MediaQuery.of(context).size.height * 0.4,),
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