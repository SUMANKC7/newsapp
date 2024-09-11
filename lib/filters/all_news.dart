import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/models/article_model.dart';
import 'package:newsapp/services/news.dart';


class AllNews extends StatefulWidget {
  String news;
  AllNews({required this.news});

  @override
  State<AllNews> createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> {
   List<ArticleModel> articles = [];

     @override
  void initState() {
    getNews();
    super.initState();
  }

getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      
    });
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text(
          widget.news,
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
       child: ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: articles.length,
            itemBuilder: (context, index) {
              return AllNewsSelection(
                urlToImage: articles[index].urlToImage!,description: articles[index].description!,title: articles[index].title!,
                
              );
            })
      ),
    );
  }
}

class AllNewsSelection extends StatelessWidget {
  String urlToImage, description, title;
  AllNewsSelection({
    required this.urlToImage,
    required this.description,
    required this.title,
   
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: urlToImage,
              width: MediaQuery.of(context).size.width,
              height: 200,
              fit: BoxFit.cover,
            ),
          ),
         const SizedBox(height: 10,),
          Text(title,
          maxLines: 2,
          style: TextStyle(color: Colors.black,fontSize: 18.0,fontWeight: FontWeight.bold),),
          Text(description,maxLines: 4,),
          const SizedBox(height: 30.0,),
        ],
      ),
    );
  }
}

