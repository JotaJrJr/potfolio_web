extension IterableGroupByExtension<T> on Iterable<T> {
  Map<K, List<T>> groupBy<K>(K Function(T) keySelector) {
    Map<K, List<T>> groupedMap = {};
    for (var element in this) {
      final key = keySelector(element);
      if (!groupedMap.containsKey(key)) {
        groupedMap[key] = [];
      }
      groupedMap[key]!.add(element);
    }
    return groupedMap;
  }
}

extension ListGroupByExtension<T> on List<T> {
  Map<K, List<T>> groupBy<K>(K Function(T) keySelector) {
    Map<K, List<T>> groupedMap = {};
    for (var element in this) {
      final key = keySelector(element);
      if (!groupedMap.containsKey(key)) {
        groupedMap[key] = [];
      }
      groupedMap[key]!.add(element);
    }
    return groupedMap;
  }
}
