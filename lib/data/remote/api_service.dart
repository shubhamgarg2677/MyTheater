import 'package:http/http.dart' as http;
import 'package:my_theater/utils/connection_string.dart';

class ApiService{
  Future<http.Response> getMethod(String url) async {
    url = "$url?${ConnectionString.apikey}=${ConnectionString.apikeyValue}";
    return await http.get(Uri.parse(url)).timeout(const Duration(seconds: 30));
  }

  Future<http.Response> getMethodWithParams(String url, String params) async {
    url = "$url?${ConnectionString.apikey}=${ConnectionString.apikeyValue}&$params";
    return await http.get(Uri.parse(url)).timeout(const Duration(seconds: 30));
  }
}