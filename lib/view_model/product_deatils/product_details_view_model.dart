import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import '../../model/product_model.dart';

class ProductDetailsViewModel with ChangeNotifier {
  ProductModel? product;
  double? realTimePrice;
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();
  late StreamSubscription<DatabaseEvent> priceSubscription;

  initialize({required int id}) async {
    Future.wait([fetchProductDetails(id: id), fetchRealTimePrice(id: id)]);
  }

  Future<void> fetchProductDetails({required int id}) async {
    final url = Uri.parse('https://fakestoreapi.com/products/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      product = ProductModel.fromJson(json.decode(response.body));
      notifyListeners();
      if (product != null) {
        updatePriceInFirebase(product?.price ?? 0, id: id);
      }
    }
  }

  Future<void> updatePriceInFirebase(double price, {required int id}) async {
    _dbRef.child('$id/price').set(price).then((_) {
      log('Price updated in Firebase!');
    }).catchError((error) {
      log('Failed to update price: $error');
    });
  }

  Future<void> fetchRealTimePrice({required int id}) async {
    priceSubscription = _dbRef.child('$id/price').onValue.listen((event) {
      log('Real-time price fetched: ${event.snapshot.value}');
      realTimePrice = double.tryParse(event.snapshot.value.toString());
      notifyListeners();
    });
  }
}
