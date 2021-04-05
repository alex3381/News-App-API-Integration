import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models/article_model.dart';

class News {
  List<ArticleModel> news = [];

  Future<void> getNews() async {
    Uri url = Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=ng&apiKey=f1ceadacf4b34533a4ba5ce610a4737f');

    // 'https://newsapi.org/v2/top-headlines?country=ng&category=business&apiKey='
    // 'f1ceadacf4b34533a4ba5ce610a4737f');
    //////////////// to change news to country of your choice check documentation from newapi

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        // this condition below was given if the urlToImage refuse to load
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['content'],
          );
          // now lets add the model to news
          news.add(articleModel);
        }
      });
    }
  }
}

// Future<List<ArticleModel>> fetchFruit() async {
//   final response = await http.get(url);
// }
// String url =    'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey='
//          'f1ceadacf4b34533a4ba5ce610a4737f';

/////////////// Below class is for category news////////////////////////////

class CategoryNewsClass {
  List<ArticleModel> news = [];

  Future<void> getNews(String category) async {
    Uri url = Uri.parse(
        // 'https://newsapi.org/v2/top-headlines?country=ng&category=entertainment&apiKey=f1ceadacf4b34533a4ba5ce610a4737f');
        'https://newsapi.org/v2/top-headlines?country=ng&category'
        '=$category&apiKey=f1ceadacf4b34533a4ba5ce610a4737f');

    // 'https://newsapi.org/v2/top-headlines?country=ng&category=business&apiKey='
    // 'f1ceadacf4b34533a4ba5ce610a4737f');
    //////////////// to change news to country of your choice check documentation from newapi

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        // this condition below was given if the urlToImage refuse to load
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            urlToImage: element['urlToImage'],
            content: element['content'],
          );
          // now lets add the model to news
          news.add(articleModel);
        }
      });
    }
  }
}
