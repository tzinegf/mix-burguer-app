import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mix_burguer_app/models/cart_model.dart';
class ObsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ExpansionTile(
        title: Text("Observação", textAlign: TextAlign.start,
          style: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.grey[700]),),
        leading: Icon(Icons.warning),
        trailing: Icon(Icons.keyboard_arrow_down),

        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(


              maxLines: 4,
              decoration: InputDecoration(

                  border: OutlineInputBorder(),
                  hintText: CartModel.of(context).obs ==""?"Use esse campo para customizar seu pedido.": CartModel.of(context).obs
              ),
              onChanged:(text){
                CartModel.of(context).obs =text;
              } ,
            ),
          )
        ],
      ),

    );
  }
}
