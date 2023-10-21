import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_user_model.g.dart';

@JsonSerializable(explicitToJson: true)
@CopyWith()
class AuthUserModel extends Equatable {

  final String? email;
  final String? name;

  const AuthUserModel({this.email, this.name});

  @override
  List<Object?> get props => [email];

  factory AuthUserModel.fromJson(Map<String, dynamic> json) => _$AuthUserModelFromJson(json);
  Map<String, dynamic> toJson() => _$AuthUserModelToJson(this);
  
}