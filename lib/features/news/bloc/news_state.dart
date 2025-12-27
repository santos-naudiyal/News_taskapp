import 'package:news_app/features/news/data/models/article.dart';


abstract class NewsState {
  const NewsState();

  List<ArticleModel> get articles => [];
}

class NewsLoading extends NewsState {
  const NewsLoading();
}

class NewsSuccess extends NewsState {
  final List<ArticleModel> articles;
  final bool hasReachedMax;

  const NewsSuccess({
    required this.articles,
    required this.hasReachedMax,
  });
}

class NewsError extends NewsState {
  final String message;

  const NewsError(this.message);
}
