import 'dart:async';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:share/share.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechToTextScreen extends StatefulWidget {
  @required final int time;
  @required final String randomTopic;

  const SpeechToTextScreen({Key key, this.time, this.randomTopic}) : super(key: key);
  @override
  _SpeechToTextScreenState createState() => _SpeechToTextScreenState();
}

class _SpeechToTextScreenState extends State<SpeechToTextScreen>
    with SingleTickerProviderStateMixin {
  Timer timer;
  AnimationController _animationController;

  // TimerController _timerController;
  // TimerStyle _timerStyle = TimerStyle.ring;
  // TimerProgressIndicatorDirection _progressIndicatorDirection = TimerProgressIndicatorDirection.clockwise;
  // TimerProgressTextCountDirection _progressTextCountDirection = TimerProgressTextCountDirection.count_down;
  // void initState() {
  //   _animationController =  AnimationController(vsync: this, duration: Duration(seconds: 5), reverseDuration: Duration(milliseconds: 100));
  //   _animationController.repeat(reverse: true);
  //   _animationController.forward();
  //   super.initState();
  // }
  final Map<String, HighlightedWord> _highlights = {
    'voice': HighlightedWord(
      onTap: () => print('voice'),
      textStyle: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    ),
    'like': HighlightedWord(
      onTap: () => print('like'),
      textStyle: const TextStyle(
        color: Colors.blueAccent,
        fontWeight: FontWeight.bold,
      ),
    ),
    'uh': HighlightedWord(
      onTap: () => print('uh'),
      textStyle: const TextStyle(
        color: Colors.blueAccent,
        fontWeight: FontWeight.bold,
      ),
    ),
    'and': HighlightedWord(
      onTap: () => print('and'),
      textStyle: const TextStyle(
        color: Colors.blueAccent,
        fontWeight: FontWeight.bold,
      ),
    ),
  };

  stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Press the button and start speaking';
  double _confidence = 1.0;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(seconds: 5),
        reverseDuration: Duration(milliseconds: 100));
    _animationController.repeat(reverse: true);
    _animationController.forward();
    super.initState();
    _speech = stt.SpeechToText();
  }

  void autoPress() {
    timer = new Timer(Duration(seconds: 10), () {
      print("prints after 10 seconds");
    });
  }

  String statusText = "";
  bool isComplete = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[50],
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          'Confidence ${(_confidence * 100.0).toStringAsFixed(1)}%',
          style: GoogleFonts.poppins(color: Colors.black),
        ),
        backgroundColor: Colors.cyan[50],
        elevation: 0,
        actions: [
          Row(
            children: [
              IconButton(
                icon: Icon(CupertinoIcons.share),
                color: Colors.black,
                iconSize: MediaQuery.of(context).size.height * 0.035,
                focusColor: Colors.transparent,
                splashColor: Colors.transparent,
                splashRadius: 1,
                onPressed: () {
                  Share.share('Speech: $_text, Confidence: ${_confidence*100}');
                },
              ),
              SizedBox(
                width: 10,
              )
            ],
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: _isListening,
        glowColor: Colors.blue[500],
        endRadius: 45,
        duration: const Duration(milliseconds: 2000),
        repeatPauseDuration: const Duration(milliseconds: 100),
        repeat: true,
        child: FloatingActionButton(
          backgroundColor: Colors.blue[500],
          onPressed: _listen,
          child: Icon(
              _isListening ? CupertinoIcons.mic_solid : CupertinoIcons.mic),
        ),
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          reverse: true,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  Text(
                    widget.randomTopic,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: MediaQuery.of(context).size.height * 0.05,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: CircularCountDownTimer(
                      duration: widget.time*60,
                      width: MediaQuery.of(context).size.height * 0.5,
                      height: MediaQuery.of(context).size.height * 0.25,
                      color: Colors.white,
                      fillColor: Colors.blue,
                      isReverseAnimation: true,
                      strokeWidth: 5.0,
                      textStyle: GoogleFonts.poppins(
                        fontSize: MediaQuery.of(context).size.height * 0.04,
                        color: Colors.black,
                      ),
                      isReverse: true,
                      onComplete: (){
                        setState(() {
                          _isListening = false;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 130.0),
                      child: TextHighlight(
                        text: _text,
                        words: _highlights,
                        textStyle: GoogleFonts.poppins(
                          fontSize: MediaQuery.of(context).size.height * 0.04,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    "currently in beta testing, \nplease report any found issues using the report an issue form",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: MediaQuery.of(context).size.height * 0.01
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  void _listen() async {
    HapticFeedback.mediumImpact();
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
