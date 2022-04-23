// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';

import '../model/category.dart';
import 'category_widget.dart';

class CategoriesFragment extends StatelessWidget {
  var categories = Category.getCategories();
  Function onCategoryClick;
  CategoriesFragment(this.onCategoryClick);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        children: [
          //Text('Pick your Category of interest'),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12),
              itemBuilder: (_, index) {
                return InkWell(
                    onTap: () {
                      //call a callback to home screen to change layout
                      onCategoryClick(categories[index]);
                    },
                    child: CategoryWidget(categories[index], index));
              },
              itemCount: categories.length,
            ),
          )
        ],
      ),
    );
  }
}
