// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:news/api_manager.dart';
import 'package:news/model/sourses/news_response.dart';
import 'package:news/model/sourses/sourses_response.dart';
import 'package:news/home/news/news_item.dart';

class NewsContainer extends StatelessWidget {
  Sources selectedSource;
  NewsContainer(this.selectedSource);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<NewsResponse>(
        future: ApiManager.getNews(
          sourceId: selectedSource.id ?? '',
        ),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Column(
              children: [
                Text('Some Thing Went Wrong'),
                ElevatedButton(onPressed: () {}, child: Text('Try Again'))
              ],
            );
          }
          if (snapshot.data?.status != 'ok') {
            return Column(
              children: [
                Text(snapshot.data?.message ?? ''),
                ElevatedButton(onPressed: () {}, child: Text('Try Again'))
              ],
            );
          }
          var newsList = snapshot.data?.articles ?? [];
          return ListView.builder(
            itemBuilder: (_, index) {
              return NewsItem(newsList[index]);
            },
            itemCount: newsList.length,
          );
        });
  }
}
