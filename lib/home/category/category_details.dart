// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:news/api_manager.dart';
import 'package:news/home/category/tab_container.dart';
import 'package:news/model/category.dart';
import 'package:news/model/sourses/sourses_response.dart';

class CategoryDetails extends StatelessWidget {
  static const String routeName = 'category_details';
  Category category;
  CategoryDetails(
    this.category,
  );
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FutureBuilder<SoursesResponse>(
            future: ApiManager.getSources(category.id),
            builder: (context, snapshot) {
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
              var soursesList = snapshot.data?.sources ?? [];
              return TabContainer(soursesList);
            },
          ),
        ),
      ],
    );
  }
}
