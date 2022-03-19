import 'package:demo_project/data/utils/api_util/api_util.dart';
import 'package:demo_project/domain/models/character/character.dart';
import 'package:demo_project/domain/repository/search_repository.dart';

class SearchDataRepository implements SearchRepository {
  final ApiUtil _apiUtil;

  SearchDataRepository(this._apiUtil);
  @override
  Future<List<Character>> searchCharacters() async {
    final response = await _apiUtil.searchCharacters();
    final List<Character> result = [];
    for (var json in response) {
      result.add(Character.fromJson(json as Map<String, dynamic>));
    }
    return result;
  }
}