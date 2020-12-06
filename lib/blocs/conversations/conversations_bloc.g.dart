// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversations_bloc.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension ConversationsStateCopyWith on ConversationsState {
  ConversationsState copyWith({
    List<Conversation> conversations,
    int count,
    String error,
    bool isFetching,
    ConversationsEvent lastEvent,
  }) {
    return ConversationsState(
      conversations: conversations ?? this.conversations,
      count: count ?? this.count,
      error: error ?? this.error,
      isFetching: isFetching ?? this.isFetching,
      lastEvent: lastEvent ?? this.lastEvent,
    );
  }
}
