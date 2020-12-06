class GetFriendsParams {
  final int count;
  final int offset;
  final int userId;
  final String order;
  final String fields;

  GetFriendsParams({
    this.count,
    this.offset,
    this.userId,
    this.order,
    this.fields,
  });

  Map<String, String> toMap() {
    final map = Map<String, String>();
    if (count != null) {
      map['count'] = count.toString();
    }
    if (offset != null) {
      map['offset'] = offset.toString();
    }
    if (userId != null) {
      map['user_id'] = userId.toString();
    }
    if (order != null) {
      map['order'] = order;
    }
    if (fields != null) {
      map['fields'] = fields;
    }
    return map;
  }
}
