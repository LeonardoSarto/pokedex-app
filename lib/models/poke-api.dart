import 'dart:convert';
import 'package:http/http.dart';
import 'package:pokeapi/model/evolution/evolution-chain.dart';
import 'package:pokeapi/model/item/item.dart';
import 'package:pokeapi/model/pokemon/pokemon-specie.dart';
import 'package:pokeapi/model/pokemon/pokemon.dart';
import 'package:pokeapi/model/pokemon/type.dart';
import 'package:pokeapi/model/utils/common.dart';
import 'package:pokeapi/pokeapi.dart';

class PokeAPI2 {


  static Future<Pokemon?> searchPokemonByName(String name) async {
    String url = await PokeAPI.getBaseUrl<Pokemon>();
    url += "$name";
    var response = await get(Uri.parse(url));
    Map listMap = json.decode(response.body);

    return Pokemon.fromJson(listMap as Map<String, dynamic>);
  }

  static Future<List<Pokemon?>> searchPokemonListByType(String type) async {
    List<Pokemon?> objectList =  [];
    String url = await PokeAPI.getBaseUrl<Type>();
    url += "$type";
    var response = await get(Uri.parse(url));
    Map listMap = json.decode(response.body);
    List<TypePokemon> commonResultList = Type.fromJson(listMap as Map<String, dynamic>).pokemon!;

    for (TypePokemon result in commonResultList) {
      response = await get(Uri.parse(result.pokemon!.url!));
      objectList.add(Pokemon.fromJson(jsonDecode(response.body) as Map<String, dynamic>));
    }

    return objectList;
  }

  static Future<PokemonSpecie?> searchPokemonSpecie(String url) async {
    var response = await get(Uri.parse(url));
    Map listMap = json.decode(response.body);

    return PokemonSpecie.fromJson(listMap as Map<String, dynamic>);
  }

  static Future<EvolutionChainChain?> searchEvolutionChain(String url) async {
    var response = await get(Uri.parse(url));
    Map listMap = json.decode(response.body);

    return EvolutionChainChain.fromJson(listMap["chain"] as Map<String, dynamic>);
  }

  static Future<Pokemon?> searchPokemonByUrl(String url) async {
    var response = await get(Uri.parse(url));
    Map listMap = json.decode(response.body);

    return Pokemon.fromJson(listMap as Map<String, dynamic>);
  }

  static Future<List<Pokemon?>> searchPokemonListByEvolutionChainChain(List<EvolutionChainChainEvolvesTo> evolutionChainChain) async {
    List<Pokemon?> objectList =  [];

    for (EvolutionChainChainEvolvesTo result in evolutionChainChain) {
      objectList.add(await searchPokemonByName(result.species!.name!));
    }

    return objectList;
  }

  static Future<Item> searchItemByUrl(String url) async {
    var response = await get(Uri.parse(url));
    Map listMap = json.decode(response.body);

    return Item.fromJson(listMap as Map<String, dynamic>);
  }
}