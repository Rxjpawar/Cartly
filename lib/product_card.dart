import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.title,
    required this.price,
    required this.image,
    
  });

  final String title;
  final String price;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(255, 255, 255, 255),
      ),
      margin: const EdgeInsets.all(20),

      child: Column(
        children: [
          SizedBox(height: 20),
          Image(image: AssetImage(image), height: 300),
           SizedBox(height: 5),

          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(height: 2),
          Text(
            price,
            style: TextStyle(
              fontSize: 16,
              color: const Color.fromARGB(255, 114, 114, 114),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
