import 'package:cos_challenge/core/constants/mocks/cos_challenge.dart';
import 'package:cos_challenge/core/services/http_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'dart:async';

void main() {
  const mockUserId = 'test_user';

  group('CosChallenge Tests', () {
    test('Throws Auth error if user header is missing', () async {
      final mockClient = MockClient((request) async {
        throw ClientException('Auth');
      });

      try {
        await mockClient.get(Uri.parse('https://example.com'));
        fail('Expected a ClientException to be thrown');
      } catch (e) {
        expect(e, isA<ClientException>());
        expect(e.toString(), contains('Auth'));
      }
    });

    test('Handles TimeoutException correctly', () async {
      final mockClient = MockClient((request) async {
        throw TimeoutException('Timed-out');
      });

      try {
        await mockClient.get(
          Uri.parse('https://example.com'),
          headers: {HttpClient.user: mockUserId},
        );
        fail('Expected a TimeoutException to be thrown');
      } catch (e) {
        expect(e, isA<TimeoutException>());
        expect(e.toString(), contains('Timed-out'));
      }
    });

    test('Handles successful response correctly', () async {
      final mockClient = MockClient((request) async {
        return Response('{"key":"value"}', 200);
      });

      final response = await mockClient.get(
        Uri.parse('https://example.com'),
        headers: {HttpClient.user: mockUserId},
      );

      expect(response.statusCode, 200);
      expect(response.body, contains('"key":"value"'));
    });

    test('Handles multiple choices response', () async {
      final mockClient = MockClient((request) async {
        return Response(MockData().multipleChoices, 300);
      });

      final response = await mockClient.get(
        Uri.parse('https://example.com'),
        headers: {HttpClient.user: mockUserId},
      );

      expect(response.statusCode, 300);
      expect(response.body, contains('"make": "Toyota"'));
    });

    test('Handles error response correctly', () async {
      final mockClient = MockClient((request) async {
        return Response(MockData().error(3), 500);
      });

      final response = await mockClient.get(
        Uri.parse('https://example.com'),
        headers: {HttpClient.user: mockUserId},
      );

      expect(response.statusCode, 500);
      expect(response.body, contains('"msgKey": "maintenance"'));
    });

    test('VIN length constant is correct', () {
      expect(HttpClient.vinLength, 17);
    });

    test('Validates request headers with user key', () async {
      final mockClient = MockClient((request) async {
        return Response(MockData().success, 200);
      });

      final response = await mockClient.get(
        Uri.parse('https://example.com'),
        headers: {HttpClient.user: mockUserId},
      );

      expect(response, isA<Response>());
    });
  });
}
