import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class WebViewScreen extends StatefulWidget {
  const WebViewScreen(article, {Key? key}) : super(key: key);

  get article => article;

  @override
  State<WebViewScreen> createState() => _WebViewScreenState(article['url']);
}

class _WebViewScreenState extends State<WebViewScreen> {
  bool isLoading = true;
  final String url;
  _WebViewScreenState(this.url);

  WebViewController _controller = WebViewController();
  changeUrl(url){
    WebViewController newController = WebViewController();
    newController..setJavaScriptMode(JavaScriptMode.unrestricted)..setNavigationDelegate(NavigationDelegate(
      onNavigationRequest: (NavigationRequest request){
        return NavigationDecision.navigate;
      },
      onPageStarted: (url){
        setState(() {
          isLoading = true;
        });
      },
      onPageFinished: (url){
        setState(() {
          isLoading = false;
        });
      },
    ),)..loadRequest(Uri.parse(url));
    if(mounted){
      setState(() {
        _controller = newController;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: isLoading? const Center(
        child: CircularProgressIndicator(),
      ) : WebViewWidget(controller: _controller)
    );
  }
}
