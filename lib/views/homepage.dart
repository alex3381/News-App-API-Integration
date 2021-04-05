import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:world_news/helper/cartegory_data.dart';
import 'package:world_news/helper/models/article_model.dart';
import 'package:world_news/helper/models/cartegory_models.dart';
import 'package:world_news/helper/news.dart';

import 'article_views.dart';
import 'cartegory_news.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //////////// list for hardcoded horrinzontal//////////////////////
  // ignore: deprecated_member_use
  List<CategorieModel> myCategories = new List<CategorieModel>();

  // list for vartical json data
  // ignore: deprecated_member_use
  List<ArticleModel> articles = new List<ArticleModel>();

  bool _loading = true;

  @override
  void initState() {
    super.initState();
    //////////// first horinzontal  ////////////
    myCategories = getCategories();

    ////////////second vertical   /////////////////
    getNews();
  }

  ///// for the vartical  horrinzontal list vew we will create a function ////////////
  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Naija',
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    color: Colors.black87,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  ),
                ),
              ),
              Text(
                'News',
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    color: Colors.red,
                    letterSpacing: 1.5,
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: _loading
            ? Center(
                child: Container(child: CircularProgressIndicator()),
              )
            : SingleChildScrollView(
                child: Container(

                    // height: MediaQuery.of(context).size.height * 2.5,
                    // height: 1000,
                    child: Column(
                  children: [
                    ///////////////// // Categories ///////////////////
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      height: 70,
                      child: ListView.builder(
                          itemCount: myCategories.length,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return CartegoryTiles(
                              imageAssetUrl: myCategories[index].imageAssetUrl,
                              categorieName: myCategories[index].categorieName,
                            );
                          }),
                    ),

                    ////////////////////  BLOGS  ////////////////////////////

                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      // padding: EdgeInsets.only(top: 16),
                      // height: MediaQuery.of(context).size.height * 0.5,
                      child: ListView.builder(
                          physics: ClampingScrollPhysics(),
                          itemCount: articles.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return BlogTile(
                              imageUrl: articles[index].urlToImage,
                              title: articles[index].title,
                              desc: articles[index].description,
                              url: articles[index].url,
                            );
                          }),
                    )
                  ],
                )),
              ));
  }
}

class CartegoryTiles extends StatelessWidget {
  final String imageAssetUrl;
  final categorieName;

  CartegoryTiles({
    this.imageAssetUrl,
    this.categorieName,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CartegoryNews(
                        category: categorieName.toString().toLowerCase(),
                      )));
        },
        child: Container(
          margin: EdgeInsets.only(right: 10),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: imageAssetUrl,
                  width: 120,
                  height: 60,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 16),
                width: 120,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.black26,
                ),
                child: Text(
                  categorieName,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w300),
                ),
              )
            ],
          ),
        ));
  }
}

class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc, url;
  BlogTile(
      {@required this.imageUrl,
      @required this.title,
      @required this.desc,
      @required this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ArticleViews(blogUrl: url)));
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 16),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Image.network(imageUrl),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                title,
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    color: Colors.black87,
                    letterSpacing: .5,
                    fontWeight: FontWeight.w800,
                    fontSize: 17,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(desc,
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w300,
                      fontSize: 14,
                    ),
                  )),
            ],
          ),
        ));
  }
}
