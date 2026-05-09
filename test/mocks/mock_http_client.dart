import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

class MockHttpClient extends http.BaseClient {
  final int statusCode;
  final dynamic body;

  MockHttpClient({this.statusCode = 200, required this.body});

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final String responseBody =
        body is String ? body : jsonEncode(body);

    final bytes = utf8.encode(responseBody);

    final stream = Stream.fromIterable([bytes]); // 🔥 FIX IMPORTANT

    return http.StreamedResponse(
      stream,
      statusCode,
      headers: {'content-type': 'application/json'},
    );
  }
}