class DeleteMessagesParams {
  final List<int> messageIds;
  final bool deleteForAll;
  final int extended;

  DeleteMessagesParams({
    this.messageIds,
    this.deleteForAll,
    this.extended = 1,
  });

  Map<String, String> toMap() {
    final map = Map<String, String>();
    if (messageIds != null && messageIds is List<int>) {
      map['message_ids'] = messageIds.join(',');
    }
    if (deleteForAll != null) {
      map['delete_for_all'] = deleteForAll ? '1' : '0';
    }
    if (extended != null) {
      map['extended'] = extended.toString();
    }
    return map;
  }
}
