import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:flutter_sound_lite/public/flutter_sound_recorder.dart';
import 'package:permission_handler/permission_handler.dart';

final String filePathName = "impromptu_generator_recorder";

class SoundRecorder {
  FlutterSoundRecorder? soundRecorder;
  bool _initialized = false;
  bool get isRecording => soundRecorder!.isRecording;

  Future init() async {
    soundRecorder = FlutterSoundRecorder();

    final mic = await Permission.microphone.request();
    if (mic.isDenied) {
      throw RecordingPermissionException(
          "Please go to settings and enable microphone permissions to use this feature");
    }

    await soundRecorder!.openAudioSession();
    _initialized = true;
  }

  Future dispose() async {
    if (!_initialized) return;
    soundRecorder!.closeAudioSession();
    soundRecorder = null;
    _initialized = false;
  }

  Future _record() async {
    if (!_initialized) return;
    await soundRecorder!.startRecorder(toFile: filePathName);
  }

  Future _stop() async {
    if (!_initialized) return;
    await soundRecorder!.stopRecorder();
  }

  Future toggleRecorder() async {
    if (soundRecorder!.isStopped) {
      await _record();
    } else {
      await _stop();
    }
  }
}
