import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:pokeflutter/consts/consts_api.dart';
import 'package:pokeflutter/models/poke_api.dart';
import 'package:http/http.dart' as http;
part 'pokeapi_store.g.dart';

class PokeapiStore = _PokeapiStore with _$PokeapiStore;

abstract class _PokeapiStore with Store {

  @observable
  PokeAPI _pokeAPI;

  @observable
  Pokemon _currentPokemon;

  @computed
  Pokemon get currentPokemon => _currentPokemon;

  @computed
  PokeAPI get pokeAPI => _pokeAPI;

  @action
  fetchPokemonList(){
    _pokeAPI = null;
    loadPokeAPI().then((pokeList) => _pokeAPI = pokeList );
  }

  @action
  void setPokemonAtual({int index}){
    _currentPokemon = _pokeAPI.pokemon[index];
  }

  Future<PokeAPI> loadPokeAPI() async {
    try {
      final response = await http.get(ConstsAPI.pokeapiURL);
      var decodeJson = jsonDecode(response.body);
      return PokeAPI.fromJson(decodeJson);
    } catch (error, stacktrace) {
      print("Erro ao carregar lista" + stacktrace.toString());
      return null;
    }
  }

  @action
  Widget getImage({String numero, double size}) {
    return CachedNetworkImage(
      placeholder: (context, uri) => Container(
        color: Colors.transparent,
      ),
      imageUrl: 'https://raw.githubusercontent.com/fanzeyi/pokemon.json/master/images/$numero.png',
      width: size ?? 80,
      height: size ?? 80,
    );

  }



}