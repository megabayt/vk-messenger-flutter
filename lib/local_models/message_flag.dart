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
  UNKNOWN1,
  UNKNOWN2,
  UNKNOWN3,
  UNKNOWN4,
  UNKNOWN5,
  UNKNOWN6,
  DELETE_FOR_ALL,
  NOT_DELIVERED,
}

extension MessageFlags on int {
  List<MessageFlag> getMessageFlags() {
    List<MessageFlag> _flags = [];

    MessageFlag.values.forEach((element) {
      if (this & (1 << element.index) != 0) {
        _flags.add(element);
      }
    });

    return _flags;
  }
}
