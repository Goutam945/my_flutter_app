class NewsArticle {
  final String title;
  final String source;
  final String description;
  final String publishedAt;

  NewsArticle({
    required this.title,
    required this.source,
    required this.description,
    required this.publishedAt,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    return NewsArticle(
      title: json['title'] ?? '',
      source: json['source']['name'] ?? '',
      description: json['description'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
    );
  }
}
