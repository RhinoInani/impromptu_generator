// import 'package:flutter/cupertino.dart';
// import 'package:flutter_sound_lite/flutter_sound.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// String recordingFilePath = "impromptu_generator.wav";
//
// class SoundRecorder {
//   FlutterSoundRecorder? soundRecorder;
//   bool _initialized = false;
//   bool get isRecording => soundRecorder!.isRecording;
//
//   Future init() async {
//     soundRecorder = FlutterSoundRecorder();
//     final mic = await Permission.microphone.request();
//     if (mic.isDenied) {
//       throw RecordingPermissionException(
//           "Please go to settings and enable microphone permissions to use this feature");
//     }
//     final documents = await Permission.storage.request();
//     print(documents.isDenied);
//
//     await soundRecorder!.openAudioSession();
//     _initialized = true;
//   }
//
//   Future dispose() async {
//     if (!_initialized) return;
//     soundRecorder!.closeAudioSession();
//     soundRecorder = null;
//     _initialized = false;
//   }
//
//   Future record() async {
//     if (!_initialized) return;
//     await soundRecorder!.startRecorder(toFile: recordingFilePath);
//   }
//
//   Future stop() async {
//     if (!_initialized) return;
//     await soundRecorder!.stopRecorder();
//   }
//
//   Future toggleRecorder() async {
//     if (soundRecorder!.isStopped) {
//       await record();
//     } else {
//       await stop();
//     }
//   }
// }
//
// class SoundPlayer {
//   FlutterSoundPlayer? _audioPlayer;
//
//   Future init() async {
//     _audioPlayer = FlutterSoundPlayer();
//     _audioPlayer!.openAudioSession();
//   }
//
//   Future dispose() async {
//     _audioPlayer!.closeAudioSession();
//     _audioPlayer = null;
//   }
//
//   Future _play(VoidCallback whenFinished) async {
//     await _audioPlayer!
//         .startPlayer(fromURI: recordingFilePath, whenFinished: whenFinished);
//   }
//
//   Future _stop() async {
//     await _audioPlayer!.stopPlayer();
//   }
//
//   Future togglePlayer(VoidCallback whenFinished) async {
//     if (_audioPlayer!.isStopped) {
//       await _play(whenFinished);
//     } else {
//       await _stop();
//     }
//   }
// }
