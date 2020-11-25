class MessageFlags {
  static getFlags(int mask) {
    List<MessageFlag> _flags = [];
    MessageFlag.values.forEach((element) {
      if (mask & (1 << element.index) != 0) {
        _flags.add(element);
      }
    });
    return _flags;
  }
}

enum MessageFlag {
  OUTBOX,
  UNREAD,
  REPLIED,
  IMPORTANT,
  CHAT,
  FRIENDS,
  SPAM,
  DELETED,
  FIXED,
  MEDIA,
  HIDDEN,
  DELETE_FOR_ALL,
  NOT_DELIVERED,
}
