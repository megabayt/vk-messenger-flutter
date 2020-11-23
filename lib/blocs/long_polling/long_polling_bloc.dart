import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:vk_messenger_flutter/models/poll_result_update_item.dart';

import 'package:vk_messenger_flutter/services/interfaces/vk_service.dart';
import 'package:vk_messenger_flutter/services/service_locator.dart';

part 'long_polling_event.dart';
part 'long_polling_state.dart';

class LongPollingBloc extends Bloc<LongPollingEvent, LongPollingState> {
  final VKService _vkService = locator<VKService>();
  static const LP_VERSION = '3';
  String server;
  String key;
  int ts;

  LongPollingBloc() : super(LongPollingInitial());

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

      _vkService
          .poll(
        'https://$server?act=a_check&key=$key&ts=${ts.toString()}&wait=25&mode=10&version=$LP_VERSION',
      )
          .then((pollResult) {
        final updates = pollResult?.updates ?? [];

        if (updates.length != 0) {
          updates.forEach((update) {
            switch (update?.code) {
              // TODO: Use poll updates
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
