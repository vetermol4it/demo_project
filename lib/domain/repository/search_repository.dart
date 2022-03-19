import 'package:demo_project/domain/models/character/character.dart';

abstract class SearchRepository {
  Future<List<Character>> searchCharacters();
}