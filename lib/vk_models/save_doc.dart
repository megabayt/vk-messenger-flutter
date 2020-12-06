import 'package:vk_messenger_flutter/vk_models/doc.dart';

class VkSaveDoc {
  VkSaveDoc({
    this.doc,
  });

  final VkDoc doc;

  factory VkSaveDoc.fromMap(Map<String, dynamic> json) => VkSaveDoc(
        doc: json["doc"] == null ? null : VkDoc.fromMap(json["doc"]),
      );
}
