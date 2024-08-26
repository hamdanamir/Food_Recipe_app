import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class recipeview extends StatefulWidget {
  String url;
  recipeview(this.url);
  @override
  State<recipeview> createState() => _recipeviewState();
}

class _recipeviewState extends State<recipeview> {
  late String finalurl;
 final Completer<WebViewController>controller=Completer<WebViewController>();
  @override
  void initState() {
    if(widget.url.toString().contains("http://"))
      {
        finalurl=widget.url.toString().replaceAll("http://", "https://");
      }
    else
      {
        finalurl=widget.url;
      }

    super.initState();
  }
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Food Recipe App"),
      ),
      body: Container(
        // child: WebView(
        //   initialUrl: widget.url,
        //   javascriptMode: JavascriptMode.unrestricted,
        //   onWebViewCreated: (WebViewController webViewController) {
        //     setState(() {
        //       controller.complete(webViewController);
        //     });
        //   },
        // ),
        child: WebView(
          initialUrl:finalurl,
          javascriptMode:JavascriptMode.unrestricted,
          onWebViewCreated:(WebViewController webViewController){
            setState(() {
              controller.complete(webViewController);
            });
          },
        ),
      ),
    );
  }
}
