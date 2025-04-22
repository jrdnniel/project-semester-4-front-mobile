import 'package:flutter/material.dart';

class HospitalPage extends StatefulWidget {
  const HospitalPage({super.key});

  @override
  _HospitalPageState createState() => _HospitalPageState();
}

class _HospitalPageState extends State<HospitalPage> {
  // Daftar rumah sakit dengan informasi tambahan
  final List<Map<String, String>> hospitals = [
    {
      'name': 'Rumah Sakit Siloam Dhirga Surya',
      'address': 'J. Imogiri No.6, Pertimax Tengah, Kec. Medan Potabak, Kota Medan, Sumatera Utara 20212',
      'image': 'assets/gambar25.png',
      'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    },
    {
      'name': 'Rumah Sakit Columbia Asia',
      'address': 'J. Listrik No.2A, Petisah Tengah, Kec. Medan Petisah, Kota Medan, Sumatera Utara 20112',
      'image': 'assets/gambar26.png',
      'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    },
    {
      'name': 'Rumah Sakit Maternita',
      'address': 'J. Teuku Umar No.9-11, Petisah Tengah Kec. Medan Petisah, Kota Medan, Sumatera Utara 20112',
      'image': 'assets/gambar27.png',
      'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    },
    {
      'name': 'Rumah Sakit Murni Teguh',
      'address': 'J. Prof. H.M. Yamin, SH No.47, Kec. Medan Timur, Kota Medan 20234',
      'image': 'assets/gambar28.png',
      'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    },
    {
      'name': 'Rumah Sakit Umum Pusat H.Adam Malik',
      'address': 'J. Bunga Lau No.17, Kemenangan Tani, Kec. Medan Tuntungan, Kota Medan, Sumatera Utara 20136',
      'image': 'assets/gambar29.png',
      'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    },
    {
      'name': 'Rumah Sakit Umum Bunda Thamrin',
      'address': 'J. Sei Batu Hati No.28-30 42438A, Sei Sican, Kec. Medan Maimun, Sungai, Kota Medan, Sumatera Utara',
      'image': 'assets/gambar30.png',
      'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    },
    {
      'name': 'Rumah Sakit Umum Royal Prima',
      'address': 'J. Ayahanda No.68A, Medan, Indonesia 20118',
      'image': 'assets/gambar31.png',
      'description': 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
    },
  ];

  List<Map<String, String>> filteredHospitals = [];

  @override
  void initState() {
    super.initState();
    filteredHospitals = hospitals;
  }

  void _filterHospitals(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredHospitals = hospitals;
      } else {
        filteredHospitals = hospitals
            .where((hospital) =>
                hospital['name']!.toLowerCase().contains(query.toLowerCase()) ||
                hospital['address']!.toLowerCase().contains(query.toLowerCase()))
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
          'Informasi Rumah Sakit',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              onChanged: _filterHospitals,
              decoration: InputDecoration(
                hintText: 'Temukan Rumah Sakit',
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
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              itemCount: filteredHospitals.length,
              itemBuilder: (context, index) {
                final hospital = filteredHospitals[index];
                return HospitalCard(
                  name: hospital['name']!,
                  address: hospital['address']!,
                  image: hospital['image']!,
                  description: hospital['description']!,
                  onTap: () {
                    // Tampilkan detail sebagai dialog overlay
                    showDialog(
                      context: context,
                      builder: (context) => HospitalDetailCard(
                        name: hospital['name']!,
                        address: hospital['address']!,
                        image: hospital['image']!,
                        description: hospital['description']!,
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

class HospitalCard extends StatelessWidget {
  final String name;
  final String address;
  final String image;
  final String description;
  final VoidCallback onTap;

  const HospitalCard({
    super.key,
    required this.name,
    required this.address,
    required this.image,
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

// Widget untuk kartu detail rumah sakit (sebagai overlay)
class HospitalDetailCard extends StatelessWidget {
  final String name;
  final String address;
  final String image;
  final String description;

  const HospitalDetailCard({
    super.key,
    required this.name,
    required this.address,
    required this.image,
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
            // Gambar Rumah Sakit
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
            // Nama Rumah Sakit
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