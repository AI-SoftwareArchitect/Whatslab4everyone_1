
import 'dart:convert';

import '../../models/new_model.dart';
import 'package:http/http.dart' as http;

class GetNewsService {

  Future<List<New>> getNews() async {
    String url = "http://10.0.2.2:3000/news";

    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponseData = jsonDecode(response.body);
        List<New> news = jsonResponseData.map((newsNew) => New.fromJson(newsNew)).toList();
        return news;
      } else {
        throw Exception('Failed to load news');
      }
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }


}
