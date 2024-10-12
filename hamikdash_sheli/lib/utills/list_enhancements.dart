
extension ListEnhancements<E> on List<E> {
  E? findFirst(bool Function(E element) test) {
    var result = where(test);
    return result.isNotEmpty ? result.first : null;
  }

}
