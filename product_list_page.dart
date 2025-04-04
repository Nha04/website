import 'package:flutter/material.dart';
import 'product_box.dart';

class ProductListPage extends StatefulWidget {
  final String category;
  final List<Map<String, String>> products;

  const ProductListPage({
    super.key,
    required this.category,
    required this.products,
  });

  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final ValueNotifier<String> searchQueryNotifier = ValueNotifier<String>('');
  List<Map<String, String>> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    filteredProducts = widget.products;

    searchQueryNotifier.addListener(() {
      if (mounted) {
        searchProducts(searchQueryNotifier.value);
      }
    });
  }

  void searchProducts(String query) {
    final results = widget.products.where((product) {
      final nameLower = product['name']!.toLowerCase();
      final queryLower = query.toLowerCase();
      return nameLower.contains(queryLower);
    }).toList();

    setState(() {
      filteredProducts = results;
    });
  }

  @override
  void didUpdateWidget(ProductListPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    filteredProducts = widget.products;
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
            hintText: 'Search ${widget.category}',
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