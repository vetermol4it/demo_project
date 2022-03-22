import 'dart:async';

import 'package:demo_project/data/utils/api_util/api_util.dart';
import 'package:logger/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:demo_project/domain/models/character/character.dart';
import 'package:demo_project/domain/repository/search_repository.dart';
import 'package:demo_project/presentation/constants/strings.dart';
import 'package:demo_project/main.dart';

class SearchBloc extends Bloc<SearchBlocEvent,SearchBlocState> {
  final SearchRepository _repository;

  SearchBloc(this._repository) : super(SearchBlocInitialState()) {
    on<SearchBlocInitialEvent>(_initialEventHandler);
    add(SearchBlocInitialEvent());
  }

  FutureOr<void> _initialEventHandler (event, emit) async {
    emit(SearchBlocLoadingState());
    try{
      final result = await _repository.searchCharacters();
      emit(SearchBlocSearchReadyState(result));
    } catch (e){
      locator<Logger>().e('Error', e.toString());

      String? errorText;
      if (e is ApiError && e == ApiError.serverError) {
        errorText = serverErrorString;
      } else if (e is ApiError && e == ApiError.connectionError) {
        errorText = connectionErrorString;
      }
      emit(SearchBlocErrorState(errorText));
    }
  }
}

abstract class SearchBlocEvent{}
class SearchBlocInitialEvent extends SearchBlocEvent{}

abstract class SearchBlocState{}
class SearchBlocInitialState extends SearchBlocState{}
class SearchBlocLoadingState extends SearchBlocState{}
class SearchBlocErrorState extends SearchBlocState{
  final String? error;

  SearchBlocErrorState([this.error]);
}
class SearchBlocSearchReadyState extends SearchBlocState{
  final List<Character> characters;

  SearchBlocSearchReadyState(this.characters);
}