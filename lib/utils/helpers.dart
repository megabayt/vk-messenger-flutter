import 'dart:core';

String serialize(Map<String, String> params) {
  String result = '';
  params.forEach((key, value) {
    result = '$result&$key=${Uri.encodeComponent(value)}';
  });
  return result;
}

dynamic mapPath(dynamic object, List<dynamic> path) {
  var result = object;

  final pathOk = path.every((key) {
    if (object is! Map<String, dynamic> && object is! List<dynamic>) {
      return false;
    }
    if (key is int && (result is! List<dynamic> || key > result.length - 1)) {
      return false;
    }
    if (result[key] != null) {
      result = result[key];
      return true;
    }
    return false;
  });

  if (!pathOk) {
    return null;
  }

  return result;
}

void noop() {}
