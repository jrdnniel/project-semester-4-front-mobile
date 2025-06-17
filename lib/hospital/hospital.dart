import 'package:flutter/material.dart';

class HospitalPage extends StatefulWidget {
  const HospitalPage({super.key});

  @override
  _HospitalPageState createState() => _HospitalPageState();
}

class _HospitalPageState extends State<HospitalPage> {
  // --- PERUBAHAN 1: Mengubah tipe data untuk mendukung angka (double) dan menambahkan 'distance' ---
  final List<Map<String, dynamic>> hospitals = [
    {
      'name': 'Rumah Sakit Siloam Dhirga Surya',
      'address': 'J. Imogiri No.6, Pertimax Tengah, Kec. Medan Potabak, Kota Medan, Sumatera Utara 20212',
      'image': 'assets/gambar25.png',
      'description': 'Rumah sakit ini menyediakan layanan unggulan di bidang kardiologi dan neurologi dengan peralatan modern.',
      'distance': 2.5, // Jarak dalam km
    },
    {
      'name': 'Rumah Sakit Columbia Asia',
      'address': 'J. Listrik No.2A, Petisah Tengah, Kec. Medan Petisah, Kota Medan, Sumatera Utara 20112',
      'image': 'assets/gambar26.png',
      'description': 'Dikenal dengan standar internasional, rumah sakit ini fokus pada layanan rawat jalan dan bedah minor.',
      'distance': 1.2, // Jarak dalam km
    },
    {
      'name': 'Rumah Sakit Maternita',
      'address': 'J. Teuku Umar No.9-11, Petisah Tengah Kec. Medan Petisah, Kota Medan, Sumatera Utara 20112',
      'image': 'assets/gambar27.png',
      'description': 'Spesialisasi dalam kesehatan ibu dan anak, menyediakan layanan persalinan dan pediatri yang komprehensif.',
      'distance': 4.8, // Jarak dalam km
    },
    {
      'name': 'Rumah Sakit Murni Teguh',
      'address': 'J. Prof. H.M. Yamin, SH No.47, Kec. Medan Timur, Kota Medan 20234',
      'image': 'assets/gambar28.png',
      'description': 'Menyediakan berbagai layanan medis dengan dukungan teknologi canggih dan tim dokter spesialis.',
      'distance': 9.1, // Jarak dalam km
    },
    {
      'name': 'Rumah Sakit Umum Pusat H.Adam Malik',
      'address': 'J. Bunga Lau No.17, Kemenangan Tani, Kec. Medan Tuntungan, Kota Medan, Sumatera Utara 20136',
      'image': 'assets/gambar29.png',
      'description': 'Sebagai rumah sakit rujukan nasional, memiliki fasilitas terlengkap untuk berbagai kasus medis kompleks.',
      'distance': 8.7, // Jarak dalam km
    },
    {
      'name': 'Rumah Sakit Umum Bunda Thamrin',
      'address': 'J. Sei Batu Hati No.28-30 42438A, Sei Sican, Kec. Medan Maimun, Sungai, Kota Medan, Sumatera Utara',
      'image': 'assets/gambar30.png',
      'description': 'Fokus pada layanan umum dan bedah dengan biaya yang terjangkau bagi masyarakat luas.',
      'distance': 6.3, // Jarak dalam km
    },
    {
      'name': 'Rumah Sakit Umum Royal Prima',
      'address': 'J. Ayahanda No.68A, Medan, Indonesia 20118',
      'image': 'assets/gambar31.png',
      'description': 'Terintegrasi dengan institusi pendidikan, rumah sakit ini menawarkan layanan kesehatan sekaligus pusat pembelajaran.',
      'distance': 3.0, // Jarak dalam km
    },
  ];

  List<Map<String, dynamic>> filteredHospitals = [];

  // --- PERUBAHAN 2: Menambahkan state untuk slider dan query pencarian ---
  double _currentDistance = 10.0; // Nilai default slider (jarak maksimal)
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    // Awalnya, tampilkan semua rumah sakit karena jaraknya 10km
    _updateFilteredList();
  }
  
  // --- PERUBAHAN 3: Membuat satu fungsi filter gabungan ---
  void _updateFilteredList() {
    List<Map<String, dynamic>> tempHospitals = [];
    setState(() {
      // 1. Filter berdasarkan jarak terlebih dahulu
      tempHospitals = hospitals.where((hospital) {
        return hospital['distance'] <= _currentDistance;
      }).toList();

      // 2. Filter berdasarkan teks dari hasil filter jarak
      if (_searchQuery.isNotEmpty) {
        tempHospitals = tempHospitals.where((hospital) {
          final nameLower = hospital['name']!.toLowerCase();
          final addressLower = hospital['address']!.toLowerCase();
          final queryLower = _searchQuery.toLowerCase();
          return nameLower.contains(queryLower) || addressLower.contains(queryLower);
        }).toList();
      }
      
      filteredHospitals = tempHospitals;
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
          Container(
            padding: const EdgeInsets.all(20.0),
            color: Colors.teal[50], // Beri warna latar belakang yang sama dengan appbar
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Search Bar
                TextField(
                  onChanged: (query) {
                    _searchQuery = query;
                    _updateFilteredList();
                  },
                  decoration: InputDecoration(
                    hintText: 'Temukan Rumah Sakit',
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white, // Ubah warna fill agar kontras
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // --- PERUBAHAN 4: Menambahkan UI untuk Slider Jarak ---
                Text(
                  'Jarak Maksimal: ${_currentDistance.toStringAsFixed(1)} km',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                Slider(
                  value: _currentDistance,
                  min: 1.0,
                  max: 10.0,
                  divisions: 9, // (10-1) untuk step 1km
                  label: '${_currentDistance.round()} km',
                  activeColor: Colors.teal,
                  inactiveColor: Colors.teal.withOpacity(0.3),
                  onChanged: (value) {
                    setState(() {
                      _currentDistance = value;
                    });
                    _updateFilteredList();
                  },
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('1 km', style: TextStyle(color: Colors.grey)),
                    Text('10 km', style: TextStyle(color: Colors.grey)),
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: filteredHospitals.isEmpty
                ? const Center(
                    child: Text(
                      'Tidak ada rumah sakit yang cocok.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(20.0),
                    itemCount: filteredHospitals.length,
                    itemBuilder: (context, index) {
                      final hospital = filteredHospitals[index];
                      return HospitalCard(
                        name: hospital['name']!,
                        address: hospital['address']!,
                        image: hospital['image']!,
                        description: hospital['description']!,
                        // Tampilkan jarak di kartu
                        distance: hospital['distance']!,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => HospitalDetailCard(
                              name: hospital['name']!,
                              address: hospital['address']!,
                              image: hospital['image']!,
                              description: hospital['description']!,
                              distance: hospital['distance']!,
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
  final double distance; // --- PERUBAHAN ---: Tambahkan parameter distance
  final VoidCallback onTap;

  const HospitalCard({
    super.key,
    required this.name,
    required this.address,
    required this.image,
    required this.description,
    required this.distance, // --- PERUBAHAN ---
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
              height: 120, // Sesuaikan tinggi agar proporsional
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(image),
                  fit: BoxFit.cover,
                  onError: (exception, stackTrace) =>
                      const Icon(Icons.broken_image),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
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
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      address,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    // --- PERUBAHAN ---: Tampilkan jarak
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.teal[50],
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: Text(
                        '${distance.toStringAsFixed(1)} km',
                        style: const TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    )
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

// Widget untuk kartu detail rumah sakit
class HospitalDetailCard extends StatelessWidget {
  final String name;
  final String address;
  final String image;
  final String description;
  final double distance; // --- PERUBAHAN ---: Tambahkan parameter distance

  const HospitalDetailCard({
    super.key,
    required this.name,
    required this.address,
    required this.image,
    required this.description,
    required this.distance, // --- PERUBAHAN ---
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                    onError: (exception, stackTrace) =>
                        const Icon(Icons.broken_image),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      name,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '${distance.toStringAsFixed(1)} km',
                     style: const TextStyle(
                          fontSize: 16,
                          color: Colors.teal,
                          fontWeight: FontWeight.bold
                        ),
                  )
                ],
              ),
              const SizedBox(height: 10),
              Text(
                address,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const Divider(height: 30),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),
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
      ),
    );
  }
}