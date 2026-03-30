abstract interface class Repository<T> {
  Future<List<T>> getAll();
  Future<void> cached(List<T> entities);
  Future<T?> getByID(int entityID);
  Future<void> clearCache();
}
