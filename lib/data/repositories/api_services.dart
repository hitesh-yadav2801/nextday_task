import 'dart:convert';

import 'package:nextday_task/core/constants/app_urls.dart';
import 'package:nextday_task/data/models/models.dart';
import 'package:http/http.dart' as http;

class ApiServices {
  Future<List<Data>> getUsers() async {
    final response = await http.get(Uri.parse(AppUrl.USERS_URL));
    try {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        //print(data);
        var dataList = data['data'] as List<dynamic>;
        return dataList.map((e) => Data.fromJson(e)).toList();
      } else {
        throw Exception(response.statusCode);
      }
    } catch (ex) {
      throw Exception('Error occurred while fetching users data');
    }
  }
}
