import 'dart:async';

import 'package:audioplayers/audioplayers.dart';

abstract class PlayerService {
  StreamSubscription<AudioPlayerState> subscribe(Function callback);

  void setUrl(String newUrl);
  String getUrl();

  void setPlayerState(AudioPlayerState newState);
  AudioPlayerState getPlayerState();

  void start(String newUrl);
  Future<void> stop();
}
