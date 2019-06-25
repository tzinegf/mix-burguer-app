import 'package:flutter/material.dart';
import 'package:mix_burguer_app/models/cart_model.dart';
import 'package:mix_burguer_app/models/user_model.dart';
import 'package:mix_burguer_app/tiles/cart_tile.dart';
import 'package:mix_burguer_app/widgets/cart_price.dart';
import 'package:mix_burguer_app/widgets/discount_cart.dart';
import 'package:mix_burguer_app/widgets/obs_card.dart';
import 'package:mix_burguer_app/widgets/payments_card.dart';
import 'package:scoped_model/scoped_model.dart';

import 'login_screen.dart';
import 'order_screen.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Meu Carrinho "),
        actions: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(right: 8.0),
            child: ScopedModelDescendant<CartModel>(
              builder: (context, child, model) {
                int qtdep = model.products.length;
                return Text(
                  "${qtdep ?? 0} ${qtdep == 1 ? "ITEM" : "ITENS"}",
                  style: TextStyle(fontSize: 18.0),
                );
              },
            ),
          ),
        ],
      ),
      body: ScopedModelDescendant<CartModel>(builder: (context, child, model) {
        if (model.isLoading && UserModel.of(context).isloggedIn()) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (!UserModel.of(context).isloggedIn()) {
          return Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.remove_shopping_cart,
                  size: 80.0,
                  color: Theme
                      .of(context)
                      .primaryColor,
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  "Faça o login para adicionar produtos!",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 16.0,
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  child: Text(
                    "Entrar",
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  textColor: Colors.white,
                  color: Theme
                      .of(context)
                      .primaryColor,
                )
              ],
            ),
          );
        }else if(model.products == null || model.products.length == 0){
          return Center(
            child: Text("Nehum produto no carrinho!",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
          );

        }else{
          return ListView(
            children: <Widget>[
              Column(
                children: model.products.map((product){
                  return CartTile(product);

                }).toList(),
              ),
              DiscountCart(),
              PaymentsCard(),
              ObsCard(),
              CartPrice(()async{
               String orderId = await model.finishOrder();
               if(orderId != null)
                 
                 Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>OrderScreen(orderId)));
                 


              })


            ],
          );

        }
      }),
    );
  }
}
