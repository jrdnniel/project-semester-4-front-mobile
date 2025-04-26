import 'package:flutter/material.dart';

class CartItem {
  final String name;
  final String description;
  final double price;
  final String image;
  int quantity;
  String orderStatus;

  CartItem({
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    this.quantity = 1,
    this.orderStatus = 'Anak - anak',
  });
}

class Transaction {
  final String name;
  final String description;
  final double price;
  final String image;
  final int quantity;
  final String orderStatus;
  final DateTime date;

  Transaction({
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.quantity,
    required this.orderStatus,
    required this.date,
  });
}

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];
  final List<Transaction> _transactions = []; // List untuk riwayat transaksi

  List<CartItem> get items => _items;
  List<Transaction> get transactions => _transactions; // Getter untuk riwayat

  void addToCart(CartItem item) {
    int index = _items.indexWhere((cartItem) => cartItem.name == item.name);
    if (index != -1) {
      _items[index].quantity += 1;
    } else {
      _items.add(item);
    }
    notifyListeners();
  }

  void removeFromCart(String name) {
    _items.removeWhere((item) => item.name == name);
    notifyListeners();
  }

  void clearCart() {
    // Simpan item ke riwayat sebelum menghapus
    for (var item in _items) {
      _transactions.add(Transaction(
        name: item.name,
        description: item.description,
        price: item.price,
        image: item.image,
        quantity: item.quantity,
        orderStatus: item.orderStatus,
        date: DateTime.now(),
      ));
    }
    _items.clear();
    notifyListeners();
  }

  double get totalPrice {
    return _items.fold(0, (total, item) => total + (item.price * item.quantity));
  }

  void updateOrderStatus(String name, String newStatus) {
    int index = _items.indexWhere((item) => item.name == name);
    if (index != -1) {
      _items[index].orderStatus = newStatus;
      notifyListeners();
    }
  }
}