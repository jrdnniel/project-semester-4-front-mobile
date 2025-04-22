import 'package:flutter/material.dart';
import '../login_register/login.dart'; // Import halaman login.dart (sesuaikan path jika perlu)

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header dengan latar belakang gradien
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.teal[100]!, // Hijau mint cerah
                      Colors.teal[50]!, // Hijau mint lebih terang
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    // Foto profil dengan border putih
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 3),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage(
                            'assets/images/profile.png'), // Ganti dengan path gambar lokal
                      ),
                    ),
                    SizedBox(height: 15),
                    // Nama pengguna dengan font bawaan
                    Text(
                      'Nayla Socans',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 20),
                    // Kartu data kesehatan dengan animasi
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        AnimatedHealthCard(
                          icon: Icons.favorite,
                          label: 'Heart rate',
                          value: '215bpm',
                          delay: 200,
                        ),
                        AnimatedHealthCard(
                          icon: Icons.local_fire_department,
                          label: 'Calories',
                          value: '756cal',
                          delay: 400,
                        ),
                        AnimatedHealthCard(
                          icon: Icons.fitness_center,
                          label: 'Weight',
                          value: '103lbs',
                          delay: 600,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Daftar menu
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    ProfileMenuItem(
                      icon: Icons.favorite_border,
                      label: 'My Saved',
                      onTap: () {
                        // Aksi untuk My Saved
                      },
                    ),
                    ProfileMenuItem(
                      icon: Icons.calendar_today,
                      label: 'Appointmnet',
                      onTap: () {
                        // Aksi untuk Appointment
                      },
                    ),
                    ProfileMenuItem(
                      icon: Icons.payment,
                      label: 'Payment Method',
                      onTap: () {
                        // Aksi untuk Payment Method
                      },
                    ),
                    ProfileMenuItem(
                      icon: Icons.question_answer,
                      label: 'FAQs',
                      onTap: () {
                        // Aksi untuk FAQs
                      },
                    ),
                    ProfileMenuItem(
                      icon: Icons.logout,
                      label: 'Logout',
                      onTap: () {
                        // Navigasi ke halaman LoginPage
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()), // Ganti LoginPage dengan nama class di login.dart
                        );
                      },
                      isLogout: true, // Untuk gaya khusus Logout
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget untuk kartu data kesehatan dengan animasi
class AnimatedHealthCard extends StatefulWidget {
  final IconData icon;
  final String label;
  final String value;
  final int delay;

  const AnimatedHealthCard({super.key, 
    required this.icon,
    required this.label,
    required this.value,
    required this.delay,
  });

  @override
  _AnimatedHealthCardState createState() => _AnimatedHealthCardState();
}

class _AnimatedHealthCardState extends State<AnimatedHealthCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(milliseconds: 500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    // Mulai animasi dengan delay
    Future.delayed(Duration(milliseconds: widget.delay), () {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Card(
          elevation: 2, // Bayangan lebih lembut
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            width: 110,
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Column(
              children: [
                Icon(
                  widget.icon,
                  color: Colors.teal[600], // Warna ikon lebih cerah
                  size: 24,
                ),
                SizedBox(height: 5),
                Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5),
                Text(
                  widget.value,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Widget untuk item menu profil
class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isLogout;

  const ProfileMenuItem({super.key, 
    required this.icon,
    required this.label,
    required this.onTap,
    this.isLogout = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
      leading: Icon(
        icon,
        color: isLogout ? Colors.red : Colors.teal[600], // Warna ikon lebih cerah
        size: 20,
      ),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 16,
          color: isLogout ? Colors.red : Colors.black87,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: Colors.grey,
        size: 16,
      ),
      onTap: onTap,
    );
  }
}