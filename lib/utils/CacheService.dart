class CacheService {
  Map<String, dynamic> _cache = {};

  dynamic read(String key) {
    return _cache[key];
  }

  void write(String key, dynamic value) {
    _cache[key] = value;
  }

  void delete(String key) {
    _cache.remove(key);
  }

  bool contains(String key) {
    return _cache.containsKey(key);
  }
}
