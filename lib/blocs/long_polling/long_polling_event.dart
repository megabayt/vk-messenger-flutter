part of 'long_polling_bloc.dart';

@immutable
abstract class LongPollingEvent {}

class LongPollingPoll extends LongPollingEvent {
  final int ts;

  LongPollingPoll([this.ts]);
}
