import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/models/article_model.dart';
import 'package:newsapp/services/news.dart';

class LatestNews extends StatefulWidget {
  final String news;
  const LatestNews({super.key, required this.news});

  @override
  State<LatestNews> createState() => _LatestNewsState();
}

class _LatestNewsState extends State<LatestNews> {
  List<ArticleModel> articles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getNews();
  }

  Future<void> getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    setState(() {
      articles = newsClass.news;
      isLoading = false; // Update loading status
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.news,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 20),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading indicator while fetching
          : articles.isEmpty
              ? Center(child: Text('No news articles available.')) // Show message when no articles
              : Container(
                  margin: EdgeInsets.symmetric(horizontal: 10.0),
                  child: ListView.builder(
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      final article = articles[index];
                      return AllNewsSelection(
                        urlToImage: article.urlToImage ?? '', // Provide default empty string if null
                        description: article.description ?? '', // Provide default empty string if null
                        title: article.title ?? '', // Provide default empty string if null
                      );
                    },
                  ),
                ),
    );
  }
}

class AllNewsSelection extends StatelessWidget {
  final String urlToImage;
  final String description;
  final String title;

  AllNewsSelection({
    required this.urlToImage,
    required this.description,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0), // Add vertical margin for better spacing
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align content to start
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: urlToImage,
              width: MediaQuery.of(context).size.width,
              height: 200,
              fit: BoxFit.cover,
              placeholder: (context, url) => Center(child: CircularProgressIndicator()), // Show placeholder while loading
              errorWidget: (context, url, error) => Icon(Icons.error), // Show error icon if image fails to load
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis, // Handle long text with ellipsis
            style: TextStyle(color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            description,
            maxLines: 4,
            overflow: TextOverflow.ellipsis, // Handle long text with ellipsis
          ),
          const SizedBox(height: 30.0),
        ],
      ),
    );
  }
}
