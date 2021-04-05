import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:world_news/helper/models/article_model.dart';
import 'package:world_news/helper/news.dart';

class CartegoryNews extends StatefulWidget {
  final String category;

  CartegoryNews({this.category});
  @override
  _CartegoryNewsState createState() => _CartegoryNewsState();
}

class _CartegoryNewsState extends State<CartegoryNews> {
  List<ArticleModel> articles = new List<ArticleModel>();

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    getCategoryNews();
  }

  getCategoryNews() async {
    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getNews(widget.category);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
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
                child: Column(
                  children: [
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
                ),
              )));
  }
}

//////////// We are going to re-use the below widget /////////////////

class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc, url, categoryName;
  BlogTile(
      {@required this.imageUrl,
      @required this.title,
      @required this.desc,
      @required this.url,
      @required this.categoryName});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {},
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
