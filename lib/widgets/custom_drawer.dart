import 'package:flutter/material.dart';
import 'package:mix_burguer_app/models/user_model.dart';
import 'package:mix_burguer_app/screens/login_screen.dart';
import 'package:mix_burguer_app/tiles/drawer_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {
  final PageController pageController;

  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {



    Widget _buildDrawerBack() => Container(
          decoration: BoxDecoration(
            //gradient
            color: Colors.white
          ),
        );
    return Drawer(
      child: Stack(
        children: <Widget>[
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32.0, top: 36.0),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.only(
                    left: 0.0, top: 5.0, right: 16.0, bottom: 8.0),
                height: 220.0,
                child: Stack(
                  children: <Widget>[

                    Container(
                      alignment: Alignment.center,
                      height: 150,
                      margin: EdgeInsets.all(0.0),


                      child:Image.asset(
                        'assets/logo.png',
                      ),
                    ),

                    Positioned(
                        left: 0.0,
                        bottom: 0.0,
                        child: ScopedModelDescendant<UserModel>(
                          builder: (context, child, model) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Olá, ${!model.isloggedIn() ? "" : model.userData["name"]}",
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                GestureDetector(
                                  child: Text(
                                    !model.isloggedIn()
                                        ? "Entre ou cadastre-se"
                                        : "Sair",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                    ),
                                  ),
                                  onTap: () {
                                    if (!model.isloggedIn())
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen()));
                                    else
                                      model.sinOut();
                                  },
                                )
                              ],
                            );
                          },
                        ))
                  ],
                ),
              ),
              Divider(),
              DrawerTile(Icons.home, "Inicio", pageController, 0),
              DrawerTile(Icons.list, "Produtos", pageController, 1),
              DrawerTile(Icons.playlist_add_check, "Meus Pedidos", pageController, 2),
              DrawerTile(Icons.history, "Histórico de Pedidos", pageController, 3),
              DrawerTile(Icons.person, "Minhas Informações", pageController, 4),
              DrawerTile(Icons.access_time, "Compartilhe o APP", pageController, 5),
            ],
          )
        ],
      ),
    );
  }
}
