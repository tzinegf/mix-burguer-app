import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mix_burguer_app/models/cart_model.dart';

class PaymentsCard extends StatefulWidget {
  @override
  _PaymentsCardState createState() => _PaymentsCardState();
}

class _PaymentsCardState extends State<PaymentsCard> {
  bool _isSwitched = true;
  double sizeIcon = 45;

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
                    GestureDetector(
                      onTap: () {
                        _isSwitched = true;
                        CartModel.of(context).payMode = _isSwitched;
                        CartModel.of(context).stateButton = false;
                      },
                      child: new Icon(
                        const IconData(0xe900, fontFamily: 'icomoon'),
                        size: 45,
                        color: !_isSwitched ? Colors.grey[500] : Colors.green,
                      ),
                    ),
                    Text(
                      _isSwitched ? "Dinheiro" : "",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ],
                ),
                Column(),
                Column(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        _isSwitched = false;
                        CartModel.of(context).payMode = _isSwitched;
                        CartModel.of(context).stateButton = true;
                      },
                      child: Icon(
                        Icons.credit_card,
                        color: _isSwitched ? Colors.grey[500] : Colors.green,
                        size: 45,
                      ),
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
                          double total =
                              CartModel.of(context).getProductsPrice() +
                                  CartModel.of(context).getShipPrice() -
                                  CartModel.of(context).getDiscount();
                          if (double.parse(text) >= total && text.isNotEmpty) {
                            CartModel.of(context).troco =
                                double.parse(text) - total;
                            CartModel.of(context).valoPTroco =
                                double.parse(text);
                            CartModel.of(context).stateButton = true;
                          } else {
                            Scaffold.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    "O valor deve ser maior ou igual ao Total"),
                                backgroundColor: Theme.of(context).primaryColor,
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
