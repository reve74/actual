import 'package:actual/common/utils/data_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String id;
  final String username;
  @JsonKey(fromJson: DataUtils.pathToUrl) // 요청 url 이나 이미지 url을 넣을때 JsonKey 사용
  final String imageUrl;

  UserModel({
    required this.id,
    required this.username,
    required this.imageUrl,
  });
  
  factory UserModel.fromJson(Map<String, dynamic> json)
  => _$UserModelFromJson(json);
}
