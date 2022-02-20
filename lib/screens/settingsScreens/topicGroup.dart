import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:impromptu_generator2/screens/settingsScreens/lightningRounds.dart';

import '../../userSettings.dart';

class ChooseTopicGroup extends StatefulWidget {
  const ChooseTopicGroup({Key? key}) : super(key: key);

  @override
  State<ChooseTopicGroup> createState() => _ChooseTopicGroupState();
}

class _ChooseTopicGroupState extends State<ChooseTopicGroup> {
  int value = 1;
  int time = 60;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.cyan[50],
      appBar: AppBar(
        backgroundColor: Colors.cyan[50],
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "Select settings for ",
                      style: GoogleFonts.poppins(
                          fontSize: 30, color: Colors.black)),
                  TextSpan(
                    text: "\nLightning Rounds",
                    style: GoogleFonts.poppins(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ]),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              Row(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.06),
                    child: Text(
                      "Select Topic Group",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: size.height * 0.02,
                      ),
                    ),
                  ),
                ],
              ),
              Divider(
                height: 5,
                color: Colors.black,
                endIndent: 25,
                indent: 25,
              ),
              CustomRadioButton("Concrete", 1, size),
              CustomRadioButton("Abstract", 2, size),
              CustomRadioButton("Quotes", 3, size),
              CustomRadioButton("Random", 4, size),
              SizedBox(
                height: size.height * 0.03,
              ),
              Row(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.06),
                    child: Text(
                      "Select Lightning Round Time",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: size.height * 0.02,
                      ),
                    ),
                  ),
                ],
              ),
              Divider(
                height: 5,
                color: Colors.black,
                endIndent: 25,
                indent: 25,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.01),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28)),
                  side: BorderSide(color: Colors.black),
                ),
                onPressed: () async {
                  time = await modalPopUpCustomTime(context);
                },
                child: SizedBox(
                  width: size.width * 0.8,
                  height: size.height * 0.05,
                  child: Center(
                    child: Text(
                      "Edit Time",
                      style: TextStyle(
                          color: Colors.black, fontSize: size.height * 0.02),
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.04),
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    lightningRoundTime = time;
                    topicGroupSelected = value;
                  });
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (BuildContext context) {
                    return LightningRounds();
                  }));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Confirm",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: size.height * 0.02,
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

  Widget CustomRadioButton(String text, int index, Size size) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: size.height * 0.01),
      child: OutlinedButton(
          onPressed: () {
            setState(() {
              value = index;
            });
          },
          child: SizedBox(
            width: size.width * 0.8,
            height: size.height * 0.05,
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  color: (value == index) ? Colors.cyan[600]! : Colors.black,
                  fontSize: size.height * 0.02,
                ),
              ),
            ),
          ),
          style: OutlinedButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
            side: BorderSide(
                color: (value == index) ? Colors.cyan[600]! : Colors.black),
          )),
    );
  }

  Future<int> modalPopUpCustomTime(context) async {
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: size.height * 0.04,
                    child: Text(
                      "Select Lightning Round Times",
                      style: TextStyle(fontSize: size.width * 0.05),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      Navigator.of(context).pop();
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
                initialTimerDuration: Duration(minutes: 1, seconds: 0),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    time = localTime == 0 ? 60 : localTime;
                  });
                  Navigator.of(context).pop();
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
      isDismissible: true,
      enableDrag: true,
      elevation: 15,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(MediaQuery.of(context).size.height * 0.02),
            topRight:
                Radius.circular(MediaQuery.of(context).size.height * 0.02)),
      ),
    );
    return time;
  }
}
