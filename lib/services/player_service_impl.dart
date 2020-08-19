import 'dart:async';

import 'package:audioplayers/audioplayers.dart';

import 'package:vk_messenger_flutter/services/interfaces/player_service.dart';

class PlayerServiceImpl implements PlayerService {
  String _url;
  AudioPlayer _player = new AudioPlayer();
  AudioPlayerState _playerState;

  StreamSubscription<AudioPlayerState> subscribe(Function callback) {
    return _player.onPlayerStateChanged.listen(callback);
  }

  void setUrl(String newUrl) {
    _url = newUrl;
  }

  String getUrl() {
    return _url;
  }

  void setPlayerState(AudioPlayerState newState) {
    _playerState = newState;
  }

  AudioPlayerState getPlayerState() {
    return _playerState;
  }

  Function start(String newUrl) => () async {
        if (newUrl == _url && _playerState == AudioPlayerState.PAUSED) {
          _player.resume();
          return;
        }
        _url = newUrl;
        _player.play(_url);
      };

  Future<void> stop() async {
    _player.stop();
  }
}
