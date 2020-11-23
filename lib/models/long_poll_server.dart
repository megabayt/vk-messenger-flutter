class LongPollServer {
  LongPollServer({
    this.key,
    this.server,
    this.ts,
  });

  final String key;
  final String server;
  final int ts;

  factory LongPollServer.fromJson(Map<String, dynamic> json) => LongPollServer(
        key: json["key"] == null ? null : json["key"],
        server: json["server"] == null ? null : json["server"],
        ts: json["ts"] == null ? null : json["ts"],
      );

  Map<String, dynamic> toJson() => {
        "key": key == null ? null : key,
        "server": server == null ? null : server,
        "ts": ts == null ? null : ts,
      };
}
