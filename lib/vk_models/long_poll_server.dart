class VkLongPollServer {
  VkLongPollServer({
    this.key,
    this.server,
    this.ts,
  });

  final String key;
  final String server;
  final int ts;

  factory VkLongPollServer.fromMap(Map<String, dynamic> json) =>
      VkLongPollServer(
        key: json["key"] == null ? null : json["key"],
        server: json["server"] == null ? null : json["server"],
        ts: json["ts"] == null ? null : json["ts"],
      );
}
