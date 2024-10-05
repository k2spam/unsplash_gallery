import 'dart:convert';

import 'package:http/http.dart' as http;

class UnsplashService {
  final String key = 'jKxeOr2PbGayO6-ErgANsqjDTjK3av6SylP4gT5DG1Y';
  final String url = 'https://api.unsplash.com/photos';

  Future<List<dynamic>> fetchImages ({int page = 1}) async {
    final response = await http.get(
      Uri.parse('$url?page=$page'),
      headers: {
        "Authorization": "Client-ID jKxeOr2PbGayO6-ErgANsqjDTjK3av6SylP4gT5DG1Y"
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