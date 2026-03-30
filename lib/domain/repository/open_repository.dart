abstract interface class OpenRepository<T> {
  Future<T> openData();
}
