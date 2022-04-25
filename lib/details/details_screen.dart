// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, non_constant_identifier_names, unused_local_variable, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:news/model/sourses/news_response.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsScreen extends StatelessWidget {
  static String Route_Name = 'details_screen';
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as News;
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: args.urlToImage == null
                    ? Icon(Icons.broken_image)
                    : Image.network(
                        args.urlToImage ?? "",
                        height: 220,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
              ),
              Text(
                args.author ?? '',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
              Text(
                args.title ?? '',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
              Text(
                args.publishedAt ?? '',
                style: TextStyle(fontSize: 12, color: Colors.grey),
                textAlign: TextAlign.end,
              ),
              Container(
                padding: EdgeInsets.all(12),
                child: Text(
                  args.content ?? '',
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontSize: 20),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              IconButton(
                onPressed: () {
                  lanucherURL(args.url ?? '');
                },
                icon: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'View Full Articles',
                      style: TextStyle(color: Colors.blue, fontSize: 15),
                    ),
                    Icon(
                      Icons.arrow_right,
                      color: Colors.blue,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  lanucherURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
