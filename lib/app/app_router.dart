import 'package:flutter/material.dart';
import 'package:news_app/features/news/data/models/article.dart';
import 'package:news_app/features/news/presentation/screens/article_screen.dart';
import 'package:news_app/features/news/presentation/screens/category_screen.dart';
import 'package:news_app/features/news/presentation/screens/home_screen.dart';



class AppRouter {
  /// Route names (centralized & typo-safe)
  static const String home = '/';
  static const String category = '/category';
  static const String article = '/article';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );

      case category:
        final args = settings.arguments as CategoryRouteArgs;

        return MaterialPageRoute(
          builder: (_) => CategoryScreen(
            category: args.category,
            title: args.title,
            isSearch: args.isSearch,
          ),
        );

      case article:
        final article = settings.arguments as ArticleModel;

        return MaterialPageRoute(
          builder: (_) => ArticleScreen(article: article),
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(
          child: Text('Page not found'),
        ),
      ),
    );
  }
}

/// ----------------------------
/// ROUTE ARGUMENT MODELS
/// ----------------------------
class CategoryRouteArgs {
  final String? category;
  final String title;
  final bool isSearch;

  const CategoryRouteArgs({
    this.category,
    required this.title,
    this.isSearch = false,
  });
}
