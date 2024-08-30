extension IterableExtensions<T> on Iterable<T> {
  /// Returns the first element that satisfies the given predicate.
  ///
  /// If no element satisfies the predicate, the result is `null`.
  T? elementAtOrNull(int index) => skip(index).firstOrNull;

  /// The first element satisfying [test], or `null` if there are none.
  T? firstWhereOrNull(bool Function(T element) test) {
    for (final element in this) {
      if (test(element)) return element;
    }
    return null;
  }
}
