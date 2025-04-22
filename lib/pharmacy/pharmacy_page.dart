import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'product_list_page.dart';
import 'cart_provider.dart';
import 'cart_page.dart'; // Import halaman keranjang

class PharmacyPage extends StatelessWidget {
  final List<Map<String, dynamic>> popularProducts = [
    {'name': 'Panadol', 'description': '1 pcs', 'price': 8000, 'image': 'assets/gambar24.png'},
    {'name': 'Bodrex Herbal', 'description': '100ml', 'price': 7000, 'image': 'assets/gambar22.png'},
    {'name': 'Konidin', 'description': '3 pcs', 'price': 5000, 'image': 'assets/gambar23.png'},
  ];

  final List<Map<String, dynamic>> saleProducts = [
    {'name': 'OBH Combi', 'description': '75ml', 'price': 9000, 'image': 'assets/gambar21.png'},
    {'name': 'Betadine', 'description': '50ml', 'price': 6000, 'image': 'assets/gambar22.png'},
    {'name': 'Bodrexin', 'description': '75ml', 'price': 7000, 'image': 'assets/gambar23.png'},
  ];

  PharmacyPage({super.key});

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
          'Pharmacy',
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
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: 'Search drugs, category...',
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            margin: EdgeInsets.symmetric(horizontal: 0),
            height: 120,
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    'Order quickly with Prescription',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Image.asset(
                    'assets/gambar20.png',
                    width: 100,
                    height: 100,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Popular Product',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductListPage(
                        title: 'Popular Product',
                        products: popularProducts,
                      ),
                    ),
                  );
                },
                child: Text(
                  'See all',
                  style: TextStyle(color: Colors.teal),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          SizedBox(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: popularProducts.length,
              itemBuilder: (context, index) {
                final product = popularProducts[index];
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
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Product on SALE',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductListPage(
                        title: 'Product on SALE',
                        products: saleProducts,
                      ),
                    ),
                  );
                },
                child: Text(
                  'See all',
                  style: TextStyle(color: Colors.teal),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          SizedBox(
            height: 180,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: saleProducts.length,
              itemBuilder: (context, index) {
                final product = saleProducts[index];
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
        ],
      ),
    );
  }
}

// // Widget untuk kartu produk
class ProductCard extends StatelessWidget {
  final String name;
  final String description;
  final double price;
  final String image;
  final VoidCallback onAddToCart;
  final VoidCallback onTap;

  const ProductCard({
    super.key,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.onAddToCart,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 130, // 
        margin: EdgeInsets.only(right: 16),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                  child: Image.asset(
                    image,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Rp.${price.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.add_circle, color: Colors.teal),
                          onPressed: onAddToCart,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget untuk dialog detail obat
class ProductDetailDialog extends StatelessWidget {
  final String name;
  final String description;
  final double price;
  final String image;

  const ProductDetailDialog({
    super.key,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                image,
                width: 120,
                height: 120,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image, size: 120),
              ),
            ),
            SizedBox(height: 15),
            Text(
              name,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 5),
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Rp.${price}',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                print('Buy Now clicked for $name');
                Provider.of<CartProvider>(context, listen: false).addToCart(
                  CartItem(
                    name: name,
                    description: description,
                    price: price,
                    image: image,
                  ),
                );
                print('Product added to cart');
                Navigator.pop(context);
                print('Dialog closed');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartPage(),
                  ),
                );
                print('Navigating to CartPage');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text('Buy Now'),
            ),
          ],
        ),
      ),
    );
  }
}