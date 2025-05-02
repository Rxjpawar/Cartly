import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_app/global_variables.dart';
import 'package:flutter/services.dart';
import 'package:shopping_app/product_card.dart';
import 'package:shopping_app/product_details.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final textEditingController = TextEditingController();
  final List<String> item = [
    'All',
    'OnePlus',
    'Google',
    'Apple',
    'Samsung',
    'Xiaomi',
  ];
  late String selectedItem;

  @override
  void initState() {
    super.initState();
    selectedItem = item[0]; 
  }

  @override
  Widget build(BuildContext context) {
  // filter button 
    List filteredProducts = selectedItem == 'All'
        ? products
        : products.where((product) {
            return product['company'] == selectedItem;
          }).toList();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 244, 244, 244),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 244, 244, 244),
        toolbarHeight: 90,
        scrolledUnderElevation: 0,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Cartly',
              style: GoogleFonts.lato(
                fontSize: 30,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 40,
              child: TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: GoogleFonts.lato(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    fontSize: 16,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 223, 223, 223),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  prefixIcon: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search,
                      color: Color.fromARGB(255, 0, 0, 0),
                      size: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Category filter idhr hai
          SizedBox(
            height: 70,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: item.length,
              itemBuilder: (context, index) {
                final company = item[index];
                return Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        HapticFeedback.lightImpact();
                        selectedItem = company;
                      });
                    },
                    child: Chip(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      side: const BorderSide(
                        color: Color.fromARGB(255, 240, 240, 240),
                      ),
                      backgroundColor: selectedItem == company
                          ? const Color.fromARGB(255, 255, 222, 74)
                          : const Color.fromARGB(255, 255, 255, 255),
                      label: Text(
                        company,
                        style: GoogleFonts.lato(
                          fontSize: 14,
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      padding: const EdgeInsets.all(8.0),
                    ),
                  ),
                );
              },
            ),
          ),
          
          // Product ki list
          Expanded(
            child: ListView.builder(
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            ProductDetailsPage(product: product),
                        transitionsBuilder: (
                          context,
                          animation,
                          secondaryAnimation,
                          child,
                        ) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.ease;
                          final tween = Tween(
                            begin: begin,
                            end: end,
                          ).chain(CurveTween(curve: curve));
                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: ProductCard(
                    title: product['title'] as String,
                    price: product['price'] as String,
                    image: product['imageUrl'] as String,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
