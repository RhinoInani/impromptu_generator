import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:impromptu_generator2/components//topicCard.dart';

class ChooseTopic extends StatelessWidget {
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
                  topic: topic1,
                  topic1: topic1,
                  topic2: topic2,
                  topic3: topic3,
                  fontSize: fontSize,
                  maxLines: maxLines,
                ),
                TopicCard(
                  topic: topic2,
                  topic1: topic2,
                  topic2: topic1,
                  topic3: topic3,
                  fontSize: fontSize,
                  maxLines: maxLines,
                ),
                TopicCard(
                  topic: topic3,
                  topic1: topic3,
                  topic2: topic1,
                  topic3: topic2,
                  fontSize: fontSize,
                  maxLines: maxLines,
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