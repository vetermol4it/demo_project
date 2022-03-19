import 'package:demo_project/data/utils/api_util/routes.dart';
import 'package:dio/dio.dart';

class ApiUtil{
  final Dio _dio;

  ApiUtil(this._dio);

  Future<List> searchCharacters() async {
    final response = await _dio.get(
      Routes.searchCharacters
    );
    return response.data['results'];
  }
}