import 'dart:convert';
import 'package:news_app/features/news/data/models/article.dart';
import 'package:shared_preferences/shared_preferences.dart';


class BookmarkService {
  static const _key = 'bookmarked_articles';

  Future<List<ArticleModel>> getBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_key) ?? [];

    return list
        .map((e) => ArticleModel.fromJson(jsonDecode(e)))
        .toList();
  }

  Future<void> toggleBookmark(ArticleModel article) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_key) ?? [];

    final encoded = jsonEncode(article.toJson());

    if (list.contains(encoded)) {
      list.remove(encoded);
    } else {
      list.add(encoded);
    }

    await prefs.setStringList(_key, list);
  }

  Future<bool> isBookmarked(ArticleModel article) async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_key) ?? [];
    return list.contains(jsonEncode(article.toJson()));
  }
}
