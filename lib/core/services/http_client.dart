import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:cos_challenge/core/constants/enums/response_code.dart';
import 'package:cos_challenge/core/exceptions/network_exception.dart';
import 'package:cos_challenge/core/exceptions/server_exception.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart' show MockClient;

class HttpClient {
  static const user = 'user';
  static const vinLength = 17;
  static final HttpClient _instance = HttpClient._internal();

  factory HttpClient() => _instance;

  HttpClient._internal();

  Future<dynamic> get(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw ServerException(
            'Server returned status code: ${response.statusCode}');
      }
    } catch (e) {
      throw NetworkException(e.toString());
    }
  }

  static final http.BaseClient httpClient = MockClient(
    (request) async {
      if (request.headers[user]?.isEmpty ?? true) {
        throw http.ClientException('Auth');
      }
      final length = ResponseCode.values.length;
      final code = Random().nextInt(length + 1) + (length - 1);
      await Future<void>.delayed(const Duration(seconds: 1));
      if (code > length + 1) throw TimeoutException('Timed-out');
      final response = ResponseCode.values.elementAt(code - (length - 1));
      final body = response.whenConst(
        success: response.mockSuccess,
        multipleChoices: response.mockMultipleChoices,
        error: response.mockError,
      );

      return http.Response(body, code * 100, request: request);
    },
  );
}
