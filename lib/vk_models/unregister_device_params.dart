class UnregisterDeviceParams {
  final int deviceId;

  UnregisterDeviceParams({this.deviceId});

  Map<String, String> toMap() {
    final map = Map<String, String>();
    if (deviceId != null) {
      map['device_id'] = deviceId.toString();
    }
    return map;
  }
}
