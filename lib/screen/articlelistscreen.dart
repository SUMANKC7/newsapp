// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'detailscreen.dart'; // Import your detail screen

// class ArticleListScreen extends StatefulWidget {
//   @override
//   _ArticleListScreenState createState() => _ArticleListScreenState();
// }

// class _ArticleListScreenState extends State<ArticleListScreen> {
//   List articles = [];
//   bool isLoading = true;

//   @override
//   void initState() {
//     super.initState();
//     fetchArticles();
//   }

//   Future<void> fetchArticles() async {
//     final apiUrl =
//         'https://newsapi.org/v2/top-headlines?country=us&apiKey=196f79e8d1b446feb2e28c44ed56bc63';
//     try {
//       final response = await http.get(Uri.parse(apiUrl));
//       if (response.statusCode == 200) {
//         setState(() {
//           articles = json.decode(response.body)['articles'];
//           isLoading = false;
//         });
//       } else {
//         throw Exception('Failed to load articles');
//       }
//     } catch (e) {
//       print(e);
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Top Headlines'),
//       ),
//       body: isLoading
//           ? Center(child: CircularProgressIndicator())
//           : ListView.builder(
//               itemCount: articles.length,
//               itemBuilder: (context, index) {
//                 final article = articles[index];
//                 return ListTile(
//                   title: Text(article['title'] ?? 'No Title'),
//                   subtitle: Text(article['description'] ?? 'No Description'),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => Detailscreen(
//                           apiUrl: 'https://newsapi.org/v2/top-headlines?country=us&apiKey=196f79e8d1b446feb2e28c44ed56bc63',
//                           articleUrl: article['url'], // Pass the article URL
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//     );
//   }
// }
