class VkDocUploadResult {
  VkDocUploadResult({
    this.file,
  });

  final String file;

  factory VkDocUploadResult.fromMap(Map<String, dynamic> json) =>
      VkDocUploadResult(
        file: json["file"] == null ? null : json["file"],
      );
}
