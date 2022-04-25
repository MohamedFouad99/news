// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, avoid_init_to_null, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:news/home/category/category_details.dart';
import 'package:news/model/category.dart';
import 'package:news/model/sourses/news_response.dart';

import '../api_manager.dart';
import '../model/sourses/news_response.dart';
import '../model/sourses/news_response.dart';
import 'categories.dart';
import 'home_drawer.dart';
import 'news/news_item.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('assets/images/background_pattern.png'))),
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('News'),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(context: context, delegate: NewsSearch());
                },
              ),
            ],
          ),
        ),
        drawer: Drawer(
          child: HomeDrawer(onSideMenuItemClick),
        ),
        body: selectedCategory == null
            ? CategoriesFragment(onCategoryClick)
            : CategoryDetails(selectedCategory!),
      ),
    );
  }

  Category? selectedCategory = null;

  void onCategoryClick(Category category) {
    // if someone clicked on Category
    // to change to category details view
    selectedCategory = category;
    setState(() {});
  }

  void onSideMenuItemClick(int clickedItem) {
    Navigator.pop(context);
    if (clickedItem == HomeDrawer.CATEGORIES) {
      selectedCategory = null;
      setState(() {});
    } else if (clickedItem == HomeDrawer.SETTINGS) {}
  }
}

class NewsSearch extends SearchDelegate {
  late Future<NewsResponse> newsResponse;
  NewsSearch() {
    newsResponse = ApiManager.getNews(seachKeyWord: query);
  }
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            newsResponse = ApiManager.getNews(seachKeyWord: query);
            showResults(context);
          },
          icon: Icon(
            Icons.search,
            color: Colors.black,
          )),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.clear,
          color: Colors.black,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      color: Colors.white,
      child: FutureBuilder<NewsResponse>(
          future: newsResponse,
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
          }),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.white,
      child: Text('suggetion'),
    );
  }
}
