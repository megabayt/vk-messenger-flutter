class Message {
  final int id;
  final String text;

  Message({
    this.id,
    this.text,
  });

  Message copyWith({
    final int id,
    final String text,
  }) =>
      Message(
        id: id ?? this.id,
        text: text ?? this.text,
      );
}
