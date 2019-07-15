import 'package:flutter/material.dart';
import 'package:mix_burguer_app/tabs/history_tab.dart';
import 'package:mix_burguer_app/tabs/home_tab.dart';
import 'package:mix_burguer_app/tabs/orders_tab.dart';
import 'package:mix_burguer_app/tabs/products_tab.dart';
import 'package:mix_burguer_app/tabs/userPerfil_tab.dart';
import 'package:mix_burguer_app/widgets/cart_button.dart';
import 'package:mix_burguer_app/widgets/custom_drawer.dart';
import 'package:share/share.dart';

class HomeScreen extends StatelessWidget {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: <Widget>[
        Scaffold(
          body: HomeTab(),
          drawer: CustomDrawer(_pageController),
          floatingActionButton: CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Produtos"),
            centerTitle: true,
          ),
          drawer: CustomDrawer(_pageController),
          body: ProductsTab(),
          floatingActionButton: CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Meus Pedidos"),
            centerTitle: true,
          ),
          body: OrdersTab(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Hitórico de Pedidos"),
            centerTitle: true,
          ),
          body: HistoryTab(),
          drawer: CustomDrawer(_pageController),
        ),
        Scaffold(
          drawer: CustomDrawer(_pageController),
          body: UserPerfilTab(),
          floatingActionButton: CartButton(),
        ),
        Scaffold(
          appBar: AppBar(
            title: Text("Compartilhe o App"),
            centerTitle: true,
          ),
          body: Center(
              child: RaisedButton(
                color: Colors.deepOrange,
                elevation: 10,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)),side: BorderSide(color: Colors.red)),
                  child: Text("Compartilhe nosso App"),
                  onPressed: () {
                    Share.share(
                        "https://play.google.com/store/apps/details?id=br.com.qbelezapp");
                  })),
          drawer: CustomDrawer(_pageController),
        ),
      ],
    );
  }
}
