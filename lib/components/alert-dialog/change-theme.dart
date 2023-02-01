import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pokeapi/model/pokemon/pokemon-specie.dart';
import 'package:pokeapi/model/pokemon/pokemon.dart';
import 'package:pokedex_project/models/model-theme.dart';
import 'package:pokedex_project/models/poke-api.dart';
import 'package:pokedex_project/pages/pokemon-details/pokemon-details.dart';
import 'package:pokedex_project/utils/sprite-pokemon.dart';
import 'package:provider/provider.dart';

import '../../utils/conversao.dart';

class ChangeTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ModelTheme>(
        builder: (context, ModelTheme themeNotifier, _) {
          return AlertDialog(
            title: Text("Tema do aplicativo"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                RadioMenuButton(
                    value: themeNotifier.isDark,
                    groupValue: true,
                    onChanged: (value) {
                      themeNotifier.isDark = true;
                    },
                    child: const Text("Tema escuro")),
                RadioMenuButton(
                    value: themeNotifier.isDark ^ themeNotifier.isSystem,
                    groupValue: false,
                    onChanged: (value) {
                      themeNotifier.isDark = false;
                    },
                    child: const Text("Tema claro")),
                RadioMenuButton(
                    value: themeNotifier.isSystem,
                    groupValue: true,
                    onChanged: (value) {
                      themeNotifier.isSystem = true;
                    },
                    child: const Text("Definido pelo sistema")),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancelar")),
            ],
          );
        });
  }
}
