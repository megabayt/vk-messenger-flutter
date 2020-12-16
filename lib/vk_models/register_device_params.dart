import 'dart:convert';

class RegisterDeviceParams {
  final String token;
  final String deviceModel;
  final String deviceYear;
  final String deviceId;
  final String systemVersion;
  final Map<String, dynamic> settings;
  final int sandbox;
  final String pushProvider;

  RegisterDeviceParams({
    this.token,
    this.deviceModel,
    this.deviceYear,
    this.deviceId,
    this.systemVersion,
    this.settings,
    this.sandbox,
    this.pushProvider,
  });

  Map<String, String> toMap() {
    final map = Map<String, String>();
    if (token != null) {
      map['token'] = token;
    }
    if (deviceModel != null) {
      map['device_model'] = deviceModel;
    }
    if (deviceYear != null) {
      map['device_year'] = deviceYear;
    }
    if (deviceId != null) {
      map['device_id'] = deviceId;
    }
    if (systemVersion != null) {
      map['system_version'] = systemVersion;
    }
    if (settings != null) {
      map['settings'] = json.encode(settings);
    }
    if (sandbox != null) {
      map['sandbox'] = sandbox.toString();
    }
    if (pushProvider != null) {
      map['push_provider'] = pushProvider;
    }
    return map;
  }
}
