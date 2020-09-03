part of 'conversations_bloc.dart';

@immutable
abstract class ConversationsState {}

class ConversationsData extends ConversationsState {
  final List<VkConversationItem> items;
  final int count;
  final bool isFetching;

  ConversationsData({
    this.items = const [],
    this.count = 0,
    this.isFetching = false,
  });

  ConversationsData copyWith({
    List<VkConversationItem> items,
    int count,
    bool isFetching,
  }) =>
      ConversationsData(
        items: items ?? this.items,
        count: count ?? this.count,
        isFetching: isFetching ?? this.isFetching,
      );
}

class ConversationsError extends ConversationsState {
  final String message;

  ConversationsError({@required this.message});
}
