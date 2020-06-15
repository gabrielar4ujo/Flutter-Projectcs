import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pokeflutter/consts/consts_api.dart';
import 'package:pokeflutter/consts/consts_app.dart';
import 'package:pokeflutter/stores/pokeapi_store.dart';
import 'package:provider/provider.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class PokeDetailPage extends StatelessWidget {
  final int index;
  final String name;

  PokeDetailPage({Key key, this.index, this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageController pageController = PageController(initialPage: index);
    final _pokemonStore = Provider.of<PokeapiStore>(context);
    _pokemonStore.setPokemonAtual(index: index);
    return Scaffold(
      appBar: AppBar(
        title: Opacity(
            opacity: 0,
            child: Text(
              _pokemonStore.currentPokemon.type[0],
              style: TextStyle(
                  fontFamily: 'Google',
                  fontWeight: FontWeight.bold,
                  fontSize: 21),
            )),
        backgroundColor: ConstApp.getColorType(type: _pokemonStore.currentPokemon.type[0]),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.favorite_border,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Observer(

        builder: (BuildContext context) => Container(
          color: ConstApp.getColorType(type: _pokemonStore.currentPokemon.type[0]),
          child: Stack(
            children: <Widget>[
              Container(
                color: ConstApp.getColorType(type: _pokemonStore.currentPokemon.type[0]),
                height: MediaQuery.of(context).size.height / 3,
              ),
              SlidingSheet(
                cornerRadius: 16,
                snapSpec: const SnapSpec(
                    snap: true,
                    snappings: [.7, 1],
                    positioning: SnapPositioning.relativeToAvailableSpace),
                builder: (context, state) {
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: Text("Centro"),
                    ),
                  );
                },
              ),
              Positioned(
                top: 40,
                left: 0,
                right: 0,
                child: SizedBox(
                  height: 150,
                  child: PageView.builder(
                      controller: pageController,
                      onPageChanged: (index){
                        _pokemonStore.setPokemonAtual(index: index);
                      },
                      itemCount: _pokemonStore.pokeAPI.pokemon.length,
                      itemBuilder: (BuildContext context, int count) {
                        _pokemonStore.setPokemonAtual(index: count);
                        return _pokemonStore.getImage(numero: _pokemonStore.currentPokemon.num);
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
