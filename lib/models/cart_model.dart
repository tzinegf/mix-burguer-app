import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mix_burguer_app/datas/cart_product.dart';
import 'package:mix_burguer_app/models/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);

  UserModel user;
  List<CartProduct> products = [];
  String cuponCode;
  int discountPercent = 0;
  bool isLoading = false;
  bool payMode = true;
  double troco = 0;
  double valoPTroco = 0;
  bool stateButton = false;

  CartModel(this.user) {
    if (user.isloggedIn()) _loadCartItens();
  }

  void updatePrices() {
    notifyListeners();
  }

  void addCartItem(CartProduct cartProduct) {
    products.add(cartProduct);
    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .add(cartProduct.toMap())
        .then((doc) {
      cartProduct.cid = doc.documentID;
    });
    notifyListeners();
  }

  void removeCartItem(CartProduct cartProduct) {
    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .document(cartProduct.cid)
        .delete();
    products.remove(cartProduct);
    notifyListeners();
  }

  void decProduct(CartProduct cartProduct) {
    cartProduct.qtde--;
    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .document(cartProduct.cid)
        .updateData(cartProduct.toMap());
    notifyListeners();
  }

  void incProduct(CartProduct cartProduct) {
    cartProduct.qtde++;
    Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .document(cartProduct.cid)
        .updateData(cartProduct.toMap());
    notifyListeners();
  }

  void _loadCartItens() async {
    QuerySnapshot query = await Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .getDocuments();

    products =
        query.documents.map((doc) => CartProduct.fromDocument(doc)).toList();
    notifyListeners();
  }

  void setCupon(String cuponCode, int discount) {
    this.cuponCode = cuponCode;
    this.discountPercent = discount;
  }

  double getProductsPrice() {
    double price = 0.0;
    for (CartProduct c in products) {
      if (c.productData != null) {
        price += c.qtde * c.productData.price;
      }
    }
    return price;
  }

  double getDiscount() {
    return getProductsPrice() * discountPercent / 100;
  }

  double getShipPrice() {
    return 0.0;
  }

  void setTroco(double valor) {
    this.troco = troco;
  }

  double getTroco() {
    return this.troco;
  }

  Future<String> finishOrder() async {
    if (products.length == 0) return null;

    isLoading = true;
    notifyListeners();

    double productsPrices = getProductsPrice();
    double shiPrices = getShipPrice();
    double discount = getDiscount();

    DocumentReference refOrder =
        await Firestore.instance.collection("orders").add({
      "clientId": user.firebaseUser.uid,
      "products": products.map((cartProduct) => cartProduct.toMap()).toList(),
      "shipPrice": shiPrices,
      "productsPrice": productsPrices,
      "discount": discount,
      "totalPrice": productsPrices - discount + shiPrices,
      "status": 1,
      "payMode": payMode,
      "troco": troco,
      "valoPTroco": valoPTroco
    });
    await Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("orders")
        .document(refOrder.documentID)
        .setData({
      "orderId": refOrder.documentID,
    });

    QuerySnapshot query = await Firestore.instance
        .collection("users")
        .document(user.firebaseUser.uid)
        .collection("cart")
        .getDocuments();
    for (DocumentSnapshot doc in query.documents) {
      doc.reference.delete();
    }
    products.clear();
    cuponCode = null;
    discountPercent = 0;
    isLoading = false;
    notifyListeners();
    return refOrder.documentID;
  }
}