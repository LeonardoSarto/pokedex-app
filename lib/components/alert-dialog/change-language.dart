import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pokeapi/model/pokemon/pokemon-specie.dart';
import 'package:pokeapi/model/pokemon/pokemon.dart';
import 'package:pokedex_project/models/poke-api.dart';
import 'package:pokedex_project/pages/pokemon-details/pokemon-details.dart';
import 'package:pokedex_project/utils/sprite-pokemon.dart';

import '../../utils/conversao.dart';

class ChangeLanguage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: Text("Idioma da interface"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioMenuButton(value: false, groupValue: true, onChanged: (value) {  }, child: Text("English (US)")),
          RadioMenuButton(value: false, groupValue: true, onChanged: (value) {  }, child: Text("Italiano (Italian)")),
          RadioMenuButton(value: false, groupValue: true, onChanged: (value) {  }, child: Text("Español (Spaninsh)")),
          RadioMenuButton(value: false, groupValue: true, onChanged: (value) {  }, child: Text("Deutsch (German)")),
          RadioMenuButton(value: false, groupValue: true, onChanged: (value) {  }, child: Text("Français (French)")),
          RadioMenuButton(value: true, groupValue: true, onChanged: (value) {  }, child: Text("Português (Portuguese)")),
          RadioMenuButton(value: false, groupValue: true, onChanged: (value) {  }, child: Text("Nederlands (Dutch)")),
          RadioMenuButton(value: false, groupValue: true, onChanged: (value) {  }, child: Text("Türçe (Turkish)")),
          RadioMenuButton(value: false, groupValue: true, onChanged: (value) {  }, child: Text("Polski (Polish)")),
          RadioMenuButton(value: false, groupValue: true, onChanged: (value) {  }, child: Text("български (BUlgarian)")),
          RadioMenuButton(value: false, groupValue: true, onChanged: (value) {  }, child: Text("हिंदी (Hindi)")),
          RadioMenuButton(value: false, groupValue: true, onChanged: (value) {  }, child: Text("עִברִית (Hebrew)")),
        ],
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancelar")),
      ],
    );
  }
}
