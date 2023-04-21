// ignore_for_file: prefer_const_declarations

import 'dart:convert';

import 'package:http/http.dart' as http;

class EmployeService {
  // delete employe
  static Future<bool> deleteById(int id) async {
    final url = "http://10.0.2.2:3000/employes/$id";
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    return response.statusCode == 200;
  }

  static Future<List?> fetchData() async {
    final url = "http://10.0.2.2:3000/employes";
    final uri = Uri.parse(url);
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body) as List;
      return result;
    } else {
      return null;
    }
  }

  static Future<bool> updateData(int id, Map body) async {
    // submit updated data to the server
    final url = 'http://10.0.2.2:3000/employes/$id';
    final uri = Uri.parse(url);
    final response = await http.put(
      uri,
      body: jsonEncode(body),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    return response.statusCode == 200;
  }

  static Future<bool> submitData(Map body) async {
    // submit updated data to the server
    final url = 'http://10.0.2.2:3000/employes';
    final uri = Uri.parse(url);
    final response = await http.post(
      uri,
      body: jsonEncode(body),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    return response.statusCode == 201;
  }
}
