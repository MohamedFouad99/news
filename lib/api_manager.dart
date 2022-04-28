// ignore_for_file: constant_identifier_names, use_rethrow_when_possible

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news/model/sourses/news_response.dart';
import 'package:news/model/sourses/sourses_response.dart';

class ApiManager {
  static const String BaseUrl = 'newsapi.org';

  static Future<SoursesResponse> getSources(String categoryId) async {
    var url = Uri.https(BaseUrl, '/v2/top-headlines/sources',
        {'apiKey': '6cdfcfe2c6134b8e8dba0549ec7792ba', 'category': categoryId});

    try {
      var response = await http.get(url);
      var bodyString = response.body;
      var json = jsonDecode(bodyString);
      var sourcesResponse = SoursesResponse.fromJson(json);
      return sourcesResponse;
    } catch (e) {
      throw e;
    }
  }

  static Future<NewsResponse> getNews(
      {String? sourceId, String? seachKeyWord, int page = 1}) async {
    var url = Uri.https(BaseUrl, '/v2/everything', {
      'apiKey': '6cdfcfe2c6134b8e8dba0549ec7792ba',
      'sources': sourceId,
      'q': seachKeyWord,
      'page': '$page',
    });
    var response = await http.get(url);
    try {
      var bodyString = response.body;
      var json = jsonDecode(bodyString);
      var newsResponse = NewsResponse.fromJson(json);
      return newsResponse;
    } catch (e) {
      throw e;
    }
  }
}
