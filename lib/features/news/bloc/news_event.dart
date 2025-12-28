abstract class NewsEvent {
  const NewsEvent();
}

/// Fetch category-based news (pagination supported)
class FetchNews extends NewsEvent {
  final String category;
  final bool refresh;

  const FetchNews({
    required this.category,
    this.refresh = false,
  });
}

/// Pull-to-refresh
class RefreshNews extends NewsEvent {
  final String category;

  const RefreshNews({required this.category});
}

/// Search news articles
class SearchNews extends NewsEvent {
  final String query;

  const SearchNews({required this.query});
}

/// Refresh current category (Global)
class RefreshCurrentCategory extends NewsEvent {
  const RefreshCurrentCategory();
}
