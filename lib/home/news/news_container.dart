// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:news/api_manager.dart';
import 'package:news/model/sourses/news_response.dart';
import 'package:news/model/sourses/sourses_response.dart';
import 'package:news/home/news/news_item.dart';

class NewsContainer extends StatefulWidget {
  Sources selectedSource;

  NewsContainer(this.selectedSource);

  @override
  State<NewsContainer> createState() => _NewsContainerState();
}

class _NewsContainerState extends State<NewsContainer> {
  late ScrollController scrollController;
  bool shouldLoadNextPage = false;
  int page = 1;
  List<News> news = [];
  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        bool isTop = scrollController.position.pixels == 0;
        if (isTop) {
        } else {
          shouldLoadNextPage = true;
          setState(() {});
        }
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (shouldLoadNextPage == true) {
      ApiManager.getNews(sourceId: widget.selectedSource.id, page: ++page)
          .then((newsResponse) {
        if (newsResponse != null) {
          setState(() {
            news.addAll(newsResponse.articles!.toList());
            shouldLoadNextPage = false;
          });
        }
      });
    }
    return FutureBuilder<NewsResponse>(
        future: ApiManager.getNews(
          sourceId: widget.selectedSource.id ?? '',
        ),
        builder: (_, snapshot) {
          if (snapshot.hasError) {
            return Column(
              children: [
                Text('Some Thing Went Wrong'),
                ElevatedButton(onPressed: () {}, child: Text('Try Again'))
              ],
            );
          } else if (snapshot.hasData) {
            if (news.isEmpty) {
              news = snapshot.data?.articles ?? [];
            }
            if (snapshot.data?.articles![0].title != news.elementAt(0).title) {
              scrollController.jumpTo(0);
              news = snapshot.data?.articles ?? [];
            }
            return ListView.builder(
              controller: scrollController,
              itemBuilder: (_, index) {
                return NewsItem(news[index]);
              },
              itemCount: news.length,
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }

          // if (snapshot.connectionState == ConnectionState.waiting) {
          //   return Center(child: CircularProgressIndicator());
          // } else if (snapshot.hasError) {
          //   return Column(
          //     children: [
          //       Text('Some Thing Went Wrong'),
          //       ElevatedButton(onPressed: () {}, child: Text('Try Again'))
          //     ],
          //   );
          // }
          // if (snapshot.data?.status != 'ok') {
          //   return Column(
          //     children: [
          //       Text(snapshot.data?.message ?? ''),
          //       ElevatedButton(onPressed: () {}, child: Text('Try Again'))
          //     ],
          //   );
          // }

          // if (news.isEmpty) {
          //   news = snapshot.data?.articles ?? [];
          // }
          // if( snapshot.data?.articles![0].title !=news.elementAt(0).title){
          //   news= snapshot.data?.articles ?? [];
          // }
          // return ListView.builder(
          //   controller: scrollController,
          //   itemBuilder: (_, index) {
          //     return NewsItem(news[index]);
          //   },
          //   itemCount: news.length,
          // );
        });
  }
}
