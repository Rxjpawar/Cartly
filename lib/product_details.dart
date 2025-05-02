import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'cart_provider.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({super.key, required this.product});

  final Map<String, dynamic> product;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int? selectedVariantIndex;

  void onTap() {
    if (selectedVariantIndex != null) {
      Provider.of<CartProvider>(context, listen: false).addToCart({
        'id': widget.product['id'],
        'title': widget.product['title'],
        'price': widget.product['price'],
        'imageUrl': widget.product['imageUrl'],
        'company': widget.product['company'],
        'Variant': (widget.product['Variant'] as List<String>)[selectedVariantIndex!],
      });
      HapticFeedback.lightImpact();
       ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pr added successfully')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a variant')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final variants = widget.product['Variant'] as List<String>;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Details'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text(
              widget.product['title'] as String,
              style: GoogleFonts.lato(
                fontSize: 30,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  widget.product['imageUrl'] as String,
                  height: MediaQuery.of(context).size.height * 0.4,
                  semanticLabel: widget.product['title'],
                ),
              ),
            ),
            const Spacer(flex: 2),
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: const Color.fromARGB(255, 241, 241, 241),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Text(
                    '${widget.product['price']}',
                    style: GoogleFonts.lato(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: variants.length,
                      itemBuilder: (context, index) {
                        final variant = variants[index];
                        return Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                HapticFeedback.lightImpact();
                                selectedVariantIndex = index;
                              });
                            },
                            child: Chip(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              side: const BorderSide(
                                color: Color.fromARGB(255, 240, 240, 240),
                              ),
                              label: Text(variant),
                              backgroundColor: selectedVariantIndex == index
                                  ? const Color.fromARGB(255, 255, 222, 74)
                                  : Colors.white,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                      onPressed: onTap,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 255, 222, 74),
                        minimumSize: const Size(double.infinity, 50),
                        elevation: 0,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.shopping_cart,
                            color: Colors.black,
                            size: 20,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "Add To Cart",
                            style: GoogleFonts.lato(
                              color: Colors.black,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
