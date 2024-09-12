// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:google_fonts/google_fonts.dart';


class Detailscreen extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final String content;
  final String source;
  final String timeAgo;

  const Detailscreen({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.content,
    required this.source,
    required this.timeAgo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.share, color: Colors.black),
            onPressed: () {
              Share.share(content);
            },
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onSelected: (String result) {
              // Add action handling logic here
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
      body: SingleChildScrollView(
        child: Column(
          
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(Icons.newspaper_rounded,size: 40,),
                  SizedBox(width: 9,),
                  Text(
                    source.toUpperCase(), // News source
                    style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w900,
                    
                    ),
                    )
                  ),
                 
                ],
              ),
              
            ),
             Padding(
              padding: EdgeInsets.only(left: 69,bottom: 20),
               child: Text(
                      timeAgo, // Time ago
                      style: TextStyle(
                        fontSize: 14,
                        color: const Color.fromARGB(255, 101, 100, 100),
                        fontWeight: FontWeight.w900
                      ),
                    ),
             ),
            Image.network(
              imageUrl,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                title,
                style: GoogleFonts.roboto(
                      textStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w900,
                    
                    ),
                    )
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                content,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
