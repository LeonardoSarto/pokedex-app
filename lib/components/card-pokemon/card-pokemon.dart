import 'package:flutter/material.dart';
import 'package:pokeapi/model/pokemon/pokemon-specie.dart';
import 'package:pokeapi/model/pokemon/pokemon.dart';
import 'package:pokedex_project/models/poke-api.dart';
import 'package:pokedex_project/pages/pokemon-details/pokemon-details.dart';
import 'package:pokedex_project/utils/create-route.dart';

import '../../utils/conversao.dart';
import '../../utils/cor-card-pokemon.dart';

class CardPokemon extends StatefulWidget {
  List<Pokemon?>? listaPokemons;
  ScrollController? scrollController;

  CardPokemon({Key? key, required this.listaPokemons, this.scrollController}) : super(key: key);

  @override
  State<CardPokemon> createState() => _CardPokemonState();
}

class _CardPokemonState extends State<CardPokemon> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        controller: widget.scrollController ?? widget.scrollController,
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: widget.listaPokemons!.length,
        separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 20),
        itemBuilder: (context, index) {
          Color corCard = CorCardPokemon.devolveCor(widget.listaPokemons![index]!.types![0].type!.name!);
          return Card(
            shadowColor: Theme.of(context).primaryColor,
            elevation: 2,
            color: corCard,
            child: MaterialButton(
              splashColor: Colors.black12,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              onPressed: () async {
                PokemonSpecie? pokemonSpecie = await PokeAPI2.searchPokemonSpecie(widget.listaPokemons![index]!.species!.url!);
                Navigator.of(context).push(CreateRoute.createRoute(PokemonDetails(pokemonInfo: widget.listaPokemons![index]!, pokemonSpecie: pokemonSpecie!)));
              },
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 3,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        ListTile(
                          leading: Text("#${widget.listaPokemons![index]!.id!}"),
                          title: Text(Conversao.primeiraLetraMaiuscula(widget.listaPokemons![index]!.name!)),
                        ),
                        Row(
                          children: [
                            Spacer(),
                            Container(
                              width: widget.listaPokemons![index]!.types!.length > 1 ? 120 : 250,
                              height: 30,
                              decoration: BoxDecoration(
                                border: Border.all(color: Theme.of(context).primaryColor),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(child: Text(widget.listaPokemons![index]!.types![0].type!.name!, style: TextStyle(fontSize: 16))),
                            ),
                            if(widget.listaPokemons![index]!.types!.length > 1) Spacer(),
                            if(widget.listaPokemons![index]!.types!.length > 1) Container(
                              width: 120,
                              height: 30,
                              decoration: BoxDecoration(
                                border: Border.all(color: Theme.of(context).primaryColor),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Center(child: Text(widget.listaPokemons![index]!.types![1].type!.name!, style: TextStyle(fontSize: 16))),
                            ),
                            if(widget.listaPokemons![index]!.types!.length > 1) Spacer(),
                          ],
                        )
                      ],
                    ),
                  ),
                  widget.listaPokemons![index]!.sprites!.frontDefault != null ? Flexible(
                    child: Image.network(
                        widget.listaPokemons![index]!.sprites!.frontDefault!,
                        height: 100,
                        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) =>
                        loadingProgress == null ? child : Center(child: CircularProgressIndicator())
                    ),
                  ) : Container(height: 100),
                ],
              ),
            ),
          );
        }
    );
  }
}