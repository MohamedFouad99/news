// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';

import '../../model/sourses/news_response.dart';

class NewsItem extends StatelessWidget {
  News news;
  NewsItem(
    this.news,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
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
            child: news.urlToImage == null
                ? Icon(Icons.broken_image)
                : Image.network(
                    news.urlToImage ?? "",
                    height: 220,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
          ),
          Text(
            news.author ?? '',
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
          Text(
            news.title ?? '',
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
          Text(
            news.publishedAt ?? '',
            style: TextStyle(fontSize: 12, color: Colors.grey),
            textAlign: TextAlign.end,
          ),
        ],
      ),
    );
  }
}
