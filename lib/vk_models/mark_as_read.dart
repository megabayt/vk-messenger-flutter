class MarkAsReadParams {
  final int peerId;
  final bool markConversationAsRead;

  MarkAsReadParams({
    this.peerId,
    this.markConversationAsRead,
  });

  Map<String, String> toMap() {
    final map = Map<String, String>();
    if (peerId != null) {
      map['peerId'] = peerId.toString();
    }
    if (markConversationAsRead != null) {
      map['mark_conversation_as_read'] = markConversationAsRead ? '1' : '0';
    }
    return map;
  }
}
