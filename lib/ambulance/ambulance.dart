import 'package:flutter/material.dart';

class AmbulancePage extends StatefulWidget {
  const AmbulancePage({super.key});

  @override
  _AmbulancePageState createState() => _AmbulancePageState();
}

class _AmbulancePageState extends State<AmbulancePage> {
  // Daftar layanan ambulans (contoh data statis, bisa diganti dengan API nanti)
  final List<Map<String, String>> ambulances = [
    {
      'name': 'Ambulans Medan Sehat',
      'address': 'J. Kesehatan No.10, Medan, Sumatera Utara 20111',
      'image': 'assets/gambar32.jpg',
      'phone': '(061) 123-4567',
      'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    },
    {
      'name': 'Ambulans Prima Emergency',
      'address': 'J. Darurat No.5, Medan, Sumatera Utara 20112',
      'image': 'assets/gambar33.jpg',
      'phone': '(061) 234-5678',
      'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    },
    {
      'name': 'Ambulans Siloam Rescue',
      'address': 'J. Imogiri No.8, Medan, Sumatera Utara 20212',
      'image': 'assets/gambar34.jpg',
      'phone': '(061) 345-6789',
      'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    },
    {
      'name': 'Ambulans Bunda Thamrin',
      'address': 'J. Sei Batu Hati No.30, Medan, Sumatera Utara 20136',
      'image': 'assets/gambar35.jpg',
      'phone': '(061) 456-7890',
      'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    },
  ];

  List<Map<String, String>> filteredAmbulances = [];

  @override
  void initState() {
    super.initState();
    filteredAmbulances = ambulances;
  }

  void _filterAmbulances(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredAmbulances = ambulances;
      } else {
        filteredAmbulances = ambulances
            .where((ambulance) =>
                ambulance['name']!.toLowerCase().contains(query.toLowerCase()) ||
                ambulance['address']!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal[50],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Layanan Ambulans',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
      body: Column(
        children: [
          // Kolom Pencarian
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              onChanged: _filterAmbulances,
              decoration: InputDecoration(
                hintText: 'Cari Layanan Ambulans',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          // Daftar Ambulans
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              itemCount: filteredAmbulances.length,
              itemBuilder: (context, index) {
                final ambulance = filteredAmbulances[index];
                return AmbulanceCard(
                  name: ambulance['name']!,
                  address: ambulance['address']!,
                  image: ambulance['image']!,
                  phone: ambulance['phone']!,
                  description: ambulance['description']!,
                  onTap: () {
                    // Tampilkan detail sebagai dialog overlay
                    showDialog(
                      context: context,
                      builder: (context) => AmbulanceDetailCard(
                        name: ambulance['name']!,
                        address: ambulance['address']!,
                        image: ambulance['image']!,
                        phone: ambulance['phone']!,
                        description: ambulance['description']!,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Widget untuk kartu ambulans
class AmbulanceCard extends StatelessWidget {
  final String name;
  final String address;
  final String image;
  final String phone;
  final String description;
  final VoidCallback onTap;

  const AmbulanceCard({
    super.key,
    required this.name,
    required this.address,
    required this.image,
    required this.phone,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.only(bottom: 15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        child: Row(
          children: [
            // Gambar Ambulans
            Container(
              width: 100,
              height: 100,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                  onError: (exception, stackTrace) => const Icon(Icons.broken_image),
                ),
              ),
            ),
            // Informasi Ambulans
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      address,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget untuk kartu detail ambulans (sebagai overlay)
class AmbulanceDetailCard extends StatelessWidget {
  final String name;
  final String address;
  final String image;
  final String phone;
  final String description;

  const AmbulanceDetailCard({
    super.key,
    required this.name,
    required this.address,
    required this.image,
    required this.phone,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar Ambulans
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                  onError: (exception, stackTrace) => const Icon(Icons.broken_image),
                ),
              ),
            ),
            const SizedBox(height: 15),
            // Nama Ambulans
            Text(
              name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            // Alamat
            Text(
              address,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 15),
            // Nomor Telepon
            Row(
              children: [
                const Icon(Icons.phone, color: Colors.teal, size: 20),
                const SizedBox(width: 10),
                Text(
                  'Nomor Telepon: $phone',
                  style: const TextStyle(fontSize: 16, color: Colors.black87),
                ),
              ],
            ),
            const SizedBox(height: 15),
            // Deskripsi (Lorem Ipsum)
            Text(
              description,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),
            // Tombol Tutup
            Align(
              alignment: Alignment.center,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(150, 50),
                ),
                child: const Text('Tutup'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}