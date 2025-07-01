import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart'; 
import 'pharmacy/cart_provider.dart';
import 'menu_utama/main_page.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final transactions = cartProvider.transactions;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            MainPage.globalKey.currentState?.setIndex(0);
          },
        ),
        title: Text(
          'Riwayat Pembelian',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.teal[50],
        elevation: 0,
        actions: [
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert, color: Colors.black),
            onSelected: (value) {
              switch (value) {
                case 'clear':
                  // Clear semua transaksi
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Hapus Riwayat'),
                      content: Text('Apakah Anda yakin ingin menghapus semua riwayat pembelian?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Batal'),
                        ),
                        TextButton(
                          onPressed: () {
                            cartProvider.clearTransactions();
                            Navigator.pop(context);
                          },
                          child: Text('Hapus'),
                        ),
                      ],
                    ),
                  );
                  break;
                case 'mark_read':
                  // Tandai semua sebagai dibaca
                  cartProvider.markAllAsRead();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Semua riwayat ditandai sebagai dibaca')),
                  );
                  break;
                case 'sort_date':
                  // Urutkan berdasarkan tanggal
                  cartProvider.sortByDate();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Riwayat diurutkan berdasarkan tanggal')),
                  );
                  break;
                case 'filter_status':
                  // Filter berdasarkan status
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Filter Status'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            title: Text('Semua Status'),
                            onTap: () {
                              cartProvider.filterByStatus(null);
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            title: Text('Selesai'),
                            onTap: () {
                              cartProvider.filterByStatus('Selesai');
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            title: Text('Dalam Proses'),
                            onTap: () {
                              cartProvider.filterByStatus('Dalam Proses');
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'clear',
                child: Text('Clear Riwayat'),
              ),
              PopupMenuItem(
                value: 'mark_read',
                child: Text('Tandai Semua Dibaca'),
              ),
              PopupMenuItem(
                value: 'sort_date',
                child: Text('Urutkan berdasarkan Tanggal'),
              ),
              PopupMenuItem(
                value: 'filter_status',
                child: Text('Filter berdasarkan Status'),
              ),
            ],
          ),
        ],
      ),
      body: transactions.isEmpty
          ? Center(
              child: Text(
                'Belum ada riwayat pembelian.',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[600],
                ),
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return Card(
                  elevation: 2,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Image.asset(
                          transaction.image,
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Icon(Icons.broken_image),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                transaction.name,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: transaction.isRead ? Colors.black87 : Colors.blue,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                transaction.description,
                                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Jumlah: ${transaction.quantity}',
                                style: TextStyle(fontSize: 14, color: Colors.black87),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Total: Rp. ${(transaction.price * transaction.quantity).toStringAsFixed(0)}',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Status: ${transaction.orderStatus}',
                                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Tanggal: ${DateFormat('dd MMMM yyyy, HH:mm').format(transaction.date)}',
                                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}