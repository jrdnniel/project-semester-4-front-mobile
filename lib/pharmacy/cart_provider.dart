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
  bool isRead; // Perbaiki properti isRead

  Transaction({
    required this.name,
    required this.description,
    required this.price,
    required this.image,
    required this.quantity,
    required this.orderStatus,
    required this.date,
    this.isRead = false, // Default: belum dibaca
  });
}

class CartProvider with ChangeNotifier {
  final List<CartItem> _items = [];
  List<Transaction> _transactions = []; // List untuk riwayat transaksi
  final List<Transaction> _originalTransactions = []; // Backup untuk filter

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
      final transaction = Transaction(
        name: item.name,
        description: item.description,
        price: item.price,
        image: item.image,
        quantity: item.quantity,
        orderStatus: item.orderStatus,
        date: DateTime.now(),
        isRead: false,
      );
      _transactions.add(transaction);
      _originalTransactions.add(transaction); // Simpan ke backup
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

  // Tandai semua transaksi sebagai dibaca
  void markAllAsRead() {
    for (var transaction in _transactions) {
      transaction.isRead = true;
    }
    notifyListeners();
  }

  // Urutkan transaksi berdasarkan tanggal (terbaru ke terlama)
  void sortByDate() {
    _transactions.sort((a, b) => b.date.compareTo(a.date));
    notifyListeners();
  }

  // Hapus semua transaksi
  void clearTransactions() {
    _transactions.clear();
    _originalTransactions.clear(); // Kosongkan juga backup
    notifyListeners();
  }

  // Filter transaksi berdasarkan status
  void filterByStatus(String? status) {
    if (status == null) {
      // Kembalikan semua transaksi dari backup
      _transactions = List.from(_originalTransactions);
    } else {
      // Filter berdasarkan status
      _transactions = _originalTransactions
          .where((transaction) => transaction.orderStatus == status)
          .toList();
    }
    notifyListeners();
  }
}