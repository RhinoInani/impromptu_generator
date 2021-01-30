import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:impromptu_generator2/screens/speechToTextScreen.dart';
import 'package:impromptu_generator2/topics/abstract_topics.dart';
import 'package:impromptu_generator2/userSettings.dart';
import 'package:impromptu_generator2/widgets/settingCard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String _launchUrlFeature =
      'https://docs.google.com/forms/d/e/1FAIpQLSf5-olnauB46sExuj4lSoORSJXnLkYJ3tWyfdec-bltiiiNqA/viewform';

  String _launchUrlIssue =
      'https://docs.google.com/forms/d/e/1FAIpQLSeiwzKDD36LhICQE2BVaHEFSYoxfFGz5QYYc4lGq52WPWAsnA/viewform';

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url,
          forceSafariVC: true,
          forceWebView: false,
          headers: <String, String>{'header key': 'header value'});
    } else {
      throw 'Could not launch $url';
    }
  }

  var random = Random();

  List _themes = [
    1.toString(),
    2.toString(),
    3.toString(),
    4.toString(),
    5.toString(),
    6.toString(),
    7.toString(),
  ];



  String _themesValue = '${time1 ??= 2}';

  String _themesValue2 = '${time2 ??= 5}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.cyan[50],
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.cyan[50],
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Column(
                children: [
                  Divider(
                    height: 5,
                    endIndent: 50,
                    indent: 50,
                    color: Colors.black87,
                    thickness: 0.5,
                  ),
                  Text(
                    "settings",
                    style: GoogleFonts.poppins(
                      fontSize: MediaQuery.of(context).size.height * 0.07,
                    ),
                  ),
                  Divider(
                    height: 5,
                    color: Colors.black,
                    endIndent: 50,
                    indent: 50,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                ],
              ),
              Divider(
                height: 5,
                color: Colors.black87,
                thickness: 0.5,
              ),
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.035),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.width * 0.035,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            "Prep Time  (Mins)",
                            style: GoogleFonts.poppins(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.055,
                            ),
                          ),
                          Spacer(),
                          Container(
                            padding: EdgeInsets.only(left: 16, right: 16),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(30)),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: MediaQuery.of(context).size.width * 0.035,
                              ),
                              child: DropdownButton(
                                hint: Text(_themes[1],
                                    style: GoogleFonts.poppins()),
                                dropdownColor: Colors.grey[100],
                                underline: Container(),
                                elevation: 5,
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize:
                                    MediaQuery.of(context).size.height * 0.04,
                                isExpanded: false,
                                value: _themesValue,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 17.0),
                                onChanged: (value) {
                                  setState(() {
                                    _themesValue = value;
                                    time1 = int.parse(_themesValue);
                                  });
                                  HapticFeedback.lightImpact();
                                },
                                items: _themes.map((value) {
                                  return DropdownMenuItem(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: GoogleFonts.poppins(),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    height: 5,
                    color: Colors.black87,
                    thickness: 0.5,
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.035,
                      vertical: MediaQuery.of(context).size.height * 0.035,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          "Speech Time  (Mins)",
                          style: GoogleFonts.poppins(
                            fontSize:
                                MediaQuery.of(context).size.width * 0.055,
                          ),
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.only(left: 16, right: 16),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(30)),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width *
                                    0.04,
                                right: MediaQuery.of(context).size.width *
                                    0.04),
                            child: DropdownButton(
                              hint: Text(_themes[5],
                                  style: GoogleFonts.poppins()),
                              dropdownColor: Colors.grey[100],
                              underline: Container(),
                              elevation: 5,
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize:
                                  MediaQuery.of(context).size.height * 0.04,
                              isExpanded: false,
                              value: _themesValue2,
                              style: TextStyle(
                                  color: Colors.black, fontSize: 17.0),
                              onChanged: (value3) {
                                setState(() {
                                  _themesValue2 = value3;
                                  time2 = int.parse(_themesValue2);
                                });
                                HapticFeedback.lightImpact();
                              },
                              items: _themes.map((value3) {
                                return DropdownMenuItem(
                                  value: value3,
                                  child: Text(
                                    value3,
                                    style: GoogleFonts.poppins(),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(
                    height: 5,
                    color: Colors.black87,
                    thickness: 0.5,
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.035,),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.width * 0.035),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            "Pause/Play",
                            style: GoogleFonts.poppins(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.055,
                            ),
                          ),
                          Spacer(),
                          Switch.adaptive(
                            value: playPause,
                            onChanged: (value) {
                              setState(() {
                                playPause = value;
                              });
                            },
                            inactiveTrackColor: Colors.blueGrey[500],
                            activeTrackColor: Colors.cyan[100],
                            activeColor: Colors.cyan[500],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    height: 5,
                    color: Colors.black87,
                    thickness: 0.5,
                  ),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.035,),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                          MediaQuery.of(context).size.width * 0.035),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            "Vibrate on Completion",
                            style: GoogleFonts.poppins(
                              fontSize:
                              MediaQuery.of(context).size.width * 0.055,
                            ),
                          ),
                          Spacer(),
                          Switch.adaptive(
                            value: vibrate,
                            onChanged: (value) {
                              setState(() {
                                vibrate = value;
                              });
                            },
                            inactiveTrackColor: Colors.blueGrey[500],
                            activeTrackColor: Colors.cyan[100],
                            activeColor: Colors.cyan[500],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    height: 5,
                    color: Colors.black87,
                    thickness: 0.5,
                  ),
                ],
              ),
              SettingsCard(
                text: "Speech to Text",
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
                pressIcon: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                        return SpeechToTextScreen(
                          time: 5,
                          randomTopic: AbstractTopics[random.nextInt(AbstractTopics.length)],
                        );
                      }));
                },
              ),
              SettingsCard(
                text: "Report an Issue",
                icon:
                    Icon(Icons.arrow_forward_ios, color: Colors.black),
                pressIcon: () {
                  _launchInBrowser(_launchUrlIssue);
                },
              ),
              SettingsCard(
                text: "Feature requests",
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
                pressIcon: () {
                  _launchInBrowser(_launchUrlFeature);
                },
              ),
              SettingsCard(
                text: "Share",
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
                pressIcon: () {
                  Share.share(
                      'Check out Impromptu Generator! \nA free app for all impromptu speakers to practice and get better! '
                      'It can also help with speaking anxiety and much more! It is a must have so download with this link: '
                      '\nhyperurl.co/impromptugenerator',
                      subject: "Check out Impromptu Generator!");
                },
              ),
              SettingsCard(
                text: "More info",
                icon: Icon(
                  Icons.info_outline,
                  color: Colors.black,
                  size: 25,
                ),
                pressIcon: () {
                  showAboutDialog(
                      context: context,
                      applicationVersion: '1.1.8',
                      applicationName: 'Impromptu Generator',
                      applicationIcon: Image.asset('assets/logo_ios.png', scale: 2,),
                      children: [
                        Text(
                          'Created by Rohin Inani',
                          style: GoogleFonts.poppins(),
                        ),
                      ]);
                },
              ),
            ],
          ),
        ),
        floatingActionButton: Container(
          height: MediaQuery.of(context).size.height * 0.07,
          width: MediaQuery.of(context).size.height * 0.07,
          child: FloatingActionButton(
            elevation: 5,
            splashColor: Colors.blue,
            highlightElevation: 7,
            backgroundColor: Colors.lightBlue[200],
            child: Icon(
              CupertinoIcons.check_mark_circled,
              color: Colors.black
            ),
            onPressed: () async {
              Navigator.pop(context);
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setInt('time1', int.parse(_themesValue));
              prefs.setInt('time2', int.parse(_themesValue2));
              prefs.setBool('playPause', playPause);
              prefs.setBool('vibrate', vibrate);
              HapticFeedback.mediumImpact();
            },
          ),
        ));
  }
}
