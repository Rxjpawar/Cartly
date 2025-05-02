import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/home_page.dart';
import 'package:shopping_app/cart_provider.dart';
//import 'package:shopping_app/home_page.dart';

//  import 'package:shopping_app/product_details.dart';
//  import 'package:shopping_app/global_variables.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartProvider(),
      


      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cartly',
        theme: ThemeData(primarySwatch: Colors.yellow),

        home: HomePage(),
      ),
    );
  }
}
