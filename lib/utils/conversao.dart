import 'package:flutter/material.dart';
import 'package:pokeapi/model/pokemon/pokemon.dart';

class Conversao {

  static String primeiraLetraMaiuscula(String texto) {
    return texto.substring(0, 1).toUpperCase() + texto.substring(1);
  }
}