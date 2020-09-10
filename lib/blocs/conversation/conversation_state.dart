part of 'conversation_bloc.dart';

@immutable
abstract class ConversationState {}

class ConversationData extends ConversationState {
  final int peerId;
  final Map<int, VkConversationResponse> data;
  final bool isFetching;
  final bool showEmojiKeyboard;
  final List<int> selectedMessagesIds;
  final List<int> fwdMessages;

  int get currentCount {
    return data != null && data.containsKey(peerId)
        ? data[peerId]?.count
        : null;
  }

  List<Message> get currentMessages {
    return data != null && data.containsKey(peerId)
        ? data[peerId]?.items
        : null;
  }

  List<Message> get selectedMessages {
    return currentMessages
        .where((message) =>
            selectedMessagesIds.indexWhere(
                (selectedMessage) => selectedMessage == message?.id) !=
            -1)
        .toList();
  }

  ConversationData({
    this.peerId,
    this.data,
    this.isFetching = false,
    this.showEmojiKeyboard = false,
    this.selectedMessagesIds = const [],
    this.fwdMessages = const [],
  });

  ConversationData copyWith({
    int peerId,
    Map<int, VkConversationResponse> data,
    bool isFetching,
    bool showEmojiKeyboard,
    List<int> selectedMessagesIds,
    List<int> fwdMessages,
  }) =>
      ConversationData(
        peerId: peerId ?? this.peerId,
        data: data ?? this.data,
        isFetching: isFetching ?? this.isFetching,
        showEmojiKeyboard: showEmojiKeyboard ?? this.showEmojiKeyboard,
        selectedMessagesIds: selectedMessagesIds ?? this.selectedMessagesIds,
        fwdMessages: fwdMessages ?? this.fwdMessages,
      );
}

class ConversationError extends ConversationState {
  final String message;

  ConversationError({@required this.message});
}
