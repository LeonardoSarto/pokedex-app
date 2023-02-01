import 'package:flutter/material.dart';
import 'package:pokedex_project/components/text-style/pokemon-style.dart';

class CustomTextField extends StatelessWidget {
  Icon? prefixIcon;
  String? hintText;

  CustomTextField({super.key, this.prefixIcon, this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: PokemonStyle(),
      decoration: InputDecoration(
          border: OutlineInputBorder(),
        hintText: hintText ?? "Placeholder",
        hintStyle: PokemonStyle(),
        prefixIcon: prefixIcon
      ),
    );
  }
}
