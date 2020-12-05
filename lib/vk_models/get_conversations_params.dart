class GetConversationsParams {
  final int count;
  final int offset;
  final int extended;

  GetConversationsParams({
    this.count,
    this.offset,
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
    if (extended != null) {
      map['extended'] = extended.toString();
    }
    return map;
  }
}
