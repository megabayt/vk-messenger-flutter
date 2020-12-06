import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:vk_messenger_flutter/local_models/attachment.dart';
import 'package:vk_messenger_flutter/local_models/attachment_audio.dart' as AttachmentAudioModel;
import 'package:vk_messenger_flutter/local_models/message.dart';
import 'package:vk_messenger_flutter/services/interfaces/player_service.dart';
import 'package:vk_messenger_flutter/services/service_locator.dart';

class AttachmentAudio extends StatefulWidget {
  @override
  _AttachmentAudioState createState() => _AttachmentAudioState();
}

class _AttachmentAudioState extends State<AttachmentAudio> {
  PlayerService _playerService = locator<PlayerService>();
  StreamSubscription<AudioPlayerState> _playerStateChangedSub;

  @override
  void initState() {
    _playerStateChangedSub = _playerService.subscribe(
      (AudioPlayerState s) => setState(
        () => _playerService.setPlayerState(s),
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    _playerStateChangedSub.cancel();
    super.dispose();
  }

  void _playTapHandler(BuildContext context) {
    final attachment = Provider.of<Attachment>(context, listen: false);

    final url = attachment?.url;

    if ((attachment as AttachmentAudioModel.AttachmentAudio).isContentRestricted) {
      final snackBar = SnackBar(
        content: Text(
          'Аудиозапись недоступна. Так решил музыкант или его представитель',
        ),
      );
      Scaffold.of(context).showSnackBar(snackBar);
      return;
    }

    if (_playerService.getUrl() != url ||
        _playerService.getPlayerState() != AudioPlayerState.PLAYING) {
      _playerService.start(url);
    } else {
      _playerService.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final message = Provider.of<Message>(context, listen: false);

    final me = message?.isOut == true;

    final attachment = Provider.of<Attachment>(context, listen: false);

    final url = attachment?.url;

    final captionTheme = Theme.of(context).textTheme.caption;

    return Row(
      children: <Widget>[
        _playerService.getUrl() != url ||
                _playerService.getPlayerState() != AudioPlayerState.PLAYING
            ? GestureDetector(
                onTap: () => _playTapHandler(context),
                child: Image(
                  image: ResizeImage(
                    AssetImage('assets/audio_play_small_2x.png'),
                    height: 30,
                  ),
                ),
              )
            : GestureDetector(
                onTap: () => _playTapHandler(context),
                child: Image(
                  image: ResizeImage(
                    AssetImage('assets/audio_pause_small_2x.png'),
                    height: 30,
                  ),
                ),
              ),
        Padding(
          padding: EdgeInsets.all(8.0),
        ),
        Text(
          attachment?.title ?? '',
          textAlign: me ? TextAlign.right : TextAlign.left,
          style: captionTheme,
        ),
      ],
    );
  }
}
