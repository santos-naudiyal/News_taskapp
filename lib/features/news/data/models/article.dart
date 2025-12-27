class ArticleModel {
  final String title;
  final String description;
  final String content;
  final String imageUrl;
  final String source;
  final String url;
  final DateTime publishedAt;

  const ArticleModel({
    required this.title,
    required this.description,
    required this.content,
    required this.imageUrl,
    required this.source,
    required this.url,
    required this.publishedAt,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      title: json['title']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      content: json['content']?.toString() ?? '',
      imageUrl: json['urlToImage']?.toString() ?? '',
      source: json['source']?['name']?.toString() ?? 'Unknown',
      url: json['url']?.toString() ?? '',
      publishedAt: DateTime.tryParse(
            json['publishedAt']?.toString() ?? '',
          ) ??
          DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'content': content,
      'imageUrl': imageUrl,
      'source': source,
      'url': url,
      'publishedAt': publishedAt.toIso8601String(),
    };
  }
}
