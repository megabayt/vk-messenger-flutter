class GetLongPollServerParams {
  final int lpVersion;

  GetLongPollServerParams({
    this.lpVersion,
  });

  Map<String, String> toMap() {
    final map = Map<String, String>();
    if (lpVersion != null) {
      map['lp_version'] = lpVersion.toString();
    }
    return map;
  }
}
