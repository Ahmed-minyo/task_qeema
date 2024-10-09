import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:task_qeema/view_model/products/products_view_model.dart';
import '../view_model/product_deatils/product_details_view_model.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(
    create: (context) => ProductsViewModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => ProductDetailsViewModel(),
  ),
];
