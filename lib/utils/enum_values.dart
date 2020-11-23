class EnumValues<T, K> {
  Map<K, T> map;
  Map<T, K> reverseMap;

  EnumValues(this.map);

  Map<T, K> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
