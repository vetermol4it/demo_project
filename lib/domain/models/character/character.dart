import 'package:json_annotation/json_annotation.dart';

part 'character.g.dart';

@JsonSerializable()
class Character {
  final int id;
  final String name;
  final String status;
  final String species;
  final String gender;
  final String image;

  Character({
   required this.id,
   required this.name,
   required this.status,
   required this.species,
   required this.gender,
   required this.image,
  });

  factory Character.fromJson(Map<String, dynamic> json) => _$CharacterFromJson(json);
}