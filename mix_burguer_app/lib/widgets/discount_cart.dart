import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mix_burguer_app/models/cart_model.dart';
class DiscountCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ExpansionTile(
        title: Text("Cupom de Desconto", textAlign: TextAlign.start,
          style: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.grey[700]),),
        leading: Icon(Icons.card_giftcard),
        trailing: Icon(Icons.add),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(

                  border: OutlineInputBorder(),
                  hintText: "Informe seu cupon"
              ),
              initialValue: CartModel
                  .of(context)
                  .cuponCode ?? "",
              onFieldSubmitted: (text) {
                if(text.isNotEmpty){
                  Firestore.instance.collection("cupons").document(text)
                      .get()
                      .then((docSnap) {
                    if (docSnap.data != null) {
                      CartModel.of(context).setCupon(
                          text, docSnap.data["percent"]);
                      Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text(
                            "desconto de ${docSnap.data["percent"]}% aplicado!"),
                          backgroundColor: Colors.green,
                        ),


                      );
                    } else {
                      CartModel.of(context).setCupon(null, 0);

                      Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text("Cupon não existe"),
                          backgroundColor: Theme
                              .of(context)
                              .primaryColor,
                        ),

                      );
                    }
                  });
                }
              },
            ),
          )
        ],
      ),

    );
  }
}
