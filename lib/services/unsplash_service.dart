import 'dart:convert';

import 'package:http/http.dart' as http;

class UnsplashService {
  static final UnsplashService _instance = UnsplashService._internal();
  final String key = 'jKxeOr2PbGayO6-ErgANsqjDTjK3av6SylP4gT5DG1Y';
  final String url = 'https://api.unsplash.com/photos';

  UnsplashService._internal();

  static UnsplashService get instance => _instance;

  Future<List<dynamic>> fetchImages ({int page = 1}) async {
    final response = await http.get(
      Uri.parse('$url?page=$page'),
      headers: {
        "Authorization": "Client-ID $key"
      }
    );

    if(response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    else {
      return [];
    }
  }
}