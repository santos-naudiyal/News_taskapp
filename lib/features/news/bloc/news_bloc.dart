import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/features/news/data/models/article.dart';
import 'package:news_app/features/news/data/repo/news_repository.dart';


import 'news_event.dart';
import 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository repository;

  int _page = 1;
  bool _hasReachedMax = false;
  String _currentCategory = '';
  String _currentQuery = '';
  bool _isSearchMode = false;

  NewsBloc(this.repository) : super(const NewsLoading()) {
    on<FetchNews>(_onFetchNews);
    on<RefreshNews>(_onRefreshNews);
    on<SearchNews>(_onSearchNews);
  }

  /// -----------------------------
  /// CATEGORY / PAGINATION
  /// -----------------------------
  Future<void> _onFetchNews(
    FetchNews event,
    Emitter<NewsState> emit,
  ) async {
    try {
      if (event.refresh || event.category != _currentCategory) {
        _page = 1;
        _hasReachedMax = false;
        _currentCategory = event.category;
        _isSearchMode = false;
        emit(const NewsLoading());
      }

      if (_hasReachedMax) return;

      final List<ArticleModel> articles =
          await repository.fetchNews(
        category: event.category,
        page: _page,
      );

      _page++;
      if (articles.isEmpty) _hasReachedMax = true;

      final currentArticles =
          state is NewsSuccess ? state.articles : [];

      emit(
        NewsSuccess(
          articles: [...currentArticles, ...articles],
          hasReachedMax: _hasReachedMax,
        ),
      );
    } catch (e) {
      emit(NewsError(_mapError(e)));
    }
  }

  /// -----------------------------
  /// REFRESH
  /// -----------------------------
  Future<void> _onRefreshNews(
    RefreshNews event,
    Emitter<NewsState> emit,
  ) async {
    add(
      FetchNews(
        category: event.category,
        refresh: true,
      ),
    );
  }

  /// -----------------------------
  /// SEARCH
  /// -----------------------------
  Future<void> _onSearchNews(
    SearchNews event,
    Emitter<NewsState> emit,
  ) async {
    try {
      if (event.query.trim().isEmpty) return;

      _page = 1;
      _hasReachedMax = false;
      _currentQuery = event.query;
      _isSearchMode = true;

      emit(const NewsLoading());

      final articles = await repository.searchNews(
        query: event.query,
        page: _page,
      );

      _page++;

      emit(
        NewsSuccess(
          articles: articles,
          hasReachedMax: articles.isEmpty,
        ),
      );
    } catch (e) {
      emit(NewsError(_mapError(e)));
    }
  }

  /// -----------------------------
  /// ERROR MAPPER
  /// -----------------------------
  String _mapError(Object error) {
    final msg = error.toString();

    if (msg.contains('SocketException')) {
      return 'No internet connection';
    } else if (msg.contains('401')) {
      return 'Invalid API key';
    } else if (msg.contains('429')) {
      return 'Too many requests. Try again later.';
    } else {
      return 'Something went wrong';
    }
  }
}
