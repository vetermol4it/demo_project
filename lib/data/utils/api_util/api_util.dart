import 'dart:io';

import 'package:dio/dio.dart';

import 'package:demo_project/data/utils/api_util/routes.dart';

class ApiUtil{
  final Dio _dio;

  ApiUtil(this._dio);

  Future<List> searchCharacters() async {
    late Response response;
    try {
      response = await _dio.get(
        Routes.searchCharacters
      );
    } catch (e) {
      if (e is DioError && e.response != null && e.response!.statusCode == 500) {
        throw ApiError.serverError;
      } else if (e is DioError && e.error is SocketException) {
        throw ApiError.connectionError;
      } else {
        throw ApiError.invalid;
      }
    }
    return response.data['results'];
  }
}

enum ApiError {serverError, connectionError, invalid}