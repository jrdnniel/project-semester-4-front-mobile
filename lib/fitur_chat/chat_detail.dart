import 'package:flutter/material.dart';
import 'package:doctor/fitur_chat/call.dart'; // Import halaman call.dart

class ChatDetailPage extends StatelessWidget {
  final String? doctorName;
  final String? doctorImage;

  ChatDetailPage({super.key, this.doctorName, this.doctorImage});

  // Data dummy untuk pesan
  final List<Map<String, dynamic>> messages = [
    {
      'text': 'Hello, how can I help you today?',
      'isSentByMe': false,
      'time': '12:50',
    },
    {
      'text': 'Hi, I have a headache.',
      'isSentByMe': true,
      'time': '12:51',
    },
    {
      'text': 'Okay, let me check. Have you taken any medication?',
      'isSentByMe': false,
      'time': '12:52',
    },
    {
      'text': 'Not yet.',
      'isSentByMe': true,
      'time': '12:53',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black87),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage(doctorImage ?? 'assets/images/doctor1.png'),
                      ),
                      SizedBox(width: 10),
                      Text(
                        doctorName ?? 'Doctor',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.call, color: Colors.black87),
                    onPressed: () {
                      // Navigasi ke CallPage dengan animasi slide dari kiri ke kanan
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) => CallPage(),
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
                  ),
                ],
              ),
            ),
            Divider(),

            // Daftar pesan
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  final isSentByMe = message['isSentByMe'] as bool;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Row(
                      mainAxisAlignment: isSentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                      children: [
                        if (!isSentByMe)
                          CircleAvatar(
                            radius: 15,
                            backgroundImage: AssetImage(doctorImage ?? 'assets/images/doctor1.png'),
                          ),
                        if (!isSentByMe) SizedBox(width: 10),
                        Flexible(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                            decoration: BoxDecoration(
                              color: isSentByMe ? Colors.teal[50] : Colors.grey[200],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Column(
                              crossAxisAlignment: isSentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                              children: [
                                Text(
                                  message['text'],
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  message['time'],
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (isSentByMe) SizedBox(width: 10),
                        if (isSentByMe)
                          CircleAvatar(
                            radius: 15,
                            backgroundImage: AssetImage('assets/gambar7.jpg'),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Input pesan
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.send, color: Colors.white),
                      onPressed: () {
                        // Aksi untuk mengirim pesan
                      },
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