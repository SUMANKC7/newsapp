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
          jsonData["articles"].forEach((element) {
            if (element["urlToImage"] != null && element["description"] != null) {
              String? sourceName = element["source"]["name"];
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
              news.add(articleModel);
            }
          });
        } 
      } 
    } catch (error) {
      print("An error occurred: $error");
    }
  }
}
