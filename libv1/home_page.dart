import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'product_list_page.dart';
import 'all_products_page.dart';
import 'data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  late final List<Map<String, dynamic>> _categories;
  late final List<Widget> _pages;
  late final List<String> _sliderImages;

  @override
  void initState() {
    super.initState();
    _categories = [
      {'name': 'Home', 'icon': Icons.home},
      {'name': 'Laptops', 'icon': Icons.laptop},
      {'name': 'Desktops', 'icon': Icons.desktop_windows},
      {'name': 'Keyboard', 'icon': Icons.keyboard},
      {'name': 'Mouse', 'icon': Icons.mouse},
      {'name': 'Headphone', 'icon': Icons.headphones},
    ];
    _pages = [
      AllProductsPage(),
      ProductListPage(category: 'Laptops', products: laptops),
      ProductListPage(category: 'Desktops', products: desktops),
      ProductListPage(category: 'Keyboard', products: keyboard),
      ProductListPage(category: 'Mouse', products: mouse),
      ProductListPage(category: 'Headphone', products: headphone),
    ];
    _sliderImages = [
      'assets/slider/slider_1.jpg',
      'assets/slider/slider_2.jpg',
      'assets/slider/slider_3.jpg',
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Group 1 Computer Shop'),
      ),
      body: _selectedIndex == 0
          ? Column(
              children: [
                TextField(
                  onChanged: (query) {
                    // Implement the search functionality here
                  },
                  decoration: InputDecoration(
                    hintText: 'Search Products',
                    border: InputBorder.none,
                    icon: Icon(Icons.search),
                  ),
                ),
                Container(
                  height: 200,
                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      return Image.asset(
                        _sliderImages[index],
                        fit: BoxFit.cover,
                      );
                    },
                    itemCount: _sliderImages.length,
                    pagination: SwiperPagination(),
                    control: SwiperControl(),
                  ),
                ),
                Expanded(child: _pages[_selectedIndex]),
              ],
            )
          : _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: _categories.map((category) {
          return BottomNavigationBarItem(
            icon: Icon(category['icon']),
            label: category['name'],
          );
        }).toList(),
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red, // Highlight selected item with cyan color
        unselectedItemColor: Colors.red, // Set unselected item color to cyan
        onTap: _onItemTapped,
      ),
    );
  }
}