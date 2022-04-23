// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:news/model/sourses/sourses_response.dart';

class TabItem extends StatelessWidget {
  Sources source;
  bool isSelected;
  TabItem(
    this.source,
    this.isSelected,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Theme.of(context).primaryColor),
        color: isSelected ? Theme.of(context).primaryColor : Colors.transparent,
      ),
      child: Text(
        source.name ?? '',
        style: TextStyle(
            color: isSelected ? Colors.white : Theme.of(context).primaryColor),
      ),
    );
  }
}
