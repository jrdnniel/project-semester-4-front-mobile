import 'package:flutter/material.dart';
import 'menu_utama/main_page.dart'; // Import halaman main_page.dart untuk navigasi kembali

class NotifPage extends StatelessWidget {
  const NotifPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tombol kembali
                IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black87),
                  onPressed: () {
                    // Kembali ke MenuPage (indeks 0) dengan mengubah indeks di MainPage
                    if (MainPage.globalKey.currentState != null) {
                      MainPage.globalKey.currentState!.setIndex(0);
                      Navigator.pop(context); // Kembali ke halaman sebelumnya (MainPage)
                    } else {
                      // Jika globalKey tidak tersedia, gunakan Navigator.pop saja
                      Navigator.pop(context);
                    }
                  },
                ),
                SizedBox(height: 10),
                // Daftar notifikasi
                Text(
                  'Hari ini, 19 January 2024',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 10),
                NotificationCard(
                  icon: Icons.access_time,
                  iconColor: Colors.blue,
                  title: 'Alarm Pemeriksaan',
                  description: 'Waktu perjanjian kamu dengan dokter kurang 15 menit lagi',
                ),
                NotificationCard(
                  icon: Icons.check_circle,
                  iconColor: Colors.green,
                  title: 'Pemeriksaan Selesai',
                  description: 'Pemeriksaanmu sudah selesai semoga lekas sembuh',
                ),
                SizedBox(height: 20),
                Text(
                  '5 January 2024',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 10),
                NotificationCard(
                  icon: Icons.warning,
                  iconColor: Colors.orange,
                  title: 'Update Aplikasi',
                  description: 'Update aplikasimu untuk lebih baik lagi',
                ),
                SizedBox(height: 20),
                Text(
                  '1 January 2024',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 10),
                NotificationCard(
                  icon: Icons.check_circle,
                  iconColor: Colors.green,
                  title: 'Pemeriksaan Selesai',
                  description: 'Pemeriksaanmu sudah selesai semoga lekas sembuh',
                ),
                NotificationCard(
                  icon: Icons.access_time,
                  iconColor: Colors.blue,
                  title: 'Alarm Pemeriksaan',
                  description: 'Waktu perjanjian kamu dengan dokter kurang 15 menit lagi',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Widget untuk kartu notifikasi (tetap sama)
class NotificationCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String description;

  const NotificationCard({super.key, 
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 30,
            ),
            SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}