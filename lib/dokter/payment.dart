import 'package:flutter/material.dart';
import '../menu_utama/main_page.dart'; // Import MainPage

class PaymentPage extends StatefulWidget {
  final DateTime selectedDate;

  const PaymentPage({super.key, required this.selectedDate});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  String? _selectedPaymentMethod;
  final TextEditingController _patientNameController = TextEditingController();

  @override
  void dispose() {
    _patientNameController.dispose();
    super.dispose();
  }

  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TweenAnimationBuilder(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: Duration(milliseconds: 500),
                  curve: Curves.elasticOut,
                  builder: (context, double scale, child) {
                    return Transform.scale(
                      scale: scale,
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.teal,
                        size: 80,
                      ),
                    );
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'Pembayaran Berhasil!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Terima kasih atas pembayaran Anda.',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Tutup dialog
                    // Navigasi ke MainPage dengan tab MenuPage aktif
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainPage(),
                      ),
                    );
                    // Set indeks tab ke 0 (MenuPage) setelah navigasi
                    MainPage.globalKey.currentState?.setIndex(0);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('OK'),
                ),
              ],
            ),
          ),
        );
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
            Center(
              child: Column(
                children: [
                  Text(
                    'TOTAL',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Rp. 100.000,00',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Nama Pasien',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _patientNameController,
              decoration: InputDecoration(
                hintText: 'Masukkan nama pasien',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Metode Pembayaran',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ChoiceChip(
                  label: Text('Card Payment'),
                  selected: _selectedPaymentMethod == 'Card',
                  onSelected: (selected) {
                    setState(() {
                      _selectedPaymentMethod = selected ? 'Card' : null;
                    });
                  },
                  selectedColor: Colors.teal[100],
                  backgroundColor: Colors.grey[200],
                ),
                ChoiceChip(
                  label: Text('Cash Payment'),
                  selected: _selectedPaymentMethod == 'Cash',
                  onSelected: (selected) {
                    setState(() {
                      _selectedPaymentMethod = selected ? 'Cash' : null;
                    });
                  },
                  selectedColor: Colors.teal[100],
                  backgroundColor: Colors.grey[200],
                ),
              ],
            ),
            SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_patientNameController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Harap masukkan nama pasien')),
                    );
                    return;
                  }
                  if (_selectedPaymentMethod == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Harap pilih metode pembayaran')),
                    );
                    return;
                  }

                  print('Pembayaran selesai untuk: ${_patientNameController.text}');
                  print('Metode: $_selectedPaymentMethod');
                  print('Tanggal: ${widget.selectedDate}');

                  _showSuccessDialog(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text('Pay Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}