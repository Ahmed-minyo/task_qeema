import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_model/products/products_view_model.dart';
import '../product_details/product_details_view.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  _getData() async {
    return Provider.of<ProductsViewModel>(context, listen: false)
        .fetchProducts();
  }

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductsViewModel>(context).products;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: products.isEmpty
          ? const Center(child: Text('No products available. Please check your internet connection.'))
          : ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(products[index].title ?? ""),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ProductDetailScreen(id: products[index].id ?? 0),
                ),
              );
            },
          );
        },
      ),
    );
  }}
