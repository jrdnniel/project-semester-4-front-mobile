import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pharmacy_page.dart';
import 'cart_provider.dart';
import 'cart_page.dart';

class ProductListPage extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> products;

  const ProductListPage({super.key, required this.title, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          title,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal[50],
        elevation: 0,
        actions: [
          Consumer<CartProvider>(
            builder: (context, cart, child) {
              return Stack(
                children: [
                  IconButton(
                    icon: Icon(Icons.shopping_cart, color: Colors.black),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CartPage(),
                        ),
                      );
                    },
                  ),
                  if (cart.items.isNotEmpty)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '${cart.items.length}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.75,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return ProductCard(
              name: product['name'],
              description: product['description'],
              price: product['price'],
              image: product['image'],
              onAddToCart: () {
                Provider.of<CartProvider>(context, listen: false).addToCart(
                  CartItem(
                    name: product['name'],
                    description: product['description'],
                    price: product['price'],
                    image: product['image'],
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${product['name']} ditambahkan ke keranjang')),
                );
              },
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => ProductDetailDialog(
                    name: product['name'],
                    description: product['description'],
                    price: product['price'],
                    image: product['image'],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}