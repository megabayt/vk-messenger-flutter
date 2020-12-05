class GetHistoryParams {
  final int count;
  final int offset;
  final int peerId;
  final int extended;

  GetHistoryParams({
    this.count,
    this.offset,
    this.peerId,
    this.extended = 1,
  });

  Map<String, String> toMap() {
    final map = Map<String, String>();
    if (count != null) {
      map['count'] = count.toString();
    }
    if (offset != null) {
      map['offset'] = offset.toString();
    }
    if (peerId != null) {
      map['peer_id'] = peerId.toString();
    }
    if (extended != null) {
      map['extended'] = extended.toString();
    }
    return map;
  }
}
