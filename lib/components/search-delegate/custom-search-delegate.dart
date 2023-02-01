import 'package:flutter/material.dart';
import 'package:pokeapi/model/pokemon/pokemon.dart';
import 'package:pokeapi/pokeapi.dart';
import 'package:pokedex_project/components/card-pokemon/card-pokemon.dart';

class CustomSearchDelegate extends SearchDelegate {
  List<Pokemon?>? listaPokemons = [];

  CustomSearchDelegate(this.listaPokemons);

  Future pagePokeApi() async {
    listaPokemons!.addAll(await PokeAPI.getObjectList<Pokemon>(0, 10000));
    listaPokemons!.contains(query);
  }


  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context);
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(icon: Icon(Icons.close), onPressed: () {}),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(icon: Icon(Icons.arrow_back), onPressed: () => Navigator.pop(context));
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: pagePokeApi(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return Container();
      }
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return CardPokemon(listaPokemons: listaPokemons);
  }
}