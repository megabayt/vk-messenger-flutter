import 'dart:convert';

class VkError {
  VkError({
    this.errorCode,
    this.errorMsg,
    this.requestParams,
  });

  final int errorCode;
  final String errorMsg;
  final List<Map<String, dynamic>> requestParams;

  factory VkError.fromRawJson(String str) => VkError.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VkError.fromJson(Map<String, dynamic> json) => VkError(
        errorCode: json["error_code"] == null ? null : json["error_code"],
        errorMsg: json["error_msg"] == null ? null : json["error_msg"],
        requestParams: json["request_params"] == null
            ? null
            : List<Map<String, String>>.from(
                List<dynamic>.from(json["request_params"])
                    .map((e) => Map<String, String>.from(e))),
      );

  Map<String, dynamic> toJson() => {
        "error_code": errorCode == null ? null : errorCode,
        "error_msg": errorMsg == null ? null : errorMsg,
        "request_params": requestParams == null ? null : requestParams,
      };
}
