class MarkAsReadParams {
  final int peerId;
  final bool markConversationAsRead;
  final int startMessageId;

  MarkAsReadParams({
    this.peerId,
    this.markConversationAsRead,
    this.startMessageId,
  });

  Map<String, String> toMap() {
    final map = Map<String, String>();
    if (peerId != null) {
      map['peer_id'] = peerId.toString();
    }
    if (markConversationAsRead != null) {
      map['mark_conversation_as_read'] = markConversationAsRead ? '1' : '0';
    }
    if (startMessageId != null) {
      map['start_message_id'] = startMessageId.toString();
    }
    return map;
  }
}
