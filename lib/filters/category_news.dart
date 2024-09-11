import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/models/show_category.dart';
import 'package:newsapp/services/show_category.dart';


class CategoryNews extends StatefulWidget {
  String name;
  CategoryNews({super.key, required this.name});

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ShowCategoryModel> categories = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    getNews();
  }

  getNews() async {
    ShowCategoryNews showCategoryNews = ShowCategoryNews();
    await showCategoryNews.getCategoriesNews(widget.name.toLowerCase());
    categories = showCategoryNews.categories;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Container(
        margin:const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView.builder(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              return ShowCategory(
                urlToImage: categories[index].urlToImage!,description: categories[index].description!,title: categories[index].title!,
                
              );
            }),
      ),
    );
  }
}

class ShowCategory extends StatelessWidget {
  String urlToImage, description, title;
  ShowCategory({
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
