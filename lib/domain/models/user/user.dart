import 'package:intl/intl.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User  extends Equatable {
  final String name;
  final String login;
  final String password;
  final DateTime createdAt;

  const User({
    required this.name,
    required this.login,
    required this.password,
    required this.createdAt,
  });

  User.create({
    required this.name,
    required this.login,
    required this.password,
  }) : createdAt = DateTime.now();

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  String get formattedRegisterDate => DateFormat('dd.MM.yyyy HH:mm').format(createdAt);

  @override
  List<Object> get props => [login];
}