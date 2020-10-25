import 'package:meta/meta.dart';
import 'package:vk_messenger_flutter/models/doc.dart';

import 'package:vk_messenger_flutter/models/vk_error.dart';

class VkSaveDoc {
  VkSaveDoc({
    @required this.response,
    this.error,
  });

  final DocWrapper response;
  final VkError error;

  factory VkSaveDoc.fromJson(Map<String, dynamic> json) =>
      VkSaveDoc(
        response: json["response"] == null
            ? null
            : DocWrapper.fromJson(json["response"]),
        error: json["error"] == null ? null : VkError.fromJson(json["error"]),
      );

  Map<String, dynamic> toJson() => {
        "response": response == null ? null : response.toJson(),
        "error": error == null ? null : error.toJson(),
      };
}

class DocWrapper {
  DocWrapper({
    @required this.doc,
  });

  final Doc doc;

  factory DocWrapper.fromJson(Map<String, dynamic> json) =>
      DocWrapper(
        doc: json["doc"] == null
            ? null
            : Doc.fromJson(json["doc"]),
      );

  Map<String, dynamic> toJson() => {
        "doc": doc == null ? null : doc.toJson(),
      };
}