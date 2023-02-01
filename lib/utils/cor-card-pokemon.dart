import 'package:flutter/material.dart';

class CorCardPokemon {

  static Color devolveCor(String tipoPokemon) {
    if(tipoPokemon == "grass") {
      return Colors.green;
    } else if(tipoPokemon == "fire") {
      return Colors.red;
    } else if(tipoPokemon == "water") {
      return Colors.blue;
    } else if(tipoPokemon == "bug") {
      return Colors.lightGreen;
    } else if(tipoPokemon == "normal") {
      return const Color.fromARGB(255, 181, 181, 162);
    } else if(tipoPokemon == "electric") {
      return Colors.yellow;
    } else if(tipoPokemon == "poison") {
      return const Color.fromARGB(255, 183, 110, 164);
    } else if(tipoPokemon == "ground") {
      return const Color.fromARGB(255, 226, 196, 107);
    } else if(tipoPokemon == "fairy") {
      return const Color.fromARGB(255, 240, 166, 236);
    } else if(tipoPokemon == "fighting") {
      return const Color.fromARGB(255, 197, 110, 92);
    } else if(tipoPokemon == "psychic") {
      return const Color.fromARGB(255, 255, 110, 164);
    } else if(tipoPokemon == "ghost") {
      return const Color.fromARGB(255, 125, 124, 193);
    } else if(tipoPokemon == "dragon") {
      return const Color.fromARGB(255, 139, 124, 236);
    } else if(tipoPokemon == "rock") {
      return const Color.fromARGB(255, 197, 182, 121);
    } else if(tipoPokemon == "ice") {
      return const Color.fromARGB(255, 124, 210, 250);
    } else if(tipoPokemon == "dark") {
      return const Color.fromARGB(255, 139, 110, 92);
    } else if(tipoPokemon == "steel") {
      return const Color.fromARGB(255, 183, 182, 193);
    } else if(tipoPokemon == "flying") {
      return const Color.fromARGB(255, 154, 167, 251);
    }

    return Colors.transparent;
  }
}