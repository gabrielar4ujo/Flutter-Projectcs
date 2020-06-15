import 'package:flutter/material.dart';
import 'package:loja_virtual_app/models/user_model.dart';
import 'package:loja_virtual_app/screens/login_screen.dart';
import 'package:loja_virtual_app/tiles/drawer_tile.dart';
import 'package:scoped_model/scoped_model.dart';


class CustomDrawer extends StatelessWidget {

  final PageController pageController;

  const CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {
    Widget _buildDrawerBack() => Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 203, 236, 241),
                Colors.white
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter
          )
      ),
    );

    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32, top: 16),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8),
                padding: EdgeInsets.fromLTRB(0, 16, 16, 8),
                height: 170,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      top: 8, //Distancia do top
                      left: 0,
                      child: Text(
                        "Flutter's \nClothing",
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0, //Distancia do top
                      left: 0,
                      child: ScopedModelDescendant<UserModel>(
                        builder: (context, child, model) {
                          print(model.isLoggedIn());
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Olá, ${model.isLoggedIn() ? model.userData["name"] : ""}",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              GestureDetector(
                                onTap: (){
                                  if(model.isLoggedIn()) {
                                    print("Deslogar");
                                    model.signOut();
                                  }

                                  else{
                                    print("Logar");
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => LoginScreen()
                                    ));
                                  }
                                },
                                child: Text(
                                  model.isLoggedIn() ? "Sair" : "Entre ou cadastre-se",
                                  style: TextStyle(
                                      color: Theme.of(context).primaryColor, //Pega a primary color declarada no arquivo main.dart
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      )
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: 35
                ),
                child: Divider(),
              ),
              DrawerTile(Icons.home, "Início", pageController,0),
              DrawerTile(Icons.list, "Produtos", pageController,1),
              DrawerTile(Icons.location_on, "Loja", pageController,2),
              DrawerTile(Icons.playlist_add_check, "Meus Pedidos", pageController,3),
            ],
          )
        ],
      ),
    );
  }
}
