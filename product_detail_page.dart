import 'package:flutter/material.dart';

class ProductDetailPage extends StatelessWidget {
  final Map<String, String> product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product['name']!),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              product['image']!,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
            SizedBox(height: 10),
            Text(
              product['name']!,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            Text(
              'Price: ${product['price']}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),

            Text(
              'Description: ${product['description']}',
              style: TextStyle(fontSize: 16),
            ),
            
            // Add more product details here
          ],
        ),
      ),
    );
  }
}
