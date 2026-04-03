class PaginationResult<T> {
  final List<T> items;
  final bool hasMore;
  final int? nextPage;

  PaginationResult({
    required this.items,
    required this.hasMore,
    required this.nextPage,
  });
}
