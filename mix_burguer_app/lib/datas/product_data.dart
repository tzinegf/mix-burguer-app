import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {
  String id;
  String title;
  String description;
  String category;

  double price;

  List images;
  List complements;

  ProductData.fromDocument(DocumentSnapshot snapshot) {
    id = snapshot.documentID;
    title = snapshot.data["title"];
    price = snapshot.data["price"];
    description = snapshot.data["description"];
    images = snapshot.data["image"];
  }

  Map<String, dynamic> toResumedMap() {
    return {"title": title, "price": price};
  }
}
