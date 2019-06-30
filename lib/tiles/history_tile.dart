import 'dart:collection';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class HistoryTile extends StatefulWidget {

  final String orderId;

  HistoryTile(this.orderId);

  @override
  _HistoryTileState createState() => _HistoryTileState();
}

class _HistoryTileState extends State<HistoryTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: StreamBuilder<DocumentSnapshot>(
            stream: Firestore.instance
                .collection("historicOrders")
                .document(widget.orderId)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Código do pedido: ${snapshot.data.documentID}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 4.0,
                    ),
                    Text(_buildProductsTexts(snapshot.data)),
                    SizedBox(
                      height: 4.0,
                    ),
                    Text(
                      "Data do pedido:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 6.0,
                    ),
                    Text(
                      dataOrder(snapshot.data),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),


                  ],
                );
              }
            }),
      ),
    );
  }

  String _buildProductsTexts(DocumentSnapshot snapshot) {
    String text = "Descrição:\n";
    for (LinkedHashMap p in snapshot.data["products"]) {
      text +=
      "${p["qtde"]} x ${p["product"]["title"]} (R\$ ${p["product"]["price"].toStringAsFixed(2)})\n";
    }
    text += "Total: R\$ ${snapshot.data["totalPrice"].toStringAsFixed(2)}";
    return text;
  }
  String dataOrder(DocumentSnapshot snapshot){
    Timestamp orderDate = snapshot.data["dataOrder"];
    DateTime dateTeste = orderDate.toDate();
    print (dateTeste);
    String formattedDate = DateFormat('dd-MM-yyyy – kk:mm').format(dateTeste);
    return formattedDate;
  }

}
