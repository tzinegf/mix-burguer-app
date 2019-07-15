import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mix_burguer_app/models/user_model.dart';
import 'package:mix_burguer_app/screens/login_screen.dart';
import 'package:mix_burguer_app/tiles/history_tile.dart';
import 'package:mix_burguer_app/tiles/order_tile.dart';

class HistoryTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    if (UserModel.of(context).isloggedIn()) {
      String uid = UserModel.of(context).firebaseUser.uid;

      return FutureBuilder<QuerySnapshot>(
        future: Firestore.instance
            .collection("users")
            .document(uid)
            .collection("historicOrders")
            .getDocuments(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Text("Não há nada por aqui!",style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
            );

          } else {
            return ListView(
                children: snapshot.data.documents
                    .map((doc) => HistoryTile(doc.documentID))
                    .toList());
          }
        },
      );
    } else {
      return Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.line_style,
              size: 80.0,
              color: Theme.of(context).primaryColor,
            ),
            SizedBox(
              height: 16.0,
            ),
            Text(
              "Faça o login para ver seu hitórico de pedidos!",
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
              color: Theme.of(context).primaryColor,
            )
          ],
        ),
      );
    }
  }
}
