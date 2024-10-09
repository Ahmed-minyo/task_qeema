import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_qeema/view_model/product_deatils/product_details_view_model.dart';

class ProductDetailScreen extends StatefulWidget {
  final int id;
  const ProductDetailScreen({super.key, required this.id});

  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  _getData() async {
    return Provider.of<ProductDetailsViewModel>(context, listen: false)
        .initialize(id: widget.id);
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  // @override
  // void dispose() {
  //   Provider.of<ProductDetailsViewModel>(context, listen: false)
  //       .priceSubscription
  //       .cancel();
  //   super.dispose();
  // }
  //
  // @override
  // void didChangeDependencies() {
  //   Provider.of<ProductDetailsViewModel>(context)  .priceSubscription
  //       .cancel();
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ProductDetailsViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: controller.product == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.product?.title ?? '',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text(controller.product?.description ?? ""),
                  const SizedBox(height: 16),
                  controller.realTimePrice == null
                      ? const CircularProgressIndicator() // Loader while fetching price
                      : Text(
                          'Price (from Firebase): \$${controller.realTimePrice!.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                ],
              ),
            ),
    );
  }
}
