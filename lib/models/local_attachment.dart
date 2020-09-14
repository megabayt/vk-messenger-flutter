class LocalAttachment {
  final bool isFetching;
  final String path;

  LocalAttachment({
    this.isFetching = false,
    this.path,
  });

  LocalAttachment copyWith({
    final bool isFetching,
    final String path,
  }) =>
      LocalAttachment(
        isFetching: isFetching ?? this.isFetching,
        path: path ?? this.path,
      );
}
