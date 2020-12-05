class SendMessageParams {
  int peerId;
  int randomId;
  int stickerId;
  String message;
  List<int> forwardMessages;
  List<String> attachment;
  double lat;
  double long;

  SendMessageParams({
    this.peerId,
    this.randomId,
    this.stickerId,
    this.message,
    this.forwardMessages,
    this.attachment,
    this.lat,
    this.long,
  });

  Map<String, String> toMap() {
    final map = Map<String, String>();
    if (peerId != null) {
      map['peer_id'] = peerId.toString();
    }
    if (randomId != null) {
      map['random_id'] = randomId.toString();
    }
    if (stickerId != null) {
      map['sticker_id'] = stickerId.toString();
    }
    if (message != null) {
      map['message'] = message;
    }
    if (forwardMessages != null) {
      map['forward_messages'] = forwardMessages.join(',');
    }
    if (attachment != null) {
      map['attachment'] = attachment.join(',');
    }
    if (lat != null) {
      map['lat'] = lat.toString();
    }
    if (long != null) {
      map['long'] = long.toString();
    }
    return map;
  }
}
