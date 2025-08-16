import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:profile_module/src/domain/entities/user_entity.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';


@freezed
class UserModel with _$UserModel implements UserEntity{
  const factory UserModel({
    required int id,
    required String name,
    required String email,
}) = _UserModel;
  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);
}
