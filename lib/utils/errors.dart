class VKServiceError implements Exception {
  final _message;

  get message {
    return _message.toString();
  }

  VKServiceError([this._message]);

  @override
  String toString() {
    return _message;
  }
}
