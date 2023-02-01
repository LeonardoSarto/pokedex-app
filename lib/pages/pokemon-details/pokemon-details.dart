import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pokeapi/model/evolution/evolution-chain.dart';
import 'package:pokeapi/model/item/item.dart';
import 'package:pokeapi/model/pokemon/pokemon-specie.dart';
import 'package:pokeapi/model/pokemon/pokemon.dart';
import 'package:pokedex_project/assets/colors/app-colors.dart';
import 'package:pokedex_project/models/model-theme.dart';
import 'package:pokedex_project/models/poke-api.dart';
import 'package:pokedex_project/utils/conversao.dart';
import 'package:pokedex_project/utils/cor-card-pokemon.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class PokemonDetails extends StatefulWidget {
  Pokemon pokemonInfo;

  PokemonSpecie pokemonSpecie;

  PokemonDetails({Key? key, required this.pokemonInfo, required this.pokemonSpecie}) : super(key: key);

  @override
  State<PokemonDetails> createState() => _PokemonDetailsState();
}

class _PokemonDetailsState extends State<PokemonDetails> {
  int sumBaseStats = 0;

  int _selectedIndex = 0;

  EvolutionChainChain? _evolutionChain;

  Pokemon? _firstChain;

  List<Pokemon?> _secondChain = [];

  List<Pokemon?> _thirdChain = [];

  Item? item;

  List<Pokemon?> listPokemonVariety = [];

  Future getEvolutionChain() async {
    _evolutionChain = await PokeAPI2.searchEvolutionChain(widget.pokemonSpecie.evolutionChain!.url!);
    _firstChain = await PokeAPI2.searchPokemonByName(_evolutionChain!.species!.name!);
    _secondChain = await PokeAPI2.searchPokemonListByEvolutionChainChain(_evolutionChain!.evolvesTo!);
    for(EvolutionChainChainEvolvesTo result in _evolutionChain!.evolvesTo!) {
      _thirdChain = await PokeAPI2.searchPokemonListByEvolutionChainChain(result.evolvesTo!);
    }
    setState(() {});
  }

  Future getAlternativeForms() async {
    for (var element in widget.pokemonSpecie.varieties!) {
      listPokemonVariety.add(await PokeAPI2.searchPokemonByUrl(element.pokemon!.url!));
    }
    setState(() {});
  }

  Future<Widget> widgetEvolutionMethod(EvolutionChainChainEvolvesToEvolutionDetail evolutionDetail) async {

    if(evolutionDetail.minLevel != null) {
      return Column(
        children: [
          const Text("Level"),
          Text(evolutionDetail.minLevel!.toString()),
        ],
      );
    }

    if(evolutionDetail.minHappiness != null) {
      return Column(
        children: [
          const Text("Hap."),
          Text(evolutionDetail.minHappiness!.toString()),
        ],
      );
    }

    if(evolutionDetail.minAffection != null) {
      return Column(
        children: [
          const Text("Aff."),
          Text(evolutionDetail.minAffection!.toString()),
        ],
      );
    }

    if(evolutionDetail.location != null) {
      return Text(evolutionDetail.location["name"], style: TextStyle(fontSize: 10));
    }

    if(evolutionDetail.item != null) {
      item = await PokeAPI2.searchItemByUrl(evolutionDetail.item["url"]);
      return Image.network(item!.sprites!.sprite!);
    }

    return Text(Conversao.primeiraLetraMaiuscula(evolutionDetail.trigger!.name!));
  }


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    getEvolutionChain();
    getAlternativeForms();
    widget.pokemonInfo.stats!.forEach((element) {
      sumBaseStats += element.baseStat!;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, _) {
          return Scaffold(
            backgroundColor: CorCardPokemon.devolveCor(widget.pokemonInfo.types![0].type!.name!),
            appBar: AppBar(
              title: Text("Pokemon"),
              actions: [
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.info_outline),
                  label: 'Info',
                  backgroundColor: CorCardPokemon.devolveCor(widget.pokemonInfo.types![0].type!.name!),
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.book),
                  label: 'Moves',
                  backgroundColor: CorCardPokemon.devolveCor(widget.pokemonInfo.types![0].type!.name!),
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.plus),
                  label: 'More',
                  backgroundColor: CorCardPokemon.devolveCor(widget.pokemonInfo.types![0].type!.name!),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.more_horiz),
                  label: 'Menu',
                  backgroundColor: CorCardPokemon.devolveCor(widget.pokemonInfo.types![0].type!.name!),
                ),
              ],
              currentIndex: _selectedIndex,
              onTap: _onItemTapped,
            ),
            body: SingleChildScrollView(
              child: Center(
                child: _firstChain != null ? Column(
                  children: [
                    SizedBox(height: 7),
                    Card(
                        color: Theme.of(context).primaryColor,
                        child: Container(
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(Conversao.primeiraLetraMaiuscula(widget.pokemonInfo.name!), style: Theme.of(context).textTheme.titleMedium),
                                        Text("#${widget.pokemonInfo.id!}", style: Theme.of(context).textTheme.titleMedium),
                                      ],
                                    ),
                                    Text(Conversao.primeiraLetraMaiuscula(widget.pokemonSpecie.genera!.firstWhere((element) => element.language!.name! == "en").genus!), style: Theme.of(context).textTheme.titleMedium),
                                    Row(
                                      children: [
                                        Container(
                                          constraints: BoxConstraints(maxWidth: 110),
                                          decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.black26), borderRadius: BorderRadius.circular(10)),
                                          padding: EdgeInsets.all(2),
                                          child: Center(child: Text(_firstChain!.types![0].type!.name!, style: TextStyle(fontSize: 16))),
                                        ),
                                        SizedBox(width: 10),
                                        if(_firstChain!.types!.length > 1) Container(
                                          constraints: BoxConstraints(maxWidth: 110),
                                          decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.black26), borderRadius: BorderRadius.circular(10)),
                                          padding: EdgeInsets.all(2),
                                          child: Center(child: Text(_firstChain!.types![1].type!.name!, style: TextStyle(fontSize: 16))),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Image.network(
                                    height: 100,
                                    width: 100,
                                    widget.pokemonInfo.sprites!.frontDefault!,
                                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) =>
                                    loadingProgress == null ? child : Center(child: CircularProgressIndicator())
                                ),
                              ],
                            )
                        )
                    ),
                    SizedBox(height: 20),
                    Text("Species", style: Theme.of(context).textTheme.titleMedium,),
                    Card(
                        color: Theme.of(context).primaryColor,
                        child: Container(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.black26), borderRadius: BorderRadius.circular(10)),
                                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                                child: Text(
                                  widget.pokemonSpecie.flavorTextEntries!.firstWhere((element) => (element.version!.name == "shield" || element.version!.name == "lets-go-eevee") && element.language!.name == "en").flavorText!.replaceAll("\n", ""),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Text("Pokédex entry (from Pokémon Sword and Shield)", style: Theme.of(context).textTheme.labelSmall,),
                              SizedBox(height: 20),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.black26), borderRadius: BorderRadius.circular(10)),
                                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 8),
                                          child: Text("6'7\" (2.01m)"),
                                        ),
                                        Text("Height", style: Theme.of(context).textTheme.labelSmall,),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.black26), borderRadius: BorderRadius.circular(10)),
                                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                                          child: Text("220.46 lbs (100.0 kg)"),
                                        ),
                                        Text("Width", style: Theme.of(context).textTheme.labelSmall,),
                                      ],
                                    ),
                                  ]),
                            ],
                          ),
                        )
                    ),
                    SizedBox(height: 20),
                    Text("Abilities", style: Theme.of(context).textTheme.titleMedium),
                    Card(
                        color: Theme.of(context).primaryColor,
                        child: Container(
                          padding: EdgeInsets.all(20),
                          child: ListView.separated(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: widget.pokemonInfo.abilities!.length,
                              separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 15),
                              itemBuilder: (context, index) {
                                return Container(
                                  height: 40,
                                  decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.black26), borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    children: [
                                      Spacer(),
                                      widget.pokemonInfo.abilities![index].isHidden! ? Text("Hidden", style: Theme.of(context).textTheme.labelMedium) : Container(width: 50),
                                      Spacer(flex: 8),
                                      Text(
                                          Conversao.primeiraLetraMaiuscula(widget.pokemonInfo.abilities![index].ability!.name!),
                                          textAlign: TextAlign.center, style: Theme.of(context).textTheme.labelMedium
                                      ),
                                      Spacer(flex: 8),
                                      IconButton(onPressed: (){}, icon: Icon(Icons.info_outline, color: Colors.black54)),
                                      Spacer(),
                                    ],
                                  ),
                                );
                              }
                          ),
                        )
                    ),
                    SizedBox(height: 20),
                    Text("Base Stats", style: Theme.of(context).textTheme.titleMedium),
                    Card(
                        color: Theme.of(context).primaryColor,
                        child: Container(
                          padding: EdgeInsets.all(20),
                          child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Chip(
                                        backgroundColor: CorCardPokemon.devolveCor(widget.pokemonInfo.types![0].type!.name!),
                                        labelPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                        label: Text("Base Stats", style: Theme.of(context).textTheme.labelMedium,)
                                    ),
                                    Chip(
                                        backgroundColor: CorCardPokemon.devolveCor(widget.pokemonInfo.types![0].type!.name!),
                                        labelPadding: EdgeInsets.symmetric(horizontal: 32.5, vertical: 0),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                        label: Text("Min", style: Theme.of(context).textTheme.labelMedium,)
                                    ),
                                    Chip(
                                        backgroundColor: CorCardPokemon.devolveCor(widget.pokemonInfo.types![0].type!.name!),
                                        labelPadding: EdgeInsets.symmetric(horizontal: 32.5, vertical: 0),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                        label: Text("Max", style: Theme.of(context).textTheme.labelMedium,)
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15),
                                ListView.separated(
                                    shrinkWrap: true,
                                    itemCount: widget.pokemonInfo.stats!.length,
                                    physics: NeverScrollableScrollPhysics(),
                                    separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 8),
                                    itemBuilder: (context, index) {
                                      return Row(
                                        children: [
                                          Container(
                                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: CorCardPokemon.devolveCor(widget.pokemonInfo.types![0].type!.name!)),
                                              height: 30,
                                              constraints: BoxConstraints(maxWidth: 340, minWidth: 100),
                                              width: widget.pokemonInfo.stats![index].baseStat!.toDouble() * 3.2,
                                              child: Center(
                                                child: Row(
                                                  children: [
                                                    Spacer(),
                                                    Text(Conversao.primeiraLetraMaiuscula(widget.pokemonInfo.stats![index].stat!.name!.replaceAll("-", ". ").replaceAll("special", "sp")),
                                                        style: Theme.of(context).textTheme.labelMedium
                                                    ),
                                                    Spacer(flex: 10),
                                                    Text(widget.pokemonInfo.stats![index].baseStat!.toString()),
                                                    Spacer(),
                                                  ],
                                                ),
                                              )
                                          ),
                                        ],
                                      );
                                    }
                                ),
                                SizedBox(height: 20),
                                RichText(
                                    text: TextSpan(
                                        text: "TOTAL ",
                                        style: Theme.of(context).textTheme.labelMedium,
                                        children: [
                                          TextSpan(text: sumBaseStats.toString(),
                                              style: TextStyle(color: CorCardPokemon.devolveCor(widget.pokemonInfo.types![0].type!.name!))
                                          )
                                        ])),
                              ]),
                        )
                    ),
                    if(_secondChain.isNotEmpty) SizedBox(height: 20),
                    if(_secondChain.isNotEmpty) Text("Evolution chain", style: Theme.of(context).textTheme.titleMedium),
                    if(_secondChain.isNotEmpty) Card(
                        color: Theme.of(context).primaryColor,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: 90,
                                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: CorCardPokemon.devolveCor(widget.pokemonInfo.types![0].type!.name!)),
                                child: Column(
                                  children: [
                                    Image.network(
                                        height: 100,
                                        width: 100,
                                        _firstChain!.sprites!.frontDefault!,
                                        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) =>
                                        loadingProgress == null ? child : Center(child: CircularProgressIndicator())
                                    ),
                                    Text("# ${_firstChain!.id!}"),
                                    Text(Conversao.primeiraLetraMaiuscula(_firstChain!.name!)),
                                    SizedBox(height: 5),
                                    Container(
                                      width: 80,
                                      child: ListView.separated(
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 5),
                                          itemCount: _firstChain!.types!.length,
                                          itemBuilder: (context, index) {
                                            return Center(
                                              child: Container(
                                                decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.black26), borderRadius: BorderRadius.circular(10)),
                                                padding: EdgeInsets.all(2),
                                                child: Text(_firstChain!.types![index].type!.name!.toUpperCase()),
                                              ),
                                            );
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                              if(_secondChain.isNotEmpty) Container(
                                constraints: BoxConstraints(maxWidth: 40),
                                child: ListView.separated(
                                    separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 140),
                                    physics: NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: _secondChain.length,
                                    itemBuilder: (context, index2) {
                                      return Column(
                                        children: [
                                          Icon(Icons.arrow_forward, color: Colors.black),
                                          FutureBuilder(
                                              future: widgetEvolutionMethod(_evolutionChain!.evolvesTo![index2].evolutionDetails![0]),
                                              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                                return snapshot.hasData ? snapshot.data : Container(height: 95, child: Center(child: const CircularProgressIndicator()));
                                              }
                                          ),
                                        ],
                                      );
                                    }
                                ),
                              ),
                              if(_secondChain.isNotEmpty) Container(
                                width: 100,
                                child: ListView.separated(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: _secondChain.length,
                                    separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 5),
                                    itemBuilder: (context, index2) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: CorCardPokemon.devolveCor(widget.pokemonInfo.types![0].type!.name!)),
                                        child: Column(
                                          children: [
                                            Image.network(
                                                height: 100,
                                                width: 100,
                                                _secondChain[index2]!.sprites!.frontDefault!,
                                                loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) =>
                                                loadingProgress == null ? child : Center(child: CircularProgressIndicator())
                                            ),
                                            Text("# ${_secondChain[index2]!.id!}"),
                                            Text(Conversao.primeiraLetraMaiuscula(_secondChain[index2]!.name!)),
                                            SizedBox(height: 5),
                                            Container(
                                              width: 80,
                                              child: ListView.separated(
                                                  shrinkWrap: true,
                                                  physics: NeverScrollableScrollPhysics(),
                                                  separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 5),
                                                  itemCount: _secondChain[index2]!.types!.length,
                                                  itemBuilder: (context, index) {
                                                    return Center(
                                                      child: Container(
                                                        decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.black26), borderRadius: BorderRadius.circular(10)),
                                                        padding: EdgeInsets.all(2),
                                                        child: Text(_secondChain[index2]!.types![index].type!.name!.toUpperCase()),
                                                      ),
                                                    );
                                                  }),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                ),
                              ),
                              if(_thirdChain.isNotEmpty) Column(
                                children: [
                                  Icon(Icons.arrow_forward, color: Colors.black),
                                  FutureBuilder(
                                      future: widgetEvolutionMethod(_evolutionChain!.evolvesTo![0].evolvesTo![0].evolutionDetails![0]),
                                      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                        return snapshot.hasData ? snapshot.data : Container(height: 95, child: Center(child: const CircularProgressIndicator()));
                                      }
                                  ),
                                ],
                              ),
                              if(_thirdChain.isNotEmpty) Container(
                                width: 80,
                                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: CorCardPokemon.devolveCor(widget.pokemonInfo.types![0].type!.name!)),
                                child: Column(
                                  children: [
                                    Image.network(
                                        height: 100,
                                        width: 100,
                                        _thirdChain[0]!.sprites!.frontDefault!,
                                        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) =>
                                        loadingProgress == null ? child : Center(child: CircularProgressIndicator())
                                    ),
                                    Text("# ${_thirdChain[0]!.id!}"),
                                    Text(Conversao.primeiraLetraMaiuscula(_thirdChain[0]!.name!)),
                                    SizedBox(height: 5),
                                    Container(
                                      width: 80,
                                      child: ListView.separated(
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 5),
                                          itemCount: _thirdChain[0]!.types!.length,
                                          itemBuilder: (context, index) {
                                            return Center(
                                              child: Container(
                                                decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.black26), borderRadius: BorderRadius.circular(10)),
                                                padding: EdgeInsets.all(2),
                                                child: Text(_thirdChain[0]!.types![index].type!.name!.toUpperCase()),
                                              ),
                                            );
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                    ),
                    if (listPokemonVariety.length >= 2) SizedBox(height: 20),
                    if (listPokemonVariety.length >= 2) Text("Alternative forms", style: Theme.of(context).textTheme.titleMedium),
                    if (listPokemonVariety.length >= 2) Card(
                        color: Theme.of(context).primaryColor,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  width: 1600,
                                  height: 225,
                                  child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: listPokemonVariety.length,
                                      shrinkWrap: true,
                                      physics: listPokemonVariety.length >= 3 ? AlwaysScrollableScrollPhysics() : NeverScrollableScrollPhysics(),
                                      separatorBuilder: (BuildContext context, int index) => const SizedBox(width: 15),
                                      itemBuilder: (context, index) {
                                        return Container(
                                          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: CorCardPokemon.devolveCor(widget.pokemonInfo.types![0].type!.name!)),
                                          child: Column(
                                            children: [
                                              listPokemonVariety[index]!.sprites!.frontDefault != null ? Image.network(
                                                  height: 100,
                                                  width: 100,
                                                  listPokemonVariety[index]!.sprites!.frontDefault!,
                                                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) =>
                                                  loadingProgress == null ? child : Center(child: CircularProgressIndicator())
                                              ) : Image.asset("lib/assets/images/placeholder-pokeball.png", height: 100, width: 100),
                                              Text("# ${listPokemonVariety[index]!.id!}"),
                                              Text(Conversao.primeiraLetraMaiuscula(listPokemonVariety[index]!.name!), textAlign: TextAlign.center,),
                                              SizedBox(height: 5),
                                              Container(
                                                width: 80,
                                                child: ListView.separated(
                                                    shrinkWrap: true,
                                                    physics: NeverScrollableScrollPhysics(),
                                                    separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 5),
                                                    itemCount: listPokemonVariety[index]!.types!.length,
                                                    itemBuilder: (context, index1) {
                                                      return Center(
                                                        child: Container(
                                                          decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.black26), borderRadius: BorderRadius.circular(10)),
                                                          padding: EdgeInsets.all(2),
                                                          child: Text(listPokemonVariety[index]!.types![index1].type!.name!.toUpperCase()),
                                                        ),
                                                      );
                                                    }),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                    ),
                    SizedBox(height: 20),
                    Text("Sprites", style: Theme.of(context).textTheme.titleMedium),
                    Card(
                        color: Theme.of(context).primaryColor,
                        child: Container(
                          padding: EdgeInsets.all(20),
                          child: Column(
                              children: [
                                if(widget.pokemonInfo.sprites!.backDefault != null && widget.pokemonInfo.sprites!.frontDefault != null) Text("Normal", style: Theme.of(context).textTheme.titleMedium),
                                if(widget.pokemonInfo.sprites!.backDefault != null && widget.pokemonInfo.sprites!.frontDefault != null) Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    widget.pokemonInfo.sprites!.frontDefault != null ? Image.network(widget.pokemonInfo.sprites!.frontDefault!) : Image.asset("lib/assets/images/placeholder-pokeball.png", height: 100, width: 100),
                                    widget.pokemonInfo.sprites!.backDefault != null ? Image.network(widget.pokemonInfo.sprites!.backDefault!) : Image.asset("lib/assets/images/placeholder-pokeball.png", height: 100, width: 100),
                                  ],
                                ),
                                if(widget.pokemonInfo.sprites!.frontShiny != null && widget.pokemonInfo.sprites!.backShiny != null) Text("Shiny", style: Theme.of(context).textTheme.titleMedium),
                                if(widget.pokemonInfo.sprites!.frontShiny != null && widget.pokemonInfo.sprites!.backShiny != null) Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    widget.pokemonInfo.sprites!.frontShiny != null ? Image.network(widget.pokemonInfo.sprites!.frontShiny!) : Image.asset("lib/assets/images/placeholder-pokeball.png", height: 100, width: 100),
                                    widget.pokemonInfo.sprites!.backShiny != null ? Image.network(widget.pokemonInfo.sprites!.backShiny!) : Image.asset("lib/assets/images/placeholder-pokeball.png", height: 100, width: 100),
                                  ],
                                ),
                                if(widget.pokemonInfo.sprites!.frontFemale != null && widget.pokemonInfo.sprites!.backFemale != null) Text("Female", style: Theme.of(context).textTheme.titleMedium),
                                if(widget.pokemonInfo.sprites!.frontFemale != null && widget.pokemonInfo.sprites!.backFemale != null) Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    widget.pokemonInfo.sprites!.frontFemale != null ? Image.network(widget.pokemonInfo.sprites!.frontFemale!) : Image.asset("lib/assets/images/placeholder-pokeball.png", height: 100, width: 100),
                                    widget.pokemonInfo.sprites!.backFemale != null ? Image.network(widget.pokemonInfo.sprites!.backFemale!) : Image.asset("lib/assets/images/placeholder-pokeball.png", height: 100, width: 100),
                                  ],
                                ),
                                if(widget.pokemonInfo.sprites!.frontShinyFemale != null && widget.pokemonInfo.sprites!.backShinyFemale != null) Text("Female shiny", style: Theme.of(context).textTheme.titleMedium),
                                if(widget.pokemonInfo.sprites!.frontShinyFemale != null && widget.pokemonInfo.sprites!.backShinyFemale != null) Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    widget.pokemonInfo.sprites!.frontShinyFemale != null ? Image.network(widget.pokemonInfo.sprites!.frontShinyFemale!) : Image.asset("lib/assets/images/placeholder-pokeball.png", height: 100, width: 100),
                                    widget.pokemonInfo.sprites!.backShinyFemale != null ? Image.network(widget.pokemonInfo.sprites!.backShinyFemale!) : Image.asset("lib/assets/images/placeholder-pokeball.png", height: 100, width: 100),
                                  ],
                                ),
                              ]),
                        )
                    ),
                    SizedBox(height: 10),
                  ],
                ) : CircularProgressIndicator(),
              ),
            ),
          );
        });
  }
}
