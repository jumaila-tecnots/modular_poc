import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/posts_entity.dart';


part 'post_model.freezed.dart';
part 'post_model.g.dart';


@freezed
class PostModel with _$PostModel implements PostEntity{
  const factory PostModel({
    required int userId,
    required int id,
    required String title,
    required String body,
}) = _PostModel;
  factory PostModel.fromJson(Map<String, dynamic> json) => _$PostModelFromJson(json);
}
