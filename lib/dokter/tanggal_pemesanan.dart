import 'package:flutter/material.dart';
import 'payment.dart'; // Import halaman payment.dart

class TanggalPemesananPage extends StatefulWidget {
  const TanggalPemesananPage({super.key});

  @override
  _TanggalPemesananPageState createState() => _TanggalPemesananPageState();
}

class _TanggalPemesananPageState extends State<TanggalPemesananPage> {
  DateTime selectedDate = DateTime.now();
  DateTime displayedMonth = DateTime(2024, 1); // Default ke Januari 2024

  void _changeMonth(int direction) {
    setState(() {
      displayedMonth = DateTime(
        displayedMonth.year,
        displayedMonth.month + direction,
        1,
      );
    });
  }

  Widget _buildCalendar() {
    final firstDayOfMonth = DateTime(displayedMonth.year, displayedMonth.month, 1);
    final lastDayOfMonth = DateTime(displayedMonth.year, displayedMonth.month + 1, 0);
    final daysInMonth = lastDayOfMonth.day;
    final firstDayWeekday = firstDayOfMonth.weekday;

    List<Widget> dayWidgets = [];
    for (int i = 1; i < firstDayWeekday; i++) {
      dayWidgets.add(SizedBox(width: 40, height: 40));
    }

    for (int day = 1; day <= daysInMonth; day++) {
      final currentDate = DateTime(displayedMonth.year, displayedMonth.month, day);
      final isSelected = selectedDate.day == day &&
          selectedDate.month == displayedMonth.month &&
          selectedDate.year == displayedMonth.year;

      dayWidgets.add(
        GestureDetector(
          onTap: () {
            setState(() {
              selectedDate = currentDate;
            });
          },
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isSelected ? Colors.teal[100] : null,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text(
                '$day',
                style: TextStyle(
                  fontSize: 16,
                  color: isSelected ? Colors.teal : Colors.black87,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: dayWidgets,
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
            Text(
              'Pilih Tanggal',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_left),
                  onPressed: () => _changeMonth(-1),
                ),
                Text(
                  '${_getMonthName(displayedMonth.month)} ${displayedMonth.year}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.arrow_right),
                  onPressed: () => _changeMonth(1),
                ),
              ],
            ),
            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildDayLabel('Sen'),
                _buildDayLabel('Sel'),
                _buildDayLabel('Rab'),
                _buildDayLabel('Kam'),
                _buildDayLabel('Jum'),
                _buildDayLabel('Sab'),
                _buildDayLabel('Min'),
              ],
            ),
            SizedBox(height: 20),

            _buildCalendar(),
            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    minimumSize: Size(150, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigasi ke halaman pembayaran dengan tanggal yang dipilih
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentPage(selectedDate: selectedDate),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    minimumSize: Size(150, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('Booking'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayLabel(String day) {
    return SizedBox(
      width: 40,
      child: Center(
        child: Text(
          day,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    const months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];
    return months[month - 1];
  }
}