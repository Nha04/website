import 'package:flutter/material.dart';
import 'product_box.dart';
import 'data.dart';

class AllProductsPage extends StatefulWidget {
  const AllProductsPage({super.key});

  @override
  _AllProductsPageState createState() => _AllProductsPageState();
}

class _AllProductsPageState extends State<AllProductsPage> {
  final ValueNotifier<String> searchQueryNotifier = ValueNotifier<String>('');
  List<Map<String, String>> allProducts = [];
  List<Map<String, String>> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    allProducts = [...laptops]..addAll(desktops)..addAll(keyboard)..addAll(mouse)..addAll(headphone);
    filteredProducts = allProducts;

    searchQueryNotifier.addListener(() {
      if (mounted) {
        searchProducts(searchQueryNotifier.value);
      }
    });
  }

  void searchProducts(String query) {
    final results = allProducts.where((product) {
      final nameLower = product['name']!.toLowerCase();
      final queryLower = query.toLowerCase();
      return nameLower.contains(queryLower);
    }).toList();

    setState(() {
      filteredProducts = results;
    });
  }

  @override
  void dispose() {
    searchQueryNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (query) {
            searchQueryNotifier.value = query;
          },
          decoration: InputDecoration(
            hintText: 'Search Products',
            border: InputBorder.none,
            icon: Icon(Icons.search),
          ),
        ),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: filteredProducts.length,
        itemBuilder: (context, index) {
          return ProductBox(product: filteredProducts[index]);
        },
      ),
    );
  }
}