import 'package:flutter/material.dart';
import 'menu_utama/main_page.dart'; // Import halaman main_page.dart untuk navigasi kembali

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Tombol kembali
            Positioned(
              top: 10,
              left: 10,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black87),
                onPressed: () {
                  // Kembali ke MenuPage (indeks 0) dengan mengubah indeks di MainPage
                  MainPage.globalKey.currentState?.setIndex(0);
                },
              ),
            ),
            // Pesan "No History"
            Center(
              child: Text(
                'No History',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}