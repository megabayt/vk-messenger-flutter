class GetMessagesParams {
  final List<int> messageIds;
  final int extended;

  GetMessagesParams({
    this.messageIds,
    this.extended = 1,
  });

  Map<String, String> toMap() {
    final map = Map<String, String>();
    if (messageIds != null && messageIds is List<int>) {
      map['message_ids'] = messageIds.join(',');
    }
    if (extended != null) {
      map['extended'] = extended.toString();
    }
    return map;
  }
}
