import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:pokeflutter/consts/consts_app.dart';
import 'package:pokeflutter/home_page/widgets/app_bar_home.dart';
import 'package:pokeflutter/home_page/widgets/poke_item.dart';
import 'package:pokeflutter/models/poke_api.dart';
import 'package:pokeflutter/poke_detail/poke_detail_page.dart';
import 'package:pokeflutter/stores/pokeapi_store.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _pokemonStore = Provider.of<PokeapiStore>(context);
    if(_pokemonStore.pokeAPI == null) _pokemonStore.fetchPokemonList();

    final _screenWidth = MediaQuery.of(context).size.width;
    final _statusBarWidth = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        alignment: Alignment.topCenter,
        overflow: Overflow.visible,
        children: <Widget>[
          Positioned(
            top: -(240 / 4.1),
            left: _screenWidth - (240 / 1.6),
            child: Opacity(
              child: Container(
                child: Image.asset(
                  ConstApp.blackPokeball,
                  height: 240,
                ),
              ),
              opacity: 0.1,
            ),
          ),
          Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: _statusBarWidth,
                ),
                AppBarHome(),
                Container(
                  child: Expanded(
                    child: Observer(
                      builder: (BuildContext context) {
                        if (_pokemonStore.pokeAPI == null) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return AnimationLimiter(
                          child: GridView.builder(
                            physics: BouncingScrollPhysics(),
                            padding: EdgeInsets.all(12),
                            addAutomaticKeepAlives: true,
                            gridDelegate:
                            new SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                            itemCount: _pokemonStore.pokeAPI.pokemon.length,
                            itemBuilder: (context, index) {
                              _pokemonStore.setPokemonAtual(index: index);
                              Pokemon pokemon =
                              _pokemonStore.currentPokemon;
                              return AnimationConfiguration.staggeredGrid(
                                position: index,
                                duration: const Duration(milliseconds: 375),
                                columnCount: 2,
                                child: ScaleAnimation(
                                  child: GestureDetector(
                                    child: PokeItem(
                                      index: index,
                                      name: pokemon.name,
                                      image: _pokemonStore.getImage(
                                          numero: pokemon.num),
                                      types: pokemon.type,
                                    ),
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PokeDetailPage(index: index,)));
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        );

                        /*return ListView(
                          children: pokeapiStore.pokeAPI.pokemon.map((poke){
                            return ListTile(
                              title: Text( poke.name ),
                            );
                          }).toList()
                        );*/
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
