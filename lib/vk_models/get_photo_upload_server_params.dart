class GetPhotoUploadServerParams {
  final int peerId;

  GetPhotoUploadServerParams({
    this.peerId,
  });

  Map<String, String> toMap() {
    final map = Map<String, String>();
    if (peerId != null) {
      map['peer_id'] = peerId.toString();
    }
    return map;
  }
}
