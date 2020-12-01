part of 'conversations_bloc.dart';

@immutable
class ConversationsState {
  final List<Conversation> conversations;
  final int count;
  final bool isFetching;
  final String error;
  final ConversationsEvent lastEvent;
  final Map<int, int> conversationsMap;

  ConversationsState({
    this.conversations = const [],
    this.count = 0,
    this.isFetching = false,
    this.error = '',
    this.lastEvent,
  }) : conversationsMap = (() {
          int index = 0;
          return conversations.fold(
            Map<int, int>(),
            (map, conversation) {
              map[conversation.id] = index++;
              return map;
            },
          );
        })();

  Conversation getById(int id) {
    final index = getIndexById(id);

    if (index == -1) {
      return null;
    }

    return conversations[index];
  }

  int getIndexById(int id) {
    return conversationsMap == null ? null : conversationsMap[id] ?? -1;
  }

  ConversationsState copyWith({
    List<Conversation> conversations,
    int count,
    bool isFetching,
    String error,
    ConversationsEvent lastEvent,
  }) =>
      ConversationsState(
        conversations: conversations ?? this.conversations,
        count: count ?? this.count,
        isFetching: isFetching ?? this.isFetching,
        error: error ?? this.error,
        lastEvent: lastEvent ?? this.lastEvent,
      );
}
