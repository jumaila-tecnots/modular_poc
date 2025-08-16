import 'package:dio/dio.dart';
import 'package:profile_module/core/constants/api_endpoints.dart';

Dio buildClient() {
  Dio dio = Dio(BaseOptions(
    baseUrl: ApiEndPoints.baseUrl,
    connectTimeout: Duration(seconds: 10),
  ));
  return dio;
}