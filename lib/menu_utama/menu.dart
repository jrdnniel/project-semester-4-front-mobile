import 'package:doctor/login_register/login.dart';
import 'package:flutter/material.dart';
import 'dart:async'; // Untuk menggunakan Timer
import '../notif.dart'; // Import halaman notif.dart
import '../dokter/find_doctor.dart'; // Import halaman find_doctor.dart
import '../pharmacy/pharmacy_page.dart'; // Import halaman pharmacy_page.dart
import '../hospital/hospital.dart'; // Import halaman hospital.dart
import '../ambulance/ambulance.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  // TAMBAHKAN: GlobalKey untuk mengontrol Scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<String> bannerImages = [
    'assets/gambar3.png',
    'assets/gambar3.png',
    'assets/gambar3.png',
  ];

  final List<String> bannerTexts = [
    'Pertolongan Pertama terhadap Kesehatan Keluarga',
    'Keluarga sehat hati pun gembira',
    'Jangan mau sakit',
  ];

  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (!mounted) return;
      if (_currentPage < bannerImages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return const FilterBottomSheet();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TAMBAHKAN: key dan drawer pada Scaffold
      key: _scaffoldKey,
      drawer: const MyDrawer(), 
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.teal[50],
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // MODIFIKASI: Bungkus Row dengan GestureDetector
                        GestureDetector(
                          onTap: () {
                            // Aksi untuk membuka drawer
                            _scaffoldKey.currentState?.openDrawer();
                          },
                          child: const Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundImage: AssetImage(
                                  'assets/gambar7.jpg',
                                ),
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Hi, Nayla',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.notifications,
                            color: Colors.black87,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        const NotifPage(),
                                transitionsBuilder: (
                                  context,
                                  animation,
                                  secondaryAnimation,
                                  child,
                                ) {
                                  const begin = Offset(1.0, 0.0);
                                  const end = Offset.zero;
                                  const curve = Curves.easeInOut;
                                  var tween = Tween(
                                    begin: begin,
                                    end: end,
                                  ).chain(CurveTween(curve: curve));
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
                    const SizedBox(height: 30),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Let's find\nYOUR top Doctor!",
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Kategori
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Kategori',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CategoryButton(
                      icon: Icons.medical_services,
                      label: 'Dokter',
                      onTap: () {
                        _showFilterBottomSheet(context);
                      },
                    ),
                    CategoryButton(
                      icon: Icons.local_pharmacy,
                      label: 'Pharmacy',
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    PharmacyPage(),
                            transitionsBuilder: (
                              context,
                              animation,
                              secondaryAnimation,
                              child,
                            ) {
                              const begin = Offset(1.0, 0.0);
                              const end = Offset.zero;
                              const curve = Curves.easeInOut;
                              var tween = Tween(
                                begin: begin,
                                end: end,
                              ).chain(CurveTween(curve: curve));
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
                    CategoryButton(
                      icon: Icons.local_hospital,
                      label: 'Rumah Sakit',
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const HospitalPage(),
                            transitionsBuilder: (
                              context,
                              animation,
                              secondaryAnimation,
                              child,
                            ) {
                              const begin = Offset(1.0, 0.0);
                              const end = Offset.zero;
                              const curve = Curves.easeInOut;
                              var tween = Tween(
                                begin: begin,
                                end: end,
                              ).chain(CurveTween(curve: curve));
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
                    CategoryButton(
                      icon: Icons.car_rental, // Mengganti ikon ambulans
                      label: 'Ambulans',
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const AmbulancePage(),
                            transitionsBuilder: (
                              context,
                              animation,
                              secondaryAnimation,
                              child,
                            ) {
                              const begin = Offset(1.0, 0.0);
                              const end = Offset.zero;
                              const curve = Curves.easeInOut;
                              var tween = Tween(
                                begin: begin,
                                end: end,
                              ).chain(CurveTween(curve: curve));
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
              const SizedBox(height: 20),

              // Banner dengan PageView
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SizedBox(
                  height: 120.0,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: bannerImages.length,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: BoxDecoration(
                          color: Colors.teal[50],
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  bannerTexts[index],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            Image.asset(
                              bannerImages[index],
                              height: 80,
                              fit: BoxFit.contain,
                              errorBuilder:
                                  (context, error, stackTrace) =>
                                      const Icon(Icons.broken_image),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Top Doctor
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Top Doctor',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DoctorCard(
                      image: 'assets/gambar4.png',
                      name: 'Dr. Marcus Horic',
                      rating: '4.7',
                      distance: '800M away',
                      specialization: 'Cardiologist',
                      description: 'Lorem ipsum dolor sit amet.',
                      onTap: () {
                        showDialog(
                          context: context,
                          builder:
                              (context) => DoctorDetailDialog(
                                image: 'assets/gambar4.png',
                                name: 'Dr. Marcus Horic',
                                rating: '4.7',
                                specialization: 'Cardiologist',
                                description: 'Lorem ipsum dolor sit amet.',
                              ),
                        );
                      },
                    ),
                    DoctorCard(
                      image: 'assets/gambar5.png',
                      name: 'Dr. Maria Elena',
                      rating: '4.8',
                      distance: '1.5km away',
                      specialization: 'Psychologist',
                      description: 'Lorem ipsum dolor sit amet.',
                      onTap: () {
                        showDialog(
                          context: context,
                          builder:
                              (context) => DoctorDetailDialog(
                                image: 'assets/gambar5.png',
                                name: 'Dr. Maria Elena',
                                rating: '4.8',
                                specialization: 'Psychologist',
                                description: 'Lorem ipsum dolor sit amet.',
                              ),
                        );
                      },
                    ),
                    DoctorCard(
                      image: 'assets/gambar6.png',
                      name: 'Dr. Stevi Jessi',
                      rating: '4.6',
                      distance: '2km away',
                      specialization: 'Orthopedist',
                      description: 'Lorem ipsum dolor sit amet.',
                      onTap: () {
                        showDialog(
                          context: context,
                          builder:
                              (context) => DoctorDetailDialog(
                                image: 'assets/gambar6.png',
                                name: 'Dr. Stevi Jessi',
                                rating: '4.6',
                                specialization: 'Orthopedist',
                                description: 'Lorem ipsum dolor sit amet.',
                              ),
                        );
                      },
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

// TAMBAHKAN: Widget baru untuk Drawer
class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const UserAccountsDrawerHeader(
            accountName: Text(
              "Nayla",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            accountEmail: Text("nayla.s@example.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage('assets/gambar7.jpg'),
            ),
            decoration: BoxDecoration(color: Colors.teal),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Pengaturan'),
            onTap: () {
              // Arahkan ke halaman pengaturan
              Navigator.pop(context);
            },
          ),
          const Divider(), // Garis pemisah
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () {
              // Logika untuk logout
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
        ],
      ),
    );
  }
}

// Widget lainnya (CategoryButton, DoctorCard, dll.) tetap di bawah sini...
// Pastikan widget-widget tersebut tidak dihapus.

// Widget untuk tombol kategori
class CategoryButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const CategoryButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.teal[50],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.teal, size: 30),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}

// Widget untuk kartu dokter
class DoctorCard extends StatelessWidget {
  final String image;
  final String name;
  final String rating;
  final String distance;
  final String specialization;
  final String description;
  final VoidCallback onTap;

  const DoctorCard({
    super.key,
    required this.image,
    required this.name,
    required this.rating,
    required this.distance,
    required this.specialization,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          width: 100,
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              CircleAvatar(radius: 40, backgroundImage: AssetImage(image)),
              const SizedBox(height: 10),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.star, color: Colors.yellow, size: 16),
                  const SizedBox(width: 5),
                  Text(
                    rating,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                distance,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget untuk dialog detail dokter
class DoctorDetailDialog extends StatelessWidget {
  final String image;
  final String name;
  final String rating;
  final String specialization;
  final String description;

  const DoctorDetailDialog({
    super.key,
    required this.image,
    required this.name,
    required this.rating,
    required this.specialization,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(radius: 50, backgroundImage: AssetImage(image)),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(width: 10),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.yellow, size: 16),
                    const SizedBox(width: 5),
                    Text(
                      rating,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 5),
            Text(
              specialization,
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 15),
            Text(
              description,
              style: const TextStyle(fontSize: 14, color: Colors.black87),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// Widget untuk bottom sheet filter
class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  _FilterBottomSheetState createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  String? _selectedSort;
  String? _selectedCategory;

  final List<String> categories = [
    'Anesthesiology',
    'Alhambra',
    'Cardiology',
    'Gynecology',
    'General Surgery',
    'Laser Surgery',
    'Manual Therapy',
    'Surgery',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Filter List',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedSort = null;
                    _selectedCategory = null;
                  });
                },
                child: const Text(
                  'Clear filter',
                  style: TextStyle(fontSize: 14, color: Colors.red),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Sort specialist',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Radio<String>(
                      value: 'A-Z',
                      groupValue: _selectedSort,
                      onChanged: (value) {
                        setState(() {
                          _selectedSort = value;
                        });
                      },
                    ),
                    const Text('From A-Z'),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Radio<String>(
                      value: 'Z-A',
                      groupValue: _selectedSort,
                      onChanged: (value) {
                        setState(() {
                          _selectedSort = value;
                        });
                      },
                    ),
                    const Text('From Z-A'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Select service category',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 200,
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return Row(
                  children: [
                    Radio<String>(
                      value: category,
                      groupValue: _selectedCategory,
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value;
                        });
                      },
                    ),
                    Text(category),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  foregroundColor: Colors.black,
                  minimumSize: const Size(150, 50),
                ),
                child: const Text('CANCEL'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Tutup bottom sheet
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) => FindDoctorPage(
                            selectedSort: _selectedSort,
                            selectedCategory: _selectedCategory,
                          ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(150, 50),
                ),
                child: const Text('SHOW'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
