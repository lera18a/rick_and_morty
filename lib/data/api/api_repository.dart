abstract interface class ApiRepository<T, K> {
  Future<T> getAll();
  Future<K> getFromId(int id);
}
