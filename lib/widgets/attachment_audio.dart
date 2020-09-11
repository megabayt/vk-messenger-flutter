import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:vk_messenger_flutter/models/attachment.dart';
import 'package:vk_messenger_flutter/models/message.dart';
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

  @override
  Widget build(BuildContext context) {
    final message = Provider.of<Message>(context, listen: false);

    final me = message?.out == 1;

    final attachment = Provider.of<Attachment>(context, listen: false);

    final url = attachment?.audio?.url;

    final captionTheme = Theme.of(context).textTheme.caption;

    return Row(
      children: <Widget>[
        _playerService.getUrl() != url ||
                _playerService.getPlayerState() != AudioPlayerState.PLAYING
            ? GestureDetector(
                onTap: () => _playerService.start(url),
                child: Image(
                  image: ResizeImage(
                    AssetImage('assets/audio_play_small_2x.png'),
                    height: 30,
                  ),
                ),
              )
            : GestureDetector(
                onTap: _playerService.stop,
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
          '${attachment.audio?.artist ?? ''} - ${attachment.audio?.title ?? ''}',
          textAlign: me ? TextAlign.right : TextAlign.left,
          style: captionTheme,
        ),
      ],
    );
  }
}
