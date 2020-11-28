import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:vk_messenger_flutter/blocs/conversation/conversation_bloc.dart';
import 'package:vk_messenger_flutter/models/poll_result_update_item.dart';
import 'package:vk_messenger_flutter/services/interfaces/vk_service.dart';
import 'package:vk_messenger_flutter/services/service_locator.dart';

part 'long_polling_event.dart';
part 'long_polling_state.dart';

class LongPollingBloc extends Bloc<LongPollingEvent, LongPollingState> {
  static const LP_VERSION = '3';
  final VKService _vkService = locator<VKService>();
  final ConversationBloc _conversationBloc;

  String server;
  String key;
  int ts;

  LongPollingBloc(
    ConversationBloc conversationBloc,
  )   : _conversationBloc = conversationBloc,
        super(LongPollingInitial());

  @override
  Stream<LongPollingState> mapEventToState(
    LongPollingEvent event,
  ) async* {
    if (event is LongPollingPoll) {
      yield* _mapLongPollingPollToState(event);
    }
  }

  Stream<LongPollingState> _mapLongPollingPollToState(
      LongPollingPoll event) async* {
    try {
      if (event?.ts == null) {
        final result = await _vkService.getLongPollServer({
          'lp_version': LP_VERSION,
        });

        server = result?.response?.server;
        key = result?.response?.key;
        ts = result?.response?.ts;
      } else {
        ts = event.ts;
      }

      final pollUrl =
          'https://$server?act=a_check&key=$key&ts=${ts.toString()}&wait=25&mode=8&version=$LP_VERSION';

      _vkService.poll(pollUrl).then((pollResult) {
        final updates = pollResult?.updates ?? [];

        if (updates.length != 0) {
          updates.forEach((update) {
            switch (update?.code) {
              case PollResultCode.READ_IN_MSG:
              case PollResultCode.READ_OUT_MSG:
                _conversationBloc.add(
                  ConversationPollReadMessage(
                    update.field1,
                    update.field2,
                    update?.code == PollResultCode.READ_IN_MSG,
                  ),
                );
                break;
              case PollResultCode.SET_MSG_FLAG:
                _conversationBloc.add(ConversationPollProcessFlags(
                    update.field1, update.field2, update.field3));
                break;
              case PollResultCode.ADD_MSG:
                _conversationBloc.add(
                    ConversationPollAddMessage(update.field3, update.field1));
                break;
              case PollResultCode.EDIT_MSG:
                _conversationBloc.add(
                    ConversationPollEditMessage(update.field3, update.field1));
                break;
            }
          });
        }

        // Start new polling
        this.add(LongPollingPoll(pollResult?.ts));
      }).catchError((e) {
        this.add(LongPollingPoll());
      });
    } catch (e) {
      this.add(LongPollingPoll());
    }
  }
}
