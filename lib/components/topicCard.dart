import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:impromptu_generator2/screens/speechScreens/timerScreen1.dart';
import 'package:impromptu_generator2/userSettings.dart';
import 'package:wakelock/wakelock.dart';

class TopicCard extends StatefulWidget {
  const TopicCard({
    Key key,
    @required this.topic1,
    @required this.topic2,
    @required this.topic3,
    @required this.fontSize,
    @required this.topic,
    @required this.maxLines,
    @required this.timeRe,
  }) : super(key: key);

  final String topic;
  final String topic1;
  final String topic2;
  final String topic3;
  final double fontSize;
  final int maxLines;
  final int timeRe;

  @override
  _TopicCardState createState() => _TopicCardState();
}

class _TopicCardState extends State<TopicCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.09,
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              border: Border.all(color: Colors.black45),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    offset: Offset(0, 5),
                    spreadRadius: 6,
                    blurRadius: 20,
                    color: Colors.grey[400]),
              ]),
          child: GestureDetector(
            onTap: () {
              Wakelock.enable();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return TimerScreen1(
                      randomTopic: widget.topic1,
                      randomTopic2: widget.topic2,
                      randomTopic3: widget.topic3,
                      fontSize: widget.fontSize,
                    );
                  },
                ),
              );
              setState(() {
                Wakelock.enabled;
                timeRemaining == 0
                    ? timeRemaining = 0
                    : timeRemaining =
                        (!customTime1 ? time1 * 60 : time1) - widget.timeRe;
              });
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.9,
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: AutoSizeText(
                "${widget.topic}",
                maxLines: (widget.maxLines),
                softWrap: true,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize:
                      MediaQuery.of(context).size.height * widget.fontSize,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
