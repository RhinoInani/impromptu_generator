import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:impromptu_generator2/components/soundRecorder.dart';
import 'package:wakelock/wakelock.dart';

import '../../userSettings.dart';

class SpeechRecorder extends StatefulWidget {
  const SpeechRecorder({Key? key, required this.randomTopic}) : super(key: key);
  final String randomTopic;

  @override
  State<SpeechRecorder> createState() => _SpeechRecorderState();
}

class _SpeechRecorderState extends State<SpeechRecorder> {
  final SoundRecorder recorder = SoundRecorder();
  CountDownController controller = CountDownController();
  bool _isListening = false;

  @override
  void initState() {
    recorder.init();
    super.initState();
  }

  @override
  void dispose() {
    recorder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[50],
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.cyan[50],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        children: [
          Text(
            widget.randomTopic,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: MediaQuery.of(context).size.height * 0.05,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.1),
            child: CircularCountDownTimer(
              controller: controller,
              duration: !customTime2! ? time2! * 60 : time2!,
              width: MediaQuery.of(context).size.height * 0.5,
              height: MediaQuery.of(context).size.height * 0.35,
              ringColor: Colors.white,
              fillColor: Colors.blue,
              autoStart: false,
              fillGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: [Colors.blue[900]!, Colors.cyan]),
              strokeWidth: 5.0,
              strokeCap: StrokeCap.round,
              textStyle: GoogleFonts.poppins(
                fontSize: MediaQuery.of(context).size.height * 0.06,
                color: Colors.black,
              ),
              isReverse: true,
              isReverseAnimation: true,
              onComplete: () async {
                Navigator.pop(context);
                setState(() {
                  Wakelock.disable();
                });
                if (vibrate!) {
                  await Future.delayed(Duration(milliseconds: 500));
                  HapticFeedback.vibrate();
                  await Future.delayed(Duration(milliseconds: 500));
                  HapticFeedback.vibrate();
                  await Future.delayed(Duration(milliseconds: 500));
                  HapticFeedback.vibrate();
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[600],
        onPressed: () async {
          final isRecorder = await recorder.toggleRecorder();
          setState(() {
            if (!_isListening) {
              controller.start();
            } else {
              controller.pause();
            }
            _isListening = !_isListening;
          });
        },
        child:
            Icon(_isListening ? CupertinoIcons.mic_solid : CupertinoIcons.mic),
      ),
    );
  }
}
