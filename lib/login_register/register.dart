import 'package:flutter/material.dart';
import 'dart:ui'; // Untuk BackdropFilter
import '../menu_utama/main_page.dart'; // Import halaman main_page.dart

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => MainPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(1.0, 0.0);
            const end = Offset.zero;
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
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/gambar2.png'), // Background sama seperti login.dart
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white,
              BlendMode.darken,
            ),
          ),
        ),
        child: Stack(
          children: [
            // Tombol kembali di sudut kiri atas
            Positioned(
              top: 40,
              left: 10,
              child: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  Navigator.pop(context); // Kembali ke halaman sebelumnya (LoginPage)
                },
              ),
            ),
            // Konten utama
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Masker dan ikon hati (di luar card)
                      Stack(
                        alignment: Alignment.center,
        
                      ),
                      SizedBox(height: 20),
                      // Card transparan dengan efek blur untuk membungkus form register
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 40), // Mengurangi lebar card
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Efek blur
                            child: Container(
                              padding: const EdgeInsets.all(30.0), // Meningkatkan padding untuk tinggi
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.3), // Latar card semi-transparan
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Column(
                                children: [
                                  // Teks "Create Account"
                                  Text(
                                    'Create Account',
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black, // Warna hitam untuk kontras
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  // Form untuk validasi
                                  Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        // Field Username
                                        TextFormField(
                                          controller: _usernameController,
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(Icons.person, color: Colors.grey),
                                            hintText: 'Username',
                                            filled: true,
                                            fillColor: Colors.white.withOpacity(0.8),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: BorderSide.none,
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Please enter your username';
                                            }
                                            if (value.length < 3) {
                                              return 'Username must be at least 3 characters';
                                            }
                                            return null;
                                          },
                                        ),
                                        SizedBox(height: 15),
                                        // Field No Handphone
                                        TextFormField(
                                          controller: _phoneController,
                                          keyboardType: TextInputType.phone,
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(Icons.phone, color: Colors.grey),
                                            hintText: 'No Handphone',
                                            filled: true,
                                            fillColor: Colors.white.withOpacity(0.8),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: BorderSide.none,
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Please enter your phone number';
                                            }
                                            if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                                              return 'Please enter a valid phone number';
                                            }
                                            return null;
                                          },
                                        ),
                                        SizedBox(height: 15),
                                        // Field Email
                                        TextFormField(
                                          controller: _emailController,
                                          keyboardType: TextInputType.emailAddress,
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(Icons.email, color: Colors.grey),
                                            hintText: 'Email',
                                            filled: true,
                                            fillColor: Colors.white.withOpacity(0.8),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: BorderSide.none,
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Please enter your email';
                                            }
                                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                                              return 'Please enter a valid email';
                                            }
                                            return null;
                                          },
                                        ),
                                        SizedBox(height: 15),
                                        // Field Password
                                        TextFormField(
                                          controller: _passwordController,
                                          obscureText: true,
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(Icons.lock, color: Colors.grey),
                                            hintText: 'Password',
                                            filled: true,
                                            fillColor: Colors.white.withOpacity(0.8),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(10),
                                              borderSide: BorderSide.none,
                                            ),
                                          ),
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Please enter your password';
                                            }
                                            if (value.length < 6) {
                                              return 'Password must be at least 6 characters';
                                            }
                                            return null;
                                          },
                                        ),
                                        SizedBox(height: 20),
                                        // Tombol "Create Account"
                                        ElevatedButton(
                                          onPressed: _register,
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.teal[300],
                                            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                'Create Account',
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              SizedBox(width: 10)
                                    
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  // Teks "OR"
                                  Text(
                                    'OR',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  // Tombol Facebook dan Twitter
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        child: ElevatedButton.icon(
                                          onPressed: () {
                                            // Aksi untuk sign up dengan Facebook
                                          },
                                          icon: Icon(Icons.facebook, color: Colors.white),
                                          label: Text('Facebook', style: TextStyle(color: Colors.black)),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blue[800],
                                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: ElevatedButton.icon(
                                          onPressed: () {
                                            // Aksi untuk sign up dengan Twitter
                                          },
                                          icon: Icon(Icons.alternate_email, color: Colors.white),
                                          label: Text('Twitter', style: TextStyle(color: Colors.black)),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.blue[400],
                                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}