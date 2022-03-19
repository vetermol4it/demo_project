import 'package:demo_project/domain/bloc/serach_bloc.dart';
import 'package:demo_project/main.dart';
import 'package:demo_project/presentation/widgets/error_view.dart';
import 'package:demo_project/presentation/widgets/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  final SearchBloc _bloc = locator.get();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder(
        bloc: _bloc,
        builder: (_, state) {
          if (state is SearchBlocLoadingState) {
            return const LoadingView();
          } else if (state is SearchBlocErrorState) {
            return ErrorView(error: state.error);
          }
          return const SizedBox();
        },
      ),
    );
  }
}
