import 'package:flutter/material.dart';
import 'package:shopping_app/product_list.dart'; 
import 'package:shopping_app/cart_page.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 0;

  final List<Widget> pages = [
    const ProductListPage(),
    const CartPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  body: IndexedStack(
    index: currentPage,
    children: pages,
  ),


  bottomNavigationBar: Theme(
    data: Theme.of(context).copyWith(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      splashFactory: NoSplash.splashFactory,
    ),
    child: BottomNavigationBar(
      iconSize: 30,
      currentIndex: currentPage,
      onTap: (index) {
        setState(() {
          HapticFeedback.lightImpact();
          currentPage = index;
        });
      },
      showSelectedLabels: false,
      showUnselectedLabels: false,
      unselectedFontSize: 0,
      selectedFontSize: 0,
      selectedItemColor: const Color.fromARGB(255, 255, 222, 74),
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ''),
      ],
    ),
  ),
);

  }
}
