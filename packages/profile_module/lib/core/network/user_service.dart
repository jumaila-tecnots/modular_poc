import 'package:dio/dio.dart';
import 'package:profile_module/core/constants/api_endpoints.dart';
import 'package:profile_module/src/data/models/user_model.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'user_service.g.dart';

@RestApi()
abstract class UserService {
  factory UserService(Dio dio, {String? baseUrl}) = _UserService;

  @GET(ApiEndPoints.users)
  Future<List<UserModel>> getUsers();
}