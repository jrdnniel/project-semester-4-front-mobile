import 'package:flutter/material.dart';
import '../menu_utama/main_page.dart'; // Import halaman main_page.dart untuk navigasi kembali
import 'package:doctor/fitur_chat/chat_detail.dart'; // Import halaman chat_detail.dart

class ChatPage extends StatelessWidget {
  // Data dummy untuk dokter yang aktif
  final List<Map<String, String>> activeDoctors = [
    {'image': 'assets/gambar8.png'},
    {'image': 'assets/gambar9.png'},
    {'image': 'assets/gambar10.png'},
    {'image': 'assets/gambar11.png'},
    {'image': 'assets/gambar12.png'},
  ];

  // Data dummy untuk daftar pesan
  final List<Map<String, dynamic>> messages = [
    {
      'image': 'assets/gambar8.png',
      'name': 'Dr.Upul',
      'message': 'Worem consectetur adipiscing elit.',
      'time': '12:50',
      'unreadCount': 2,
    },
    {
      'image': 'assets/gambar9.png',
      'name': 'Dr.Silva',
      'message': 'Worem consectetur adipiscing elit.',
      'time': '12:50',
      'unreadCount': 0,
    },
    {
      'image': 'assets/gambar10.png',
      'name': 'Dr.Pawani',
      'message': 'Worem consectetur adipiscing elit.',
      'time': '12:50',
      'unreadCount': 0,
    },
    {
      'image': 'assets/gambar11.png',
      'name': 'Dr.Rayan',
      'message': 'Worem consectetur adipiscing elit.',
      'time': '12:50',
      'unreadCount': 0,
    },
  ];

  ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.black87),
                      onPressed: () {
                        // Kembali ke MenuPage (indeks 0) dengan mengubah indeks di MainPage
                        MainPage.globalKey.currentState?.setIndex(0);
                      },
                    ),
                    Text(
                      'Chat',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(width: 40), // Spacer untuk menjaga tata letak
                  ],
                ),
                SizedBox(height: 20),

                // Search Bar
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Search a Doctor',
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                    suffixIcon: Icon(Icons.mic, color: Colors.grey[400]),
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Active Now
                Text(
                  'Active Now',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 10),
                SizedBox(
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: activeDoctors.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: AssetImage(activeDoctors[index]['image']!),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 2),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 20),

                // Messages
                Text(
                  'Messages',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        // Navigasi ke ChatDetailPage dengan nama dan gambar dokter
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder: (context, animation, secondaryAnimation) => ChatDetailPage(
                              doctorName: messages[index]['name'],
                              doctorImage: messages[index]['image'],
                            ),
                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                              const begin = Offset(-1.0, 0.0); // Mulai dari kiri
                              const end = Offset.zero; // Berakhir di posisi normal
                              const curve = Curves.easeInOut;

                              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                              var offsetAnimation = animation.drive(tween);

                              return SlideTransition(
                                position: offsetAnimation,
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Row(
                          children: [
                            // Foto dokter
                            CircleAvatar(
                              radius: 25,
                              backgroundImage: AssetImage(messages[index]['image']),
                            ),
                            SizedBox(width: 15),
                            // Nama dan pesan
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        messages[index]['name'],
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      Text(
                                        messages[index]['time'],
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    messages[index]['message'],
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Indikator pesan belum dibaca
                            if (messages[index]['unreadCount'] > 0)
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                padding: EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: Colors.teal,
                                  shape: BoxShape.circle,
                                ),
                                child: Text(
                                  messages[index]['unreadCount'].toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}