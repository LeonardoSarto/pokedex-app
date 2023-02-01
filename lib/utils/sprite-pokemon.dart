import 'package:flutter/material.dart';
import 'package:pokeapi/model/pokemon/pokemon.dart';

class SpritePokemon {

  static String retornaSprite(bool frontSprite, bool shinyVersion, bool femaleVersion, Sprites sprite) {

    if(frontSprite && femaleVersion && shinyVersion) {
      return sprite.frontShinyFemale!;
    } else if(frontSprite && femaleVersion) {
      return sprite.frontFemale!;
    } else if(frontSprite && shinyVersion) {
      return sprite.frontShiny!;
    } else if(femaleVersion && shinyVersion) {
      return sprite.backShinyFemale!;
    } else if(femaleVersion) {
      return sprite.backFemale!;
    } else if(shinyVersion) {
      return sprite.backShiny!;
    } else if(frontSprite) {
      return sprite.frontDefault!;
    } else {
      return sprite.backDefault!;
    }

  }
}