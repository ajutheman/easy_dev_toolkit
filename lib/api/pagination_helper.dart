// lib/api/pagination_helper.dart
typedef PageFetcher<T> = Future<List<T>> Function(int page, int pageSize);

class PaginationResult<T> {
  final List<T> items;
  final bool hasMore;

  PaginationResult({required this.items, required this.hasMore});
}

class Paginator<T> {
  final PageFetcher<T> fetcher;
  final int pageSize;
  int _page = 0;
  bool _loading = false;
  bool _hasMore = true;
  final List<T> _items = [];

  Paginator({required this.fetcher, this.pageSize = 20});

  /// Loads the next page of items.
  Future<PaginationResult<T>> loadNext() async {
    if (_loading || !_hasMore) {
      return PaginationResult(items: _items, hasMore: _hasMore);
    }
    _loading = true;
    _page += 1;
    try {
      final pageItems = await fetcher(_page, pageSize);
      _items.addAll(pageItems);
      _hasMore = pageItems.length == pageSize;
      return PaginationResult(
          items: List.unmodifiable(_items), hasMore: _hasMore);
    } finally {
      _loading = false;
    }
  }

  void reset() {
    _page = 0;
    _hasMore = true;
    _items.clear();
  }
}
