// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokeapi_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PokeapiStore on _PokeapiStore, Store {
  Computed<Pokemon> _$currentPokemonComputed;

  @override
  Pokemon get currentPokemon => (_$currentPokemonComputed ??= Computed<Pokemon>(
          () => super.currentPokemon,
          name: '_PokeapiStore.currentPokemon'))
      .value;
  Computed<PokeAPI> _$pokeAPIComputed;

  @override
  PokeAPI get pokeAPI => (_$pokeAPIComputed ??=
          Computed<PokeAPI>(() => super.pokeAPI, name: '_PokeapiStore.pokeAPI'))
      .value;

  final _$_pokeAPIAtom = Atom(name: '_PokeapiStore._pokeAPI');

  @override
  PokeAPI get _pokeAPI {
    _$_pokeAPIAtom.reportRead();
    return super._pokeAPI;
  }

  @override
  set _pokeAPI(PokeAPI value) {
    _$_pokeAPIAtom.reportWrite(value, super._pokeAPI, () {
      super._pokeAPI = value;
    });
  }

  final _$_currentPokemonAtom = Atom(name: '_PokeapiStore._currentPokemon');

  @override
  Pokemon get _currentPokemon {
    _$_currentPokemonAtom.reportRead();
    return super._currentPokemon;
  }

  @override
  set _currentPokemon(Pokemon value) {
    _$_currentPokemonAtom.reportWrite(value, super._currentPokemon, () {
      super._currentPokemon = value;
    });
  }

  final _$_PokeapiStoreActionController =
      ActionController(name: '_PokeapiStore');

  @override
  dynamic fetchPokemonList() {
    final _$actionInfo = _$_PokeapiStoreActionController.startAction(
        name: '_PokeapiStore.fetchPokemonList');
    try {
      return super.fetchPokemonList();
    } finally {
      _$_PokeapiStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPokemonAtual({int index}) {
    final _$actionInfo = _$_PokeapiStoreActionController.startAction(
        name: '_PokeapiStore.setPokemonAtual');
    try {
      return super.setPokemonAtual(index: index);
    } finally {
      _$_PokeapiStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  Widget getImage({String numero, double size}) {
    final _$actionInfo = _$_PokeapiStoreActionController.startAction(
        name: '_PokeapiStore.getImage');
    try {
      return super.getImage(numero: numero, size: size);
    } finally {
      _$_PokeapiStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
currentPokemon: ${currentPokemon},
pokeAPI: ${pokeAPI}
    ''';
  }
}
