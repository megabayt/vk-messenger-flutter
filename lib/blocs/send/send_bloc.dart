import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:vk_messenger_flutter/blocs/conversation/conversation_bloc.dart';
import 'package:vk_messenger_flutter/blocs/conversations/conversations_bloc.dart';
import 'package:vk_messenger_flutter/models/message.dart';
import 'package:vk_messenger_flutter/services/interfaces/vk_service.dart';
import 'package:vk_messenger_flutter/services/service_locator.dart';

part 'send_event.dart';
part 'send_state.dart';

class SendBloc extends Bloc<SendEvent, SendState> {
  final VKService _vkService = locator<VKService>();
  final ConversationsBloc _conversationsBloc;
  final ConversationBloc _conversationBloc;

  SendBloc(
      ConversationsBloc conversationsBloc, ConversationBloc conversationBloc)
      : _conversationsBloc = conversationsBloc,
        _conversationBloc = conversationBloc,
        super(SendInitial());

  @override
  Stream<SendState> mapEventToState(
    SendEvent event,
  ) async* {
    if (event is SendMessage) {
      yield* _mapSendMessageToState(event);
    }
  }

  Stream<SendState> _mapSendMessageToState(SendMessage event) async* {
    if (event.message == '') {
      return;
    }
    final int32max = 1 << 32;
    final randomId = Random.secure().nextInt(int32max);
    var message = Message(
      id: randomId,
      out: 1,
      text: event.message,
      peerId: event.peerId,
      fromId: _vkService.userId,
      date: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      isSent: false,
    );

    _conversationBloc.add(
      ConversationAppendOrReplaceMessage(
        randomId,
        message,
      ),
    );
    _conversationsBloc.add(
      ConversationsChangeLastMessage(
        message,
      ),
    );

    try {
      final id = await _vkService.sendMessage({
        'peer_id': event.peerId.toString(),
        'random_id': Random.secure().nextInt(int32max).toString(),
        'message': event.message,
      });

      message = message.copyWith(
        id: id,
        isSent: true,
      );
    } catch (e) {
      message = message.copyWith(
        isError: true,
      );
    }
    _conversationBloc.add(
      ConversationAppendOrReplaceMessage(
        randomId,
        message,
      ),
    );
    _conversationsBloc.add(
      ConversationsChangeLastMessage(
        message,
      ),
    );
  }
}

// + (attachments.length != 0 ? 'attachment=${attachments.join(',')}' : '')
// + (fwdMessages.length != 0 ? 'forward_messages=${fwdMessages.join(',')}' : '')
// + (replyTo != null ? 'reply_to=${replyTo.toString()}' : '');
