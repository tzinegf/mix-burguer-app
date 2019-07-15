import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mix_burguer_app/datas/cart_product.dart';
import 'package:mix_burguer_app/datas/product_data.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:mix_burguer_app/models/cart_model.dart';
import 'package:mix_burguer_app/models/user_model.dart';

import 'cart_screen.dart';
import 'login_screen.dart';

class ProductScreen extends StatefulWidget {
  final ProductData productData;


  ProductScreen(this.productData);

  @override
  _ProductScreenState createState() => _ProductScreenState(productData);
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductData productData;
  final Map<String, dynamic> daysOfWeek = {
    'Sunday': 0,
    'Monday': 1,
    'Tuesday': 2,
    'Wednesday': 3,
    'Thursday': 4,
    'Friday': 5,
    'Saturday': 6
  };
  String comp;
  String formattedDate = DateFormat('EEEE').format(new DateTime.now());

  _ProductScreenState(this.productData);


  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          productData.title,
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 0.9,
            child: Carousel(
              overlayShadow: true,
              overlayShadowSize: 0.3,
              images: productData.images.map((url) {
                return NetworkImage(url);
              }).toList(),
              dotSize: 4.0,
              dotSpacing: 15.0,
              dotBgColor: Colors.transparent,
              dotColor: primaryColor,
              autoplay: false,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  productData.title,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 3,
                ),
                Text(
                  "R\$${productData.price.toStringAsFixed(2)}",
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: primaryColor),
                ),
                SizedBox(
                  height: 16.0,
                ),
                Text(
                  "Ingredientes:",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10.0,
                ),
                SizedBox(
                  child: Text(
                    "${productData.description}",
                    style: TextStyle(fontSize: 15.0),
                  ),
                ),

                /*ListView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                      children: Text(),productData.complements.map((complements) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              comp = complements;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4),
                                ),
                                border: Border.all(),
                                color: complements == comp
                                    ? primaryColor
                                    : Colors.grey[200]),
                            margin: EdgeInsets.only(right: 10),
                            padding: EdgeInsets.all(5),
                            alignment: Alignment.center,
                            child: Text(complements),
                          ),
                        );
                      }).toList()),*/

                SizedBox(
                  height: 16.0,
                ),
                SizedBox(
                  height: 44.0,
                  child: RaisedButton(
                    onPressed: () {
                      if (UserModel.of(context).isloggedIn()) {
                        CartProduct cartProduct = CartProduct();
                        cartProduct.complement = comp;
                        cartProduct.qtde = 1;
                        cartProduct.pid = productData.id;
                        cartProduct.category = productData.category;
                        cartProduct.productData = productData;

                        CartModel.of(context).addCartItem(cartProduct);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => CartScreen()));
                      } else {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => LoginScreen()));
                      }
                    },
                    child: Text(
                      daysOfWeek.containsKey(formattedDate)?"Adicionar ao carrinho":"Ainda não abrimos,volte mais tarde! ",
                      /*
                      UserModel.of(context).isloggedIn()
                          ? formattedDate
                          : "Entre para Comprar",
                      style: TextStyle(fontSize: 18.0),
                      */

                    ),
                    color: primaryColor,
                    textColor: Colors.white,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
