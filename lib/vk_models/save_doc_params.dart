class SaveDocParams {
  final String file;
  final String title;

  SaveDocParams({
    this.file,
    this.title,
  });

  Map<String, String> toMap() {
    final map = Map<String, String>();
    if (file != null) {
      map['file'] = file;
    }
    if (title != null) {
      map['title'] = title;
    }
    return map;
  }
}
