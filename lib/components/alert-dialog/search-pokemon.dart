import 'package:flutter/material.dart';
import 'package:pokeapi/model/pokemon/pokemon.dart';
import 'package:pokedex_project/models/poke-api.dart';
import 'package:pokedex_project/utils/sprite-pokemon.dart';
import 'package:provider/provider.dart';

import '../../assets/colors/app-colors.dart';
import '../../models/model-theme.dart';
import '../../utils/conversao.dart';

class SearchPokemon extends StatefulWidget {

  SearchPokemon({Key? key}) : super(key: key);

  @override
  State<SearchPokemon> createState() => _SearchPokemonState();
}

class _SearchPokemonState extends State<SearchPokemon> {
  List<String> listTypes = ["grass", "fire", "water", "bug", "normal",
    "electric", "poison", "ground", "fairy", "fighting", "psychic", "ghost"];
  List<String> listTypeFilter = ["Type", "Name", "Ability"];
  String? selectedTypeValue = "grass";
  String? selectedTypeFilterValue = "Type";
  String searchByName = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {

    return Consumer(
        builder: (context, ModelTheme themeNotifier, _) {
          return !loading ? AlertDialog(
            backgroundColor: themeNotifier.isDark ? AppColors.darkMode : AppColors.lightMode,
            title: const Text("Filter pokémon"),
            content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField(
                    borderRadius: BorderRadius.circular(10),
                    decoration: InputDecoration(border: OutlineInputBorder()),
                    dropdownColor: AppColors.darkMode,
                    items: listTypeFilter.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedTypeFilterValue = value!;
                        selectedTypeValue = selectedTypeFilterValue == "Type" ? "grass" : null;
                      });
                    },
                    value: selectedTypeFilterValue,
                  ),
                  const SizedBox(height: 20),
                  if(selectedTypeFilterValue == "Type")
                    DropdownButtonFormField(
                      borderRadius: BorderRadius.circular(10),
                      decoration: InputDecoration(border: OutlineInputBorder()),
                      dropdownColor: AppColors.darkMode,
                      items: listTypes.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(Conversao.primeiraLetraMaiuscula(value)),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedTypeValue = value!;
                        });
                      },
                      value: selectedTypeValue,
                    ),
                  if(selectedTypeFilterValue == "Ability")
                    DropdownButtonFormField(
                      borderRadius: BorderRadius.circular(10),
                      decoration: InputDecoration(border: OutlineInputBorder()),
                      dropdownColor: AppColors.darkMode,
                      items: listTypes.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(Conversao.primeiraLetraMaiuscula(value)),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedTypeValue = value!;
                        });
                      },
                      value: selectedTypeValue,
                    ),
                  if(selectedTypeFilterValue == "Name")
                  TextField(
                    decoration: const InputDecoration(border: OutlineInputBorder(), labelText: "Name"),
                    onChanged: (value) {
                      searchByName = value;
                    },
                  ),
                ]
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text("Voltar")),
              TextButton(
                  onPressed: () async {
                    setState(() {
                      loading = true;
                    });
                    List<Pokemon?> pokemonList = [];
                    Pokemon? pokemon;
                    if(searchByName.isNotEmpty) pokemon = await PokeAPI2.searchPokemonByName(searchByName);
                    if(selectedTypeValue != null && selectedTypeValue!.isNotEmpty) pokemonList = await PokeAPI2.searchPokemonListByType(selectedTypeValue!);
                    if(pokemon != null) pokemonList.add(pokemon);
                    Navigator.pop(context, pokemonList);
                  },
                  child: const Text("Buscar")),
            ],
          ) : const Center(child: CircularProgressIndicator());
        }
    );
  }
}
