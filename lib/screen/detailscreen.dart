import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:share/share.dart';

class Detailscreen extends StatefulWidget {
  final String blogUrl;

  Detailscreen({
    required this.blogUrl,
  });

  @override
  State<Detailscreen> createState() => _DetailscreenState();
}

class _DetailscreenState extends State<Detailscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.share, color: Colors.black),
            onPressed: () {
              Share.share('Check out this blog: ${widget.blogUrl}');
            },
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onSelected: (String result) {
              switch (result) {
                case 'Refresh':
                  // Reload the WebView
                  setState(() {});
                  break;
                case 'Open in Browser':
                  // Implement the action to open in a browser
                  // You may use a package like url_launcher
                  break;
                case 'Settings':
                  // Implement settings action
                  break;
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Refresh',
                child: Text('Refresh'),
              ),
              const PopupMenuItem<String>(
                value: 'Open in Browser',
                child: Text('Open in Browser'),
              ),
              const PopupMenuItem<String>(
                value: 'Settings',
                child: Text('Settings'),
              ),
            ],
          ),
        ],
      ),
      body: Container(
        child: WebView(
          initialUrl: widget.blogUrl,
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}

