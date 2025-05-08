import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  final List<Map<String, dynamic>> selectedItems;

  const CartPage({Key? key, required this.selectedItems}) : super(key: key);

  double get total => selectedItems
      .fold(0.0, (sum, item) => sum + (item['price']));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Cart"),
        backgroundColor: Colors.black,
      ),
      body: selectedItems.isEmpty
          ? Center(child: Text("Your cart is empty"))
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: selectedItems.length,
              itemBuilder: (context, index) {
                final item = selectedItems[index];
                return ListTile(
                  leading: Image.asset(item['image'], width: 50, fit: BoxFit.cover),
                  title: Text(item['name']),
                  subtitle: Text("\$${item['price'].toStringAsFixed(2)}"),
                  trailing: Icon(Icons.check_circle, color: Colors.green),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total:",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text("\$${total.toStringAsFixed(2)}",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(
                        vertical: 12, horizontal: 50),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text("Order Confirmed"),
                        content: Text("Thank you for your purchase!"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text("Close"),
                          )
                        ],
                      ),
                    );
                  },
                  child: Text("Checkout", style: TextStyle(fontSize: 16)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
