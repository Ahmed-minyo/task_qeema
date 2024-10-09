import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_qeema/utils/providers.dart';
import 'package:task_qeema/view/products/products_view.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: const MaterialApp(
        title: 'Product App',
        home: ProductListScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}



