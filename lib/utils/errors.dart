class VKServiceError implements Exception {
  final _message;

  VKServiceError([this._message]);

  @override
  String toString() {
    return _message;
  }
}
