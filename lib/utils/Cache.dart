class _CacheService {
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

  // Other useful methods...
  void flush() {
    _cache.clear();
  }

  void flushExcept(List<String> keys) {
    _cache.removeWhere((key, value) => !keys.contains(key));
  }

  void flushStartsWith(String key) {
    _cache.removeWhere((key, value) => key.startsWith(key));
  }
}

final _CacheService cache = _CacheService();
