part of 'send_bloc.dart';

@immutable
abstract class SendEvent {}

class SendMessage extends SendEvent {
  final int peerId;
  final String message;

  SendMessage({
    @required this.peerId,
    @required this.message,
  });
}
