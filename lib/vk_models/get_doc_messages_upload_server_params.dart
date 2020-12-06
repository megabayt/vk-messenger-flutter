class GetDocMessagesUploadServerParams {
  final int peerId;
  final String type;

  GetDocMessagesUploadServerParams({
    this.peerId,
    this.type,
  });

  Map<String, String> toMap() {
    final map = Map<String, String>();
    if (peerId != null) {
      map['peer_id'] = peerId.toString();
    }
    if (type != null) {
      map['type'] = type;
    }
    return map;
  }
}
