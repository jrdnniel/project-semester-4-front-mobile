import 'package:flutter/material.dart';
import 'tanggal_pemesanan.dart'; // Import halaman tanggal_pemesanan.dart

class FindDoctorPage extends StatefulWidget {
  final String? selectedSort; // A-Z atau Z-A
  final String? selectedCategory; // Kategori spesialisasi

  const FindDoctorPage({super.key, this.selectedSort, this.selectedCategory});

  @override
  _FindDoctorPageState createState() => _FindDoctorPageState();
}

class _FindDoctorPageState extends State<FindDoctorPage> {
  final List<Map<String, String>> allDoctors = [
    {
      'name': 'Dr. Thomas M. Armbruster',
      'specialization': 'Anesthesiology',
      'image': 'assets/images/doctor1.png',
      'address': 'Your Doctor, 1327 Colonial AVE, Anaheim, CA 92802',
      'education': 'UCSF Medical Center, University of Hawaii, University of Kansas School of Medicine',
      'certification': 'CA State Medical License, HI State Medical License',
      'experience': 'Penempatan: pekerjaan',
      'practice': 'RS. Columbia ASIA',
    },
    {
      'name': 'Dr. Cindy Hsu',
      'specialization': 'Anesthesiology',
      'image': 'assets/images/doctor2.png',
      'address': '123 Health St, Los Angeles, CA 90001',
      'education': 'UCLA Medical School',
      'certification': 'CA State Medical License',
      'experience': '5 tahun',
      'practice': 'RS. Medika',
    },
    {
      'name': 'Dr. Gary Alan Goldman',
      'specialization': 'Anesthesiology',
      'image': 'assets/images/doctor3.png',
      'address': '456 Wellness Ave, San Diego, CA 92101',
      'education': 'UCSD Medical School',
      'certification': 'CA State Medical License',
      'experience': '8 tahun',
      'practice': 'RS. Sehat',
    },
    {
      'name': 'Dr. Nancy L. Bruder',
      'specialization': 'Anesthesiology',
      'image': 'assets/images/doctor4.png',
      'address': '789 Care Rd, San Francisco, CA 94101',
      'education': 'Stanford Medical School',
      'certification': 'CA State Medical License',
      'experience': '10 tahun',
      'practice': 'RS. Prima',
    },
    {
      'name': 'Dr. Marcus Horic',
      'specialization': 'Cardiology',
      'image': 'assets/images/doctor1.png',
      'address': '101 Heart St, New York, NY 10001',
      'education': 'NYU Medical School',
      'certification': 'NY State Medical License',
      'experience': '12 tahun',
      'practice': 'RS. Jantung',
    },
    {
      'name': 'Dr. Maria Elena',
      'specialization': 'Psychology',
      'image': 'assets/images/doctor2.png',
      'address': '202 Mind Ave, Chicago, IL 60601',
      'education': 'University of Chicago',
      'certification': 'IL State Medical License',
      'experience': '7 tahun',
      'practice': 'RS. Jiwa',
    },
    {
      'name': 'Dr. Stevi Jessi',
      'specialization': 'Orthopedist',
      'image': 'assets/images/doctor3.png',
      'address': '303 Bone Rd, Miami, FL 33101',
      'education': 'University of Miami',
      'certification': 'FL State Medical License',
      'experience': '9 tahun',
      'practice': 'RS. Tulang',
    },
  ];

  List<Map<String, String>> filteredDoctors = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _applyFilters();
  }

  void _applyFilters() {
    setState(() {
      filteredDoctors = allDoctors.where((doctor) {
        if (widget.selectedCategory == null) return true;
        return doctor['specialization'] == widget.selectedCategory;
      }).toList();

      if (widget.selectedSort != null) {
        filteredDoctors.sort((a, b) {
          if (widget.selectedSort == 'A-Z') {
            return a['name']!.compareTo(b['name']!);
          } else {
            return b['name']!.compareTo(a['name']!);
          }
        });
      }
    });
  }

  void _filterBySearch(String query) {
    setState(() {
      searchQuery = query;
      filteredDoctors = allDoctors.where((doctor) {
        final matchesCategory = widget.selectedCategory == null || doctor['specialization'] == widget.selectedCategory;
        final matchesSearch = doctor['name']!.toLowerCase().contains(query.toLowerCase());
        return matchesCategory && matchesSearch;
      }).toList();

      if (widget.selectedSort != null) {
        filteredDoctors.sort((a, b) {
          if (widget.selectedSort == 'A-Z') {
            return a['name']!.compareTo(b['name']!);
          } else {
            return b['name']!.compareTo(a['name']!);
          }
        });
      }
    });
  }

  void _showDoctorDetailBottomSheet(Map<String, String> doctor) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DoctorDetailBottomSheet(doctor: doctor);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: _filterBySearch,
              decoration: InputDecoration(
                hintText: 'Temukan Dokter Anda',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: 'Indonesia',
                    items: ['Indonesia'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      labelText: 'State',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: 'Jakarta',
                    items: ['Jakarta'].map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      labelText: 'City',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),

            Text(
              'Specialist list',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: filteredDoctors.length,
                itemBuilder: (context, index) {
                  final doctor = filteredDoctors[index];
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 25,
                      backgroundImage: AssetImage(doctor['image']!),
                    ),
                    title: Text(
                      doctor['name']!,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    subtitle: Text(
                      doctor['specialization']!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      _showDoctorDetailBottomSheet(doctor);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DoctorDetailBottomSheet extends StatelessWidget {
  final Map<String, String> doctor;

  const DoctorDetailBottomSheet({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctor['name']!,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        doctor['specialization']!,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(doctor['image']!),
                ),
              ],
            ),
            SizedBox(height: 20),

            Container(
              padding: EdgeInsets.all(10),
              color: Colors.grey[100],
              child: Text(
                doctor['address']!,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ),
            SizedBox(height: 20),

            Text(
              'Pendidikan & Pelatihan',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(10),
              color: Colors.grey[100],
              child: Text(
                doctor['education']!,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ),
            SizedBox(height: 20),

            Text(
              'Sertifikasi & Lisensi',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(10),
              color: Colors.grey[100],
              child: Text(
                doctor['certification']!,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                ),
              ),
            ),
            SizedBox(height: 20),

            Text(
              'Pengalaman',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),
            Text(
              doctor['experience']!,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20),

            Text(
              'Tempat Praktik',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),
            Text(
              doctor['practice']!,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Tutup bottom sheet
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TanggalPemesananPage(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('Book an Appointment'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}