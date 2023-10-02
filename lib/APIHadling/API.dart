import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../models/BlogModel.dart';
import 'package:http/http.dart' as http;

class API {

  final String _url = 'https://intent-kit-16.hasura.app/api/rest/blogs';
  final String _adminSecret =
      '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

  Future<List<Blogs>> getBlogs() async {
    List<Blogs> blogs = [];
    try {
      final response = await http.get(Uri.parse(_url), headers: {
        'x-hasura-admin-secret': _adminSecret,
      });

      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        // Request successful, handle the response data here

        for (Map<String, dynamic> blog in data['blogs']) {
          blogs.add(Blogs.fromJson(blog));
        }

        return blogs;
      } else {
        // Request failed
        debugPrint('Request failed with status code: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      throw e;

    }
  }
}
