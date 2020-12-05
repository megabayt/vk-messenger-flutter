class VkError {
  VkError({
    this.errorCode,
    this.errorMsg,
    this.requestParams,
  });

  final int errorCode;
  final String errorMsg;
  final List<Map<String, dynamic>> requestParams;

  factory VkError.fromMap(Map<String, dynamic> json) => VkError(
        errorCode: json["error_code"] == null ? null : json["error_code"],
        errorMsg: json["error_msg"] == null ? null : json["error_msg"],
        requestParams: json["request_params"] == null
            ? null
            : List<Map<String, String>>.from(
                List<dynamic>.from(json["request_params"])
                    .map((e) => Map<String, String>.from(e))),
      );
}
