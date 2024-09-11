import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsapp/models/show_category.dart';

class ShowCategoryNews {
  List<ShowCategoryModel> categories = [];

  Future<void> getCategoriesNews(String category) async {
    String url = "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=196f79e8d1b446feb2e28c44ed56bc63";

    // "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=196f79e8d1b446feb2e28c44ed56bc63";
    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    if (jsonData["status"] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          ShowCategoryModel categoryModel = ShowCategoryModel(
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
            author: element["author"],
            publishedAt: element["publishedAt"],
          );
          categories.add(categoryModel);
        }
      });
    }
  }
}
