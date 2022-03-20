import 'package:demo_project/domain/bloc/serach_bloc.dart';
import 'package:demo_project/domain/models/character/character.dart';
import 'package:demo_project/main.dart';
import 'package:demo_project/presentation/constants/strings.dart';
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
  void dispose() {
    super.dispose();
    _bloc.close();
  }
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
          } else if (state is SearchBlocSearchReadyState) {
            return _SearchResultView(characters: state.characters);
          }
          return const LoadingView();
        },
      ),
    );
  }
}

class _SearchResultView extends StatelessWidget {

  final List<Character> characters;

  const _SearchResultView({
    Key? key,
    required this.characters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(
        vertical: 40,
        horizontal: 20
      ),
      itemBuilder: (_, i)=> Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: _CharacterCard(character: characters[i],),
      ),
      itemCount: characters.length,
    );
  }
}

class _CharacterCard extends StatelessWidget {
  final Character character;
  const _CharacterCard({
    Key? key,
    required this.character,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.blueGrey,
          width: 2,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.horizontal(
              left: Radius.circular(18),
            ),
            child: Image.network(
              character.image,
              height: 150,
              width: 100,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5,),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _InfoText(
                  title: characterNameString,
                  info: character.name,
                ),
                _InfoText(
                  title: characterSpeciesString,
                  info: character.species,
                ),
                _InfoText(
                  title: characterGenderString,
                  info: character.gender,
                ),
                _InfoText(
                  title: characterStatusString,
                  info: character.status,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _InfoText extends StatelessWidget {
  final String title;
  final String info;

  const _InfoText({
    Key? key,
    required this.title,
    required this.info,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
        Text(
          info,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: Colors.black,
          ),
        )
      ],
    );
  }
}


