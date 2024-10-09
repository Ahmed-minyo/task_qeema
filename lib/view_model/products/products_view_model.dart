import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import '../../model/product_model.dart';
import 'package:http/http.dart' as http;
import '../../utils/db_helper.dart';

class ProductsViewModel with ChangeNotifier {
  List<ProductModel> products = [];
  final DatabaseHelper _dbHelper = DatabaseHelper();

  Future<void> fetchProducts() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      try {
        final url = Uri.parse('https://fakestoreapi.com/products');
        final response = await http.get(url);
        if (response.statusCode == 200) {
          List<dynamic> jsonResponse = json.decode(response.body);
          products = jsonResponse.map((data) => ProductModel.fromJson(data)).toList();
          notifyListeners();
          await saveToLocalCache(products); // Save data locally
        } else {
          products = await loadFromLocalCache();
        }
      } catch (e) {
        products = await loadFromLocalCache();
      }
    } else {
      products = await loadFromLocalCache();
    }

    notifyListeners();
  }


  Future<void> saveToLocalCache(List<ProductModel> products) async {
    for (var product in products) {
      await _dbHelper.insertProduct(product);
    }
  }

  Future<List<ProductModel>> loadFromLocalCache() async {
    return await _dbHelper.getProducts();
  }

}
