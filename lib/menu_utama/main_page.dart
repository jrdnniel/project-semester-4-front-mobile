import 'package:flutter/material.dart';
import 'menu.dart'; // Import halaman menu.dart
import '../history.dart'; // Import halaman history.dart
import '../fitur_chat/chat.dart'; // Import halaman chat.dart
import '../fitur_profile/profile.dart'; // Import halaman profile.dart

class MainPage extends StatefulWidget {
  static final GlobalKey<_MainPageState> globalKey = GlobalKey<_MainPageState>();

  MainPage({Key? key}) : super(key: key ?? globalKey);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0; // Indeks tab yang aktif

  // Daftar halaman yang akan ditampilkan di IndexedStack
  final List<Widget> _pages = [
    MenuPage(),
    HistoryPage(),
    ChatPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Ubah indeks tab yang aktif
    });
  }

  void setIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: _onItemTapped,
      ),
    );
  }
}