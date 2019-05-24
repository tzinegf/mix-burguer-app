import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mix_burguer_app/datas/product_data.dart';

class CartProduct {
  String cid;
  String category;
  String pid;
  int qtde;
  String complement;
  ProductData productData;

  CartProduct();

  CartProduct.fromDocument(DocumentSnapshot doc) {
    cid = doc.documentID;
    category = doc.data["category"];
    pid = doc.data["pid"];
    qtde = doc.data["qtde"];
    complement = doc.data["complement"];
  }

  Map<String, dynamic> toMap() {
    return {
      "category": category,
      "pid": pid,
      "qtde": qtde,
      "complement": complement,
      "product": productData.toResumedMap(),
    };
  }
}
