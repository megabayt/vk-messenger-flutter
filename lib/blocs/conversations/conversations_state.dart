part of 'conversations_bloc.dart';

@immutable
class ConversationsState {
  final List<VkConversationItem> items;
  final int count;
  final bool isFetching;
  final String error;
  final ConversationsEvent lastEvent;

  ConversationsState({
    this.items = const [],
    this.count = 0,
    this.isFetching = false,
    this.error,
    this.lastEvent,
  });

  ConversationsState copyWith({
    List<VkConversationItem> items,
    int count,
    bool isFetching,
    String error,
    ConversationsEvent lastEvent,
  }) =>
      ConversationsState(
        items: items ?? this.items,
        count: count ?? this.count,
        isFetching: isFetching ?? this.isFetching,
        error: error,
        lastEvent: lastEvent ?? this.lastEvent,
      );
}
