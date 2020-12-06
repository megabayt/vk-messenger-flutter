import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:vk_messenger_flutter/blocs/conversation/conversation_bloc.dart';
import 'package:vk_messenger_flutter/blocs/profiles/profiles_bloc.dart';
import 'package:vk_messenger_flutter/vk_models/get_long_poll_server_params.dart';
import 'package:vk_messenger_flutter/vk_models/poll_result_code.dart';
import 'package:vk_messenger_flutter/services/interfaces/vk_service.dart';
import 'package:vk_messenger_flutter/services/service_locator.dart';

part 'long_polling_event.dart';
part 'long_polling_state.dart';

class LongPollingBloc extends Bloc<LongPollingEvent, LongPollingState> {
  static const LP_VERSION = 3;
  final VKService _vkService = locator<VKService>();
  final ConversationBloc _conversationBloc;
  final ProfilesBloc _profilesBloc;

  String server;
  String key;
  int ts;

  LongPollingBloc(
    ConversationBloc conversationBloc,
    ProfilesBloc profilesBloc,
  )   : _conversationBloc = conversationBloc,
        _profilesBloc = profilesBloc,
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
        final result =
            await _vkService.getLongPollServer(GetLongPollServerParams(
          lpVersion: LP_VERSION,
        ));

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
              case VkPollResultCode.READ_IN_MSG:
              case VkPollResultCode.READ_OUT_MSG:
                _conversationBloc.add(
                  ConversationPollReadMessage(
                    update.field1,
                    update.field2,
                    update.code == VkPollResultCode.READ_IN_MSG,
                  ),
                );
                break;
              case VkPollResultCode.SET_MSG_FLAG:
                _conversationBloc.add(ConversationPollProcessFlags(
                    update.field1, update.field2, update.field3));
                break;
              case VkPollResultCode.ADD_MSG:
                _conversationBloc.add(
                    ConversationPollAddMessage(update.field3, update.field1));
                break;
              case VkPollResultCode.EDIT_MSG:
                _conversationBloc.add(
                    ConversationPollEditMessage(update.field3, update.field1));
                break;
              case VkPollResultCode.FRIEND_ONLINE:
              case VkPollResultCode.FRIEND_OFFLINE:
                _profilesBloc.add(ProfilesSetOnline(
                  -(update.field1 as int),
                  update.code == VkPollResultCode.FRIEND_ONLINE,
                ));
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
