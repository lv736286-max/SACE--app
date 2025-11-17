import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;
  ApiService({required this.baseUrl});

  Future<http.Response> post(String path, Map<String, dynamic> body) async {
    final uri = Uri.parse('$baseUrl$path');
    final res = await http.post(uri, headers: {'Content-Type': 'application/json'}, body: json.encode(body));
    return res;
  }

  Future<http.Response> get(String path) async {
    final uri = Uri.parse('$baseUrl$path');
    final res = await http.get(uri);
    return res;
  }
}
