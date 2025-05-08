import 'package:flutter/material.dart';
import 'cart_page.dart';

class ShopScreen extends StatefulWidget {
  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  List<Map<String, dynamic>> tshirts = List.generate(10, (index) {
    return {
      'name': 'T-Shirt ${index + 1}',
      'price': 19.99 + index,
      'image': 'assets/images/img${index + 1}.jpg',
      'selected': false
    };
  });

  double get total => tshirts
      .where((item) => item['selected'])
      .fold(0, (sum, item) => sum + item['price']);

  void _onSearchTapped() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Search"),
        content: Text("Search feature coming soon!"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("OK"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.red),
              child: Center(
                child: Text("Menu",
                    style: TextStyle(color: Colors.white, fontSize: 24)),
              ),
            ),
            _drawerItem("Home"),
            _drawerItem("Create Account"),
            _drawerItem("Achievements"),
            _drawerItem("Order History / Cart"),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("T-Shirt Shop", style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: _onSearchTapped,
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: tshirts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final item = tshirts[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      item['selected'] = !item['selected'];
                    });
                  },
                  child: Card(
                    elevation: 6,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(12)),
                            child: Image.asset(item['image'],
                                fit: BoxFit.cover, width: double.infinity),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            item['name'],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87),
                          ),
                        ),
                        Text("\$${item['price'].toStringAsFixed(2)}",
                            style: TextStyle(color: Colors.black87)),
                        const SizedBox(height: 4),
                        Icon(
                          item['selected']
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                          color: item['selected'] ? Colors.green : Colors.grey,
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Total:',
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                    Text('\$${total.toStringAsFixed(2)}',
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    final selectedItems =
                    tshirts.where((item) => item['selected']).toList();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CartPage(selectedItems: selectedItems),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    padding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                  child: Text("Checkout",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _drawerItem(String title) {
    return ListTile(
      title: Text(title, style: TextStyle(color: Colors.white)),
      leading: Icon(Icons.arrow_right, color: Colors.white),
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$title tapped')),
        );
      },
    );
  }
}
