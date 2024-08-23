import 'package:http/http.dart' as http;

import '../screens/data/external/http_client.dart';

class HttpClientImpl implements IHttpClient {
  @override
  Future<http.Response> get(String url) {
    return http.get(Uri.parse(url));
  }

  @override
  Future<http.Response> post(String url, Object? data) {
    // TODO: implement post
    throw UnimplementedError();
  }
}
