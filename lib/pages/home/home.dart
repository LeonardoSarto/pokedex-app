import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
import 'package:pokeapi/model/pokemon/pokemon-specie.dart';
import 'package:pokeapi/model/pokemon/pokemon.dart';
import 'package:pokeapi/model/pokemon/type.dart';
import 'package:pokeapi/model/utils/common.dart';
import 'package:pokedex_project/assets/colors/app-colors.dart';
import 'package:pokedex_project/components/alert-dialog/change-language.dart';
import 'package:pokedex_project/components/alert-dialog/search-pokemon.dart';
import 'package:pokedex_project/components/card-pokemon/card-pokemon.dart';
import 'package:pokedex_project/components/drawer/custom-drawer.dart';
import 'package:pokedex_project/models/model-theme.dart';
import 'package:pokedex_project/models/poke-api.dart';
import 'package:pokedex_project/utils/conversao.dart';
import 'package:pokedex_project/utils/cor-card-pokemon.dart';
import 'package:provider/provider.dart';
import 'package:pokeapi/pokeapi.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../components/search-delegate/custom-search-delegate.dart';
import '../../components/text-style/pokemon-solid-style.dart';
import '../pokemon-details/pokemon-details.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Pokemon?>? listaPokemons = [];
  late ScrollController _scrollController;
  int offset = 1;
  int limit = 20;
  bool isLoading = false;
  bool isTop = true;

  Future pagePokeApi(int offset, int limit) async {
    listaPokemons!.addAll(await PokeAPI.getObjectList<Pokemon>(offset, limit));
    setState(() {
    });
  }

  Future _pullRefresh() async {
    listaPokemons = await PokeAPI.getObjectList<Pokemon>(1, 20);
    setState(() {});
  }

  void _scrollListener() async {
    isTop = _scrollController.position.extentBefore < 300;
    if (_scrollController.position.atEdge) {
      if(!isTop && !isLoading) {
        isLoading = true;
        await pagePokeApi(offset += 20, limit);
        isLoading = false;
      }
    }
  }

  void scrollToTop() async {
    setState(() {
      if(!isTop) {
        _scrollController.animateTo(0, duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
      }
    });
  }

  @override
  void initState() {
    pagePokeApi(offset, limit);
    _scrollController = ScrollController()..addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, _) {
          return Scaffold(
            drawer: CustomDrawer(),
            extendBody: true,
            floatingActionButton: Container(
              child: IconButton(
                  style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(themeNotifier.isDark ? AppColors.darkMode : AppColors.lightMode)),
                  onPressed: () {
                    scrollToTop();
                  },
                  icon: Icon(Icons.arrow_upward)
              ),
            ),
            appBar: AppBar(
              title: Text(widget.title),
              actions: [
                IconButton(
                    onPressed: () {
                      showSearch(context: context, delegate: CustomSearchDelegate(listaPokemons));
                    },
                    icon: Icon(Icons.search)
                ),
                PopupMenuButton(
                  onSelected: (value) {
                    setState(() {
                    });
                  },
                  itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                    PopupMenuItem(
                      child: Text('Change theme'),
                      onTap: () {
                        setState(() {
                          themeNotifier.isDark = !themeNotifier.isDark;
                        });
                      },
                    ),
                    const PopupMenuItem(
                      child: Text('Item 2'),
                    ),
                    const PopupMenuItem(
                      child: Text('Settings'),
                    ),
                  ],
                ),
              ],
            ),
            body: Center(
              child: listaPokemons!.isNotEmpty ? Scrollbar(
                child: RefreshIndicator(
                  onRefresh: () {
                    return _pullRefresh();
                  },
                  child: CardPokemon(listaPokemons: listaPokemons,
                      scrollController: _scrollController
                  ),
                ),
              ) : CircularProgressIndicator(),
            ),
          );
        });
  }
}