class SaveVideoParams {
  final bool isPrivate;

  SaveVideoParams({
    this.isPrivate,
  });

  Map<String, String> toMap() {
    final map = Map<String, String>();
    if (isPrivate != null) {
      map['is_private'] = isPrivate ? '1' : '0';
    }
    return map;
  }
}
