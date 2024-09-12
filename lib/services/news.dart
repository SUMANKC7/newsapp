import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsapp/models/article_model.dart';

class News {
  List<ArticleModel> news = [];

  Future<void> getNews() async {
    String url =
        "https://newsapi.org/v2/everything?q=bitcoin&apiKey=196f79e8d1b446feb2e28c44ed56bc63";
    
    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);

        if (jsonData["status"] == "ok") {
          // Loop through each article in the JSON response
          for (var element in jsonData["articles"]) {
            try {
              // Check if the article has essential fields
              if (element["urlToImage"] != null && element["description"] != null) {
                
                // Optionally, validate the image URL by making a HEAD request
                if (await _isValidImageUrl(element["urlToImage"])) {
                  String? sourceName = element["source"]["name"];
                  
                  // Create an ArticleModel instance and add it to the news list
                  ArticleModel articleModel = ArticleModel(
                    title: element["title"],
                    description: element["description"],
                    url: element["url"],
                    urlToImage: element["urlToImage"],
                    content: element["content"],
                    author: element["author"],
                    publishedAt: element["publishedAt"],
                    sourceName: sourceName,
                  );
                  news.add(articleModel);  // Add valid articles to the list
                } else {
                  print('Invalid image URL: Skipping this article.');
                }
              } else {
                print('Missing essential fields: Skipping this article.');
              }
            } catch (articleError) {
              print("Error parsing article: $articleError. Skipping this article.");
            }
          }
        } else {
          print("API response status not 'ok': ${jsonData["status"]}");
        }
      } else {
        print("HTTP request failed with status code: ${response.statusCode}");
      }
    } catch (error) {
      print("An error occurred during the API call: $error");
    }
  }

  // Helper method to check if the image URL is valid
  Future<bool> _isValidImageUrl(String url) async {
    try {
      var response = await http.head(Uri.parse(url));
      return response.statusCode == 200;  // Return true if status code is 200
    } catch (e) {
      print('Error validating image URL: $e');
      return false;
    }
  }
}
