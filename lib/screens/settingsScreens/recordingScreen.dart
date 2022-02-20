// import 'dart:async';
//
// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:circular_countdown_timer/circular_countdown_timer.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:impromptu_generator2/components/sound.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:wakelock/wakelock.dart';
//
// import '../../userSettings.dart';
//
// class SpeechRecorder extends StatefulWidget {
//   const SpeechRecorder({Key? key, required this.randomTopic}) : super(key: key);
//   final String randomTopic;
//
//   @override
//   State<SpeechRecorder> createState() => _SpeechRecorderState();
// }
//
// class _SpeechRecorderState extends State<SpeechRecorder> {
//   final SoundRecorder recorder = SoundRecorder();
//   final player = SoundPlayer();
//
//   CountDownController controller = CountDownController();
//   bool _isRecording = true;
//   bool _isPause = false;
//   int counter = 0;
//
//   void requestPersmission() async {
//     await Permission.storage.request();
//     final documents = await getApplicationDocumentsDirectory();
//     documents.path;
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     recorder.init();
//     player.init();
//     requestPersmission();
//     Timer(Duration(milliseconds: 10), () async {
//       startTimer();
//     });
//   }
//
//   @override
//   void dispose() {
//     recorder.stop();
//     recorder.dispose();
//     player.dispose();
//     super.dispose();
//   }
//
//   Future<void> startTimer() async {
//     await recorder.init();
//     await recorder.record();
//     controller.start();
//   }
//
//   Future<String> get _localPath async {
//     final directory = await getApplicationDocumentsDirectory();
//     return directory.path;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.cyan[50],
//         elevation: 0,
//         iconTheme: IconThemeData(color: Colors.black),
//         actions: [
//           // counter < 2
//           //     ? Container()
//           //     : Row(
//           //         children: [
//           //           IconButton(
//           //             icon: Icon(CupertinoIcons.share),
//           //             color: Colors.black,
//           //             iconSize: MediaQuery.of(context).size.height * 0.035,
//           //             focusColor: Colors.transparent,
//           //             splashColor: Colors.transparent,
//           //             splashRadius: 1,
//           //             onPressed: () async {
//           //               final path = await _localPath;
//           //               print("$path/$recordingFilePath");
//           //               Share.shareFiles(
//           //                 ['$path/$recordingFilePath'],
//           //               );
//           //             },
//           //           ),
//           //           SizedBox(
//           //             width: 10,
//           //           )
//           //         ],
//           //       ),
//         ],
//       ),
//       backgroundColor: Colors.cyan[50],
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           SizedBox(height: MediaQuery.of(context).size.height * 0.07),
//           Container(
//             width: MediaQuery.of(context).size.width * 0.9,
//             child: AutoSizeText(
//               "${widget.randomTopic}",
//               textAlign: TextAlign.center,
//               style: GoogleFonts.poppins(
//                   fontSize: MediaQuery.of(context).size.height * 0.06,
//                   fontWeight: FontWeight.bold),
//               maxLines: widget.randomTopic.toString().length < 15 ? 1 : 3,
//             ),
//           ),
//           SizedBox(height: MediaQuery.of(context).size.height * 0.07),
//           _isRecording
//               ? CircularCountDownTimer(
//                   controller: controller,
//                   duration: !customTime2! ? time2! * 60 : time2!,
//                   width: MediaQuery.of(context).size.height * 0.5,
//                   height: MediaQuery.of(context).size.height * 0.35,
//                   ringColor: Colors.white,
//                   fillColor: Colors.blue,
//                   autoStart: false,
//                   fillGradient: LinearGradient(
//                       begin: Alignment.topLeft,
//                       end: Alignment.topRight,
//                       colors: [Colors.blue[900]!, Colors.cyan]),
//                   strokeWidth: 5.0,
//                   strokeCap: StrokeCap.round,
//                   textStyle: GoogleFonts.poppins(
//                     fontSize: MediaQuery.of(context).size.height * 0.06,
//                     color: Colors.black,
//                   ),
//                   isReverse: true,
//                   isReverseAnimation: true,
//                   onComplete: () async {
//                     await recorder.toggleRecorder();
//                     setState(() {
//                       _isRecording = false;
//                       Wakelock.disable();
//                     });
//                     if (vibrate!) {
//                       await Future.delayed(Duration(milliseconds: 500));
//                       HapticFeedback.vibrate();
//                       await Future.delayed(Duration(milliseconds: 500));
//                       HapticFeedback.vibrate();
//                       await Future.delayed(Duration(milliseconds: 500));
//                       HapticFeedback.vibrate();
//                     }
//                   },
//                 )
//               : Center(
//                   child: OutlinedButton.icon(
//                     style: OutlinedButton.styleFrom(
//                       primary: Colors.black,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(30))),
//                       shadowColor: Colors.grey[100],
//                     ),
//                     onPressed: () async {
//                       await player.togglePlayer(() {});
//                     },
//                     icon: Icon(Icons.play_arrow_rounded),
//                     label: Text(
//                       "listen to your speech",
//                       style: TextStyle(
//                         fontSize: MediaQuery.of(context).size.height * 0.03,
//                       ),
//                     ),
//                   ),
//                 ),
//         ],
//       ),
//       floatingActionButton: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           _isRecording
//               ? FloatingActionButton(
//                   backgroundColor: Colors.blue[600],
//                   onPressed: () async {
//                     await recorder.toggleRecorder();
//                     setState(() {
//                       _isRecording = false;
//                     });
//                   },
//                   child: Icon(CupertinoIcons.mic_fill),
//                 )
//               : Container(),
//           playPause! && _isRecording
//               ? FloatingActionButton.extended(
//                   heroTag: null,
//                   backgroundColor: Colors.blue[600],
//                   onPressed: () {
//                     HapticFeedback.mediumImpact();
//                     setState(() {
//                       if (_isPause) {
//                         _isPause = false;
//                         controller.resume();
//                       } else {
//                         _isPause = true;
//                         controller.pause();
//                       }
//                     });
//                   },
//                   icon: Icon(_isPause ? Icons.play_arrow : Icons.pause),
//                   label: Text(
//                     _isPause ? "Resume" : "Pause",
//                     style: GoogleFonts.poppins(),
//                   ))
//               : Container()
//         ],
//       ),
//     );
//   }
// }
