import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:impromptu_generator2/components/settingCard.dart';
import 'package:impromptu_generator2/screens/splashScreen.dart';
import 'package:impromptu_generator2/userSettings.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class More extends StatefulWidget {
  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {
  String _launchUrlAddTopics =
      'https://docs.google.com/forms/d/e/1FAIpQLScnTxh5vWTy3iFnz4zOOLCpFGC7hNld0oiV8WmL6TRMJkWA5g/viewform?usp=sf_link';

  String _gitHub = "https://github.com/RhinoInani/impromptuGenerator";

  String _instagram = "https://www.instagram.com/impromptu_generator/";

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

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
        child: Column(
          children: [
            Divider(
              height: 5,
              color: Colors.black,
              endIndent: 50,
              indent: 50,
            ),
            Text(
              "more info",
              style: TextStyle(
                fontSize: size.height * 0.07,
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
            Divider(
              height: 5,
              color: Colors.black87,
              thickness: 0.5,
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
              text: "Add To The Database",
              icon: Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
              ),
              pressIcon: () {
                _launchInBrowser(_launchUrlAddTopics);
              },
            ),
            SettingsCard(
              text: "Github",
              icon: Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
              ),
              pressIcon: () {
                _launchInBrowser(_gitHub);
              },
            ),
            SettingsCard(
              text: "Instagram",
              icon: Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
              ),
              pressIcon: () {
                _launchInBrowser(_instagram);
              },
            ),
            SettingsCard(
              text: "Contact Us",
              icon: Icon(
                Icons.arrow_forward_ios,
                color: Colors.black,
              ),
              pressIcon: () {
                Share.share("rhino.inani@gmail.com",
                    subject: "Impromptu Generator");
              },
            ),
            SettingsCard(
              text: "Reset",
              icon: Icon(
                Icons.autorenew_outlined,
                color: Colors.black,
                size: 25,
              ),
              pressIcon: () {
                showCupertinoDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return CupertinoAlertDialog(
                        title: Text("Reset Impromptu Generator"),
                        content: Text(
                            "This will reset and erase all settings. \nIncluding custom topics and times."),
                        actions: [
                          CupertinoDialogAction(
                            child: Text(
                              "Cancel",
                              style: TextStyle(color: Colors.blue[600]),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          CupertinoDialogAction(
                              child: Text(
                                "Confirm",
                                style: TextStyle(color: Colors.blue[600]),
                              ),
                              onPressed: () async {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(builder: (context) {
                                  return SplashScreen();
                                }));

                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                time1 = 2;
                                time2 = 5;
                                playPause = true;
                                vibrate = true;
                                customTime1 = false;
                                customTime2 = false;
                                customTopics.clear();
                                prefs.setBool('customTime1', customTime1);
                                prefs.setBool('customTime2', customTime2);
                                prefs.setInt('time1', time1);
                                prefs.setInt('time2', time2);
                                prefs.setBool('playPause', playPause);
                                prefs.setBool('vibrate', vibrate);
                                prefs.setStringList(
                                    'customTopics', customTopics);
                                HapticFeedback.selectionClick();
                              }),
                        ],
                      );
                    });
              },
            ),
            SettingsCard(
              text: "Application Info",
              icon: Icon(
                Icons.info_outline,
                color: Colors.black,
                size: 25,
              ),
              pressIcon: () {
                showAboutDialog(
                    context: context,
                    applicationVersion: '1.2.1',
                    applicationName: 'Impromptu Generator',
                    applicationIcon: Image.asset(
                      'assets/logo_ios.png',
                      scale: 2,
                    ),
                    children: [
                      Text(
                        'Created by Rohin Inani',
                      ),
                      Divider(
                        height: 10,
                        color: Colors.black,
                        thickness: 0.5,
                      ),
                      Text('rhino.inani@gmail.com'),
                    ]);
              },
            ),
          ],
        ),
      ),
    );
  }
}
