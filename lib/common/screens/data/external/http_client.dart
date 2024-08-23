import 'package:http/http.dart';

abstract class IHttpClient {
  Future<Response> get(String url);
  Future<Response> post(String url, Object? data);
}
