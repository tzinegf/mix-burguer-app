import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mix_burguer_app/models/cart_model.dart';

class ShipCard extends StatefulWidget {
  @override
  _ShipCardState createState() => _ShipCardState();
}

class _ShipCardState extends State<ShipCard> {
  bool _isSwitched = true;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ExpansionTile(
        title: Text(
          "Forma de Pagamento",
          textAlign: TextAlign.start,
          style:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[700]),
        ),
        leading: Icon(Icons.monetization_on),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Image(
                      image: AssetImage(_isSwitched? "assets/money.png":"assets/money2.png"),
                      height: 50,
                    ),
                    Text(
                      _isSwitched ? "Dinheiro" : "",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Switch(
                        inactiveThumbColor: Theme.of(context).primaryColor,
                        inactiveTrackColor: Theme.of(context).accentColor,
                        value: _isSwitched,
                        onChanged: (value) {
                          onChangeIsSwitched(value);
                          CartModel.of(context).payMode =_isSwitched;
                        }),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Icon(
                      Icons.credit_card,
                      color: _isSwitched ? Colors.grey[500] : Colors.green,
                      size: 45,
                    ),
                    Text(
                      !_isSwitched ? "Cartão" : "",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ],
                )
              ],
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Container(
              child: _isSwitched
                  ? TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Troco para quanto?"),
                      onFieldSubmitted: (text) {
                        if (_isSwitched) {

                          double total = CartModel.of(context).getProductsPrice()+CartModel.of(context).getShipPrice() - CartModel.of(context).getDiscount();
                          if(double.parse(text)>= total && text.isNotEmpty){
                            CartModel.of(context).troco = double.parse(text)-total;
                            CartModel.of(context).valoPTroco = double.parse(text);
                            CartModel.of(context).stateButton = true;
                          }else{
                            Scaffold.of(context).showSnackBar(
                              SnackBar(content: Text("O valor deve ser maior ou igual ao Total"),
                                backgroundColor: Theme
                                    .of(context)
                                    .primaryColor,
                              ),

                            );
                            CartModel.of(context).stateButton = false;
                          }


                        }
                      },
                    )
                  : Container(),
            ),
          ),
        ],
      ),
    );
  }

  void onChangeIsSwitched(bool value) {
    setState(() {
      _isSwitched = value;
      print(value);
    });
  }
}
