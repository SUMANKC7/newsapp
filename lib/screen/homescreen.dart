// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/filters/all_news.dart';
import 'package:newsapp/filters/category_news.dart';
import 'package:newsapp/models/article_model.dart';
import 'package:newsapp/models/category_model.dart';
import 'package:newsapp/screen/detailscreen.dart';
import 'package:newsapp/screen/latestnews.dart';
import 'package:newsapp/services/data.dart';
import 'package:newsapp/services/news.dart';
import 'package:newsapp/theme/colors.dart';

import 'package:timeago/timeago.dart' as timeago;

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<CategoryModel> categories = [];
  List<ArticleModel> articles = [];
  bool _loading = true;
  @override
  void initState() {
    categories = getCategories();
    getNews();
    super.initState();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    if (mounted) {
      setState(() {
        articles = newsClass.news;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              "assests/images/kabar.png",
              width: 99,
              height: 30,
            ),
          ],
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: 18, right: 18, top: 15, bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          LatestNews(news: "Latest News")));
                            },
                            child: Text(
                              "Latest",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AllNews(news: "See all")));
                            },
                            child: Text(
                              "See all",
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: ColorsPallate.catagoryColor),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: 70,
                      margin: EdgeInsets.only(left: 8),
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return CategoryTile(
                              categoryName: categories[index].categoryName);
                        },
                      ),
                    ),
                    Container(
                      child: ListView.builder(
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemCount: articles.length,
                          itemBuilder: (context, index) {
                            return BlogTile(
                              description: articles[index].description ??
                                  'No description available',
                              imageUrl: articles[index].urlToImage ??
                                  'assests/images/default.jpg',
                              title:
                                  articles[index].title ?? 'No title available',
                              author: articles[index].author ?? 'Author',
                              publishedAt: articles[index].publishedAt ??
                                  DateTime.now().toIso8601String(),
                              url: articles[index].url ?? '',
                              sourceName: articles[index].sourceName ??
                                  'Unknown source',
                              content: articles[index].content ?? "No",
                            );
                          }),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final categoryName, image;
  const CategoryTile({super.key, this.categoryName, this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryNews(name: categoryName)));
      },
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          child: Stack(
            children: [
              Container(
                child: Text(
                  categoryName,
                  style: TextStyle(
                    color: ColorsPallate.catagoryColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl,
      title,
      description,
      content,
      author,
      publishedAt,
      url,
      sourceName;

  const BlogTile({
    super.key,
    required this.description,
    required this.imageUrl,
    required this.title,
    required this.author,
    required this.publishedAt,
    required this.url,
    required this.sourceName,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    // Parse the publishedAt string to a DateTime object
    DateTime publishedDate = DateTime.parse(publishedAt);

    // Initialize timeago library with custom localization
    timeago.setLocaleMessages('en', timeago.EnMessages());

    // Calculate the time ago string
    String timeAgo = timeago.format(publishedDate, allowFromNow: true);
    String text = sourceName;
    int limit = 10;
    String limitText(text, limit) {
      if (text.length > limit) {
        return text.substring(0, limit) +
            '...'; // Add ellipsis to indicate continuation
      } else {
        return text;
      }
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Detailscreen(
              imageUrl: imageUrl,
              title: title,
              content: content,
              source: sourceName,
              timeAgo: timeAgo,
              description: description,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 16, bottom: 20),
        child: Material(
          elevation: 0.3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Section
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    imageUrl,
                    height: 96,
                    width: 98.95,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 8),

                // Text Section
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Author name
                      Text(
                        author,
                        style: TextStyle(
                          color: ColorsPallate.catagoryColor,
                          fontSize: 13,
                          letterSpacing: 0.12,
                          fontWeight: FontWeight.w400,
                        ),
                        overflow: TextOverflow.ellipsis, // Limit overflow
                        maxLines: 1, // Only show 1 line for author
                      ),
                      SizedBox(height: 8),

                      // Title
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.12,
                          color: ColorsPallate.newsTitle,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3, // Limit to 3 lines
                      ),
                      SizedBox(height: 5),

                      // Source name, time ago, and icon
                      Row(
                        children: [
                          Image.asset(
                            "assests/images/logo.jpg",
                            height: 20,
                            width: 20,
                          ),
                          SizedBox(width: 5),
                          Text(
                            limitText(sourceName, 12),
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.12,
                            ),
                          ),
                          SizedBox(width: 5),
                          Icon(
                            CupertinoIcons.clock,
                            size: 14,
                          ),
                          SizedBox(width: 3),
                          Text(
                            timeAgo,
                            style: TextStyle(
                              color: ColorsPallate.catagoryColor,
                              fontSize: 13,
                              letterSpacing: 0.12,
                              fontWeight: FontWeight.w400,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
