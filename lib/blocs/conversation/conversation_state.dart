part of 'conversation_bloc.dart';

@immutable
abstract class ConversationState {}

class ConversationData extends ConversationState {
  final int peerId;
  final Map<int, VkConversationResponse> data;
  final bool isFetching;
  final bool showEmojiKeyboard;
  final List<int> selectedMessages;
  final List<int> fwdMessages;

  int get currentCount {
    return data != null && data.containsKey(peerId)
        ? data[peerId]?.count
        : null;
  }

  List<Message> get currentItems {
    return data != null && data.containsKey(peerId)
        ? data[peerId]?.items
        : null;
  }

  ConversationData({
    this.peerId,
    this.data,
    this.isFetching = false,
    this.showEmojiKeyboard = false,
    this.selectedMessages = const [],
    this.fwdMessages = const [],
  });

  ConversationData copyWith({
    int peerId,
    Map<int, VkConversationResponse> data,
    bool isFetching,
    bool showEmojiKeyboard,
    List<int> selectedMessages,
    List<int> fwdMessages,
  }) =>
      ConversationData(
        peerId: peerId ?? this.peerId,
        data: data ?? this.data,
        isFetching: isFetching ?? this.isFetching,
        showEmojiKeyboard: showEmojiKeyboard ?? this.showEmojiKeyboard,
        selectedMessages: selectedMessages ?? this.selectedMessages,
        fwdMessages: fwdMessages ?? this.fwdMessages,
      );
}

class ConversationError extends ConversationState {
  final String message;

  ConversationError({@required this.message});
}
