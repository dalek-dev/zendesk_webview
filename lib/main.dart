import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

const String kNavigationExamplePage = '''
<!DOCTYPE html>
<html lang="en">
    
  <head>
    <title>Hello, World!</title>
  </head>

  <body>
  <style>
      #myLauncher {
      background-color: red;
      padding: 10px;
      border-radius: 4px;
      width: 100px;
      text-align: center;
      color: white;
      font-family: sans-serif;
    }
  </style>
    <p>Hello, World!</p>
        <!-- Start of Zendesk Widget script -->
    <script id="ze-snippet" src="https://static.zdassets.com/ekr/snippet.js?key=d6ca8560-4c52-4833-af97-a0f5e2b65539">
    </script>

    <div id='myLauncher' onclick='openWidget()'>Click to chat with me!</div>
    
    <script type="text/javascript">
zE('webWidget', 'hide');
      function openWidget() {
    zE("webWidget", "show")
    zE("webWidget", "open")
    document.querySelector("#myLauncher").style.opacity = 0
  }
      
      zE('webWidget:on', 'close', function() {
  zE('webWidget', 'hide');
  document.querySelector('#myLauncher').style.opacity = 1;
})
</script>
    
     
  </body>
</html>
''';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  var webViewControllerGlobal;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Zendesk Chat Plugin'),
      ),
      body: Stack(
        children: [
          Builder(
            builder: (BuildContext context) {
              return WebView(
                initialUrl: 'url',
                javascriptMode: JavascriptMode.unrestricted,
                allowsInlineMediaPlayback: true,
                gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                  Factory<VerticalDragGestureRecognizer>(
                    () => VerticalDragGestureRecognizer(),
                  ),
                },
                onWebViewCreated: (WebViewController webViewController) async {
                  _controller.complete(webViewController);
                  webViewControllerGlobal = webViewController;
                },
                gestureNavigationEnabled: true,
                onPageStarted: (String url) {
                  var uri = Uri.parse(url);
                  uri.queryParameters.forEach((key, value) {
                    print(key);
                  });
                },
              );
            },
          ),
        ],
      ),
    ));
  }
}
