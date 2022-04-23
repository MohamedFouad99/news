// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';

import 'package:news/model/sourses/sourses_response.dart';
import 'package:news/home/news/news_container.dart';
import 'package:news/home/category/tab_item.dart';

class TabContainer extends StatefulWidget {
  List<Sources> sourses;

  TabContainer(
    this.sourses,
  );

  @override
  State<TabContainer> createState() => _TabContainerState();
}

class _TabContainerState extends State<TabContainer> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.sourses.length,
      child: Column(
        children: [
          TabBar(
              isScrollable: true,
              indicatorColor: Colors.transparent,
              onTap: (index) {
                selectedIndex = index;
                setState(() {});
              },
              tabs: widget.sourses
                  .map((sources) => TabItem(sources,
                      selectedIndex == widget.sourses.indexOf(sources)))
                  .toList()),
          Expanded(child: NewsContainer(widget.sourses[selectedIndex])),
        ],
      ),
    );
  }
}
