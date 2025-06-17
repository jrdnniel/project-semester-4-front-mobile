import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../login_register/login.dart';
import '../fitur_tambahan/payment_method_page.dart'; // Import halaman PaymentMethodPage

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _showImageSourceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pilih Sumber Gambar'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Galeri'),
                  onTap: () {
                    _pickImage(ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Kamera'),
                  onTap: () {
                    _pickImage(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.teal[100]!,
                      Colors.teal[50]!,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: GestureDetector(
                            onTap: () => _showImageSourceDialog(context),
                            child: CircleAvatar(
                              radius: 50,
                              backgroundImage: _image != null
                                  ? FileImage(_image!) as ImageProvider<Object>?
                                  : const AssetImage('assets/gambar7.jpg'),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () => _showImageSourceDialog(context),
                            child: Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.teal,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white, width: 2),
                              ),
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      'Nayla Socans',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Row(
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
              const SizedBox(height: 20),
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
                      label: 'Appointment',
                      onTap: () {
                        // Aksi untuk Appointment
                      },
                    ),
                    ProfileMenuItem(
                      icon: Icons.payment,
                      label: 'Payment Method',
                      onTap: () {
                        // --- Tambahkan navigasi ke PaymentMethodPage di sini ---
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PaymentMethodPage()),
                        );
                      },
                    ),
                    ProfileMenuItem(
                      icon: Icons.mode_comment_rounded,
                      label: 'FAQs',
                      onTap: () {
                        // Aksi untuk FAQs
                      },
                    ),
                    ProfileMenuItem(
                      icon: Icons.logout,
                      label: 'Logout',
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      isLogout: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget AnimatedHealthCard dan ProfileMenuItem tetap sama seperti sebelumnya
// (Saya tidak menyertakannya di sini untuk menjaga fokus pada perubahan,
// tetapi pastikan mereka ada di file Anda).

// Widget untuk kartu data kesehatan dengan animasi (TETAP SAMA)
class AnimatedHealthCard extends StatefulWidget {
  final IconData icon;
  final String label;
  final String value;
  final int delay;

  const AnimatedHealthCard({
    super.key,
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
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

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
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            width: 110,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
            child: Column(
              children: [
                Icon(
                  widget.icon,
                  color: Colors.teal[600],
                  size: 24,
                ),
                const SizedBox(height: 5),
                Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 5),
                Text(
                  widget.value,
                  style: const TextStyle(
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

// Widget untuk item menu profil (TETAP SAMA)
class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isLogout;

  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.isLogout = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
      leading: Icon(
        icon,
        color: isLogout ? Colors.red : Colors.teal[600],
        size: 20,
      ),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 16,
          color: isLogout ? Colors.red : Colors.black87,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.grey,
        size: 16,
      ),
      onTap: onTap,
    );
  }
}