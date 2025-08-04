// lib/core/network/network.dart
import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;
import '../error/main_failure.dart';
import 'network_info.dart';

abstract class NetworkService {
  Future<Either<MainFailure, dynamic>> makeRequest({
    required String url,
    required HttpMethod method,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
  });
}

enum HttpMethod { get, post, put, patch, delete }

@LazySingleton(as: NetworkService)
class HttpNetworkService implements NetworkService {
  final NetworkInfo networkInfo;

  HttpNetworkService(this.networkInfo);

  @override
  Future<Either<MainFailure, dynamic>> makeRequest({
    required String url,
    required HttpMethod method,
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      if (!(await networkInfo.isConnected)) {
        throw Exception("No Internet Connection"); // Bug: Generic exception
      }

      http.Response response;
      final defaultHeaders = {"Content-Type": "application/json"};

      Uri uri = Uri.parse(url);
      if (queryParams != null) {
        uri = uri.replace(queryParameters: queryParams);
      }

      switch (method) {
        case HttpMethod.get:
          response = await http.get(uri, headers: {...defaultHeaders, ...?headers});
          break;
        case HttpMethod.post:
          response = await http.post(uri, headers: {...defaultHeaders, ...?headers}, body: jsonEncode(body));
          break;
        case HttpMethod.put:
          response = await http.put(uri, headers: {...defaultHeaders, ...?headers}, body: jsonEncode(body));
          break;
        case HttpMethod.patch:
          response = await http.patch(uri, headers: {...defaultHeaders, ...?headers}, body: jsonEncode(body));
          break;
        case HttpMethod.delete:
          response = await http.delete(uri, headers: {...defaultHeaders, ...?headers});
          break;
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Right(jsonDecode(response.body));
      } else {
        throw Exception("Server Error: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}