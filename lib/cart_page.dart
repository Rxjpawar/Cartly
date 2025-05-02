import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/cart_provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<Map<String, dynamic>> cart = [];

  @override

  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context).cart;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        title: const Text('Cart'),
        centerTitle: true,
      ),

      body: cart.isEmpty
          ? const Center(child: Text("Your cart is empty"))
          : ListView.separated(
              itemCount: cart.length,
              separatorBuilder: (context, index) => const Divider(
                thickness: 1,
                indent: 20,
                endIndent: 20,
              ),
              itemBuilder: (context, index) {
                final cartItem = cart[index];

                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8),
                  leading: CircleAvatar(
                    backgroundImage:
                        AssetImage(cartItem['imageUrl'] as String),
                    radius: 30,
                  ),
                  title: Text(
                    cartItem['title'] as String,
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cartItem['Variant']?.toString() ?? 'No variant',
                        style: GoogleFonts.lato(fontSize: 14),
                      ),
                      Text(
                        cartItem['price'] as String,
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    color: Colors.red,
                    onPressed: () {
                      setState(() {
                        cart.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
    );
  }
}
