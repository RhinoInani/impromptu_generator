import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:impromptu_generator2/components//settingCard.dart';
import 'package:impromptu_generator2/screens/settingsScreens/speechToText.dart';
import 'package:impromptu_generator2/screens/settingsScreens/topicGroup.dart';
import 'package:impromptu_generator2/topics/abstract_topics.dart';
import 'package:impromptu_generator2/userSettings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'customTopics.dart';
import 'more.dart';

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
    'C',
  ];

  String? _themesValue = '${customTime1 == true ? 'C' : time1 ??= 2}';

  String? _themesValue2 = '${customTime2 == true ? 'C' : time2 ??= 5}';

  bool _customTileExpanded = false;

  void modalPopUpCustomTime(context, int defaultTime) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        Size size = MediaQuery.of(context).size;
        int localTime = 0;
        return Container(
          padding: EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
            bottom: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    "Custom Time",
                    style: TextStyle(fontSize: size.width * 0.05),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                      defaultTime == 2
                          ? customTime1 = false
                          : customTime2 = false;
                    },
                  ),
                ],
              ),
              Divider(
                height: 10,
                indent: 10,
                endIndent: 10,
                color: Colors.black87,
                thickness: 0.5,
              ),
              CupertinoTimerPicker(
                mode: CupertinoTimerPickerMode.ms,
                onTimerDurationChanged: (Duration newDuration) {
                  localTime = newDuration.inSeconds;
                },
                initialTimerDuration:
                    Duration(minutes: defaultTime, seconds: 0),
              ),
              GestureDetector(
                onTap: () {
                  if (localTime > 0) {
                    Navigator.of(context).pop();
                    defaultTime == 2 ? time1 = localTime : time2 = localTime;
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(
                      color: Colors.black,
                      width: 0.7,
                    ),
                  ),
                  width: size.width * 0.6,
                  height: size.height * 0.07,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Confirm",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            color: Colors.black, fontSize: size.width * 0.04),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: true,
      elevation: 15,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(MediaQuery.of(context).size.height * 0.02),
            topRight:
                Radius.circular(MediaQuery.of(context).size.height * 0.02)),
      ),
    );
  }

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
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.035),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.035,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            "Prep Time",
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
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.035,
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
                                onChanged: (dynamic value) {
                                  setState(() {
                                    if (value == 'C') {
                                      _themesValue = value;
                                      modalPopUpCustomTime(context, 2);
                                      customTime1 = true;
                                    } else {
                                      customTime1 = false;
                                      _themesValue = value;
                                      time1 = int.parse(_themesValue!);
                                    }
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
                          "Speech Time",
                          style: GoogleFonts.poppins(
                            fontSize: MediaQuery.of(context).size.width * 0.055,
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
                                left: MediaQuery.of(context).size.width * 0.04,
                                right:
                                    MediaQuery.of(context).size.width * 0.04),
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
                              onChanged: (dynamic value3) {
                                setState(() {
                                  if (value3 == 'C') {
                                    _themesValue2 = value3;
                                    modalPopUpCustomTime(context, 5);
                                    customTime2 = true;
                                  } else {
                                    customTime2 = false;
                                    _themesValue2 = value3;
                                    time2 = int.parse(_themesValue2!);
                                  }
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
                    padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.035,
                    ),
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
                            value: playPause!,
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
                    padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.035,
                    ),
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
                            value: vibrate!,
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
              Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.035,
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).size.width * 0.035),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Continuous",
                                style: GoogleFonts.poppins(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.055,
                                ),
                              ),
                              Text(
                                "Only Uses Speech Time",
                                style: GoogleFonts.poppins(
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.04,
                                  color: Colors.blueGrey[300],
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          Switch.adaptive(
                            value: continuous!,
                            onChanged: (value) {
                              setState(() {
                                continuous = value;
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
              // Column(
              //   children: [
              //     Container(
              //       width: MediaQuery.of(context).size.width,
              //       padding: EdgeInsets.symmetric(
              //         vertical: MediaQuery.of(context).size.height * 0.035,
              //       ),
              //       child: Padding(
              //         padding: EdgeInsets.symmetric(
              //             horizontal:
              //                 MediaQuery.of(context).size.width * 0.035),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //           children: <Widget>[
              //             Text(
              //               "Record Speech (beta)",
              //               style: GoogleFonts.poppins(
              //                 fontSize:
              //                     MediaQuery.of(context).size.width * 0.055,
              //               ),
              //             ),
              //             Spacer(),
              //             Switch.adaptive(
              //               value: recording!,
              //               onChanged: (value) {
              //                 setState(() {
              //                   recording = value;
              //                   afterEffect = "recording";
              //                 });
              //               },
              //               inactiveTrackColor: Colors.blueGrey[500],
              //               activeTrackColor: Colors.cyan[100],
              //               activeColor: Colors.cyan[500],
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //     Divider(
              //       height: 5,
              //       color: Colors.black87,
              //       thickness: 0.5,
              //     ),
              //   ],
              // ),
              SettingsCard(
                text: "Custom Topics",
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
                pressIcon: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return CustomTopicsScreen();
                  }));
                },
              ),
              SettingsCard(
                text: "Speech to Text",
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
                pressIcon: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SpeechToTextScreen(
                      randomTopic:
                          AbstractTopics[random.nextInt(AbstractTopics.length)],
                    );
                  }));
                },
              ),
              SettingsCard(
                text: "Lightning Rounds",
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                ),
                pressIcon: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ChooseTopicGroup();
                  }));
                },
              ),
              ExpansionTile(
                tilePadding: EdgeInsets.fromLTRB(
                  MediaQuery.of(context).size.width * 0.035,
                  MediaQuery.of(context).size.width * 0.07,
                  MediaQuery.of(context).size.width * 0.07,
                  MediaQuery.of(context).size.width * 0.07,
                ),
                //vertical: MediaQuery.of(context).size.width * 0.07,
                title: Text(
                  "Help Services",
                  style: GoogleFonts.poppins(
                    fontSize: MediaQuery.of(context).size.width * 0.055,
                  ),
                ),
                textColor: Colors.black,
                collapsedTextColor: Colors.black,
                collapsedIconColor: Colors.black,
                trailing: Icon(
                  _customTileExpanded
                      ? CupertinoIcons.chevron_up
                      : CupertinoIcons.chevron_down,
                  color: Colors.black,
                  size: MediaQuery.of(context).size.height * 0.03,
                ),
                onExpansionChanged: (bool expanded) {
                  setState(() => _customTileExpanded = expanded);
                },
                children: [
                  Divider(
                    height: 5,
                    color: Colors.black87,
                    thickness: 0.5,
                  ),
                  SettingsCard(
                    text: "Report an Issue",
                    icon: Icon(Icons.arrow_forward_ios, color: Colors.black),
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
                ],
              ),
              _customTileExpanded
                  ? Container()
                  : Divider(
                      height: 5,
                      color: Colors.black87,
                      thickness: 0.5,
                    ),
              SettingsCard(
                text: "More",
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.black,
                  size: 25,
                ),
                pressIcon: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return More();
                  }));
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
            child: Icon(CupertinoIcons.check_mark_circled, color: Colors.black),
            onPressed: () async {
              Navigator.pop(context);
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setBool('customTime1', customTime1!);
              prefs.setBool('customTime2', customTime2!);
              prefs.setInt('time1', time1!);
              prefs.setInt('time2', time2!);
              prefs.setBool('playPause', playPause!);
              prefs.setBool('vibrate', vibrate!);
              prefs.setStringList('customTopics', customTopics!);
              prefs.setBool('recording', recording!);
              prefs.setBool('continuous', continuous!);
              HapticFeedback.selectionClick();
            },
          ),
        ));
  }
}
