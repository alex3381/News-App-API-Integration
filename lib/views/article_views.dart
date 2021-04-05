import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleViews extends StatefulWidget {
  final String blogUrl;
  ArticleViews({this.blogUrl});
  @override
  _ArticleViewsState createState() => _ArticleViewsState();
}

class _ArticleViewsState extends State<ArticleViews> {
  ////////////////////////// ONE OF WEBVIEWS MANY PROPERTIES BELLOW //////////////////
  final Completer<WebViewController> _completer =
      Completer<WebViewController>();
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
          actions: [
            // Opacity(
            //   opacity: 0.0,
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.menu),
            ),
          ],
          centerTitle: true,
          elevation: 0,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.height,
          child: WebView(
              initialUrl: widget.blogUrl,
              onWebViewCreated: (WebViewController webViewController) {
                _completer.complete(webViewController);
              }),
        ));
  }
}
