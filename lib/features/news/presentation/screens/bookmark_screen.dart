import 'package:flutter/material.dart';
import 'package:news_app/features/news/data/models/article.dart';
import 'package:news_app/features/news/data/services/bookmark_service.dart';


import '../widgets/article_card.dart';
import 'article_screen.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bookmarks')),
      body: FutureBuilder<List<ArticleModel>>(
        future: BookmarkService().getBookmarks(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final articles = snapshot.data!;

          if (articles.isEmpty) {
            return const Center(child: Text('No bookmarks yet'));
          }

          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              final article = articles[index];
              return ArticleCard(
                article: article,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          ArticleScreen(article: article),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
