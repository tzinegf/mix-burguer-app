import 'package:flutter/material.dart';
import 'package:mix_burguer_app/screens/home_secreen.dart';
import 'package:mix_burguer_app/screens/login_screen.dart';
import 'package:scoped_model/scoped_model.dart';

import 'models/cart_model.dart';
import 'models/user_model.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: ScopedModelDescendant<UserModel>(
          builder: (context, child, model){
            return ScopedModel<CartModel>(
              model: CartModel(model),
              child: MaterialApp(
                  title: "Mix Burguer",
                  theme: ThemeData(
                      primarySwatch: Colors.red,
                      primaryColor: Colors.red
                  ),
                  debugShowCheckedModeBanner: false,
                  home: HomeScreen()
              ),
            );
          }
      ),
    );
  }
}
