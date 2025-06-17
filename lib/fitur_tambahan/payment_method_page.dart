import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

// --- Model data untuk kartu pembayaran ---
class PaymentCardModel {
  String id;
  String cardNumber;
  String cardHolderName;
  String expiryDate;
  String cardType;

  PaymentCardModel({
    required this.id,
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiryDate,
    required this.cardType,
  });
}

// --- Halaman utama metode pembayaran ---
class PaymentMethodPage extends StatefulWidget {
  const PaymentMethodPage({super.key});

  @override
  State<PaymentMethodPage> createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  final List<PaymentCardModel> _paymentCards = [
    PaymentCardModel(
      id: 'card_001',
      cardNumber: '**** **** **** 1234',
      cardHolderName: 'Nayla Socans',
      expiryDate: '12/25',
      cardType: 'Visa',
    ),
    PaymentCardModel(
      id: 'card_002',
      cardNumber: '**** **** **** 5678',
      cardHolderName: 'Nayla Socans',
      expiryDate: '07/26',
      cardType: 'Mastercard',
    ),
    PaymentCardModel(
      id: 'card_003',
      cardNumber: '**** **** **** 9012',
      cardHolderName: 'Nayla Socans',
      expiryDate: '03/27',
      cardType: 'Amex',
    ),
  ];

  int _currentPage = 0;
  final PageController _pageController = PageController(viewportFraction: 0.85);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _addCard() {
    setState(() {
      _paymentCards.add(
        PaymentCardModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          cardNumber: '**** **** **** ${(_paymentCards.length + 1) * 1111}',
          cardHolderName: 'Kartu Baru',
          expiryDate: '01/30',
          cardType: (_paymentCards.length % 2 == 0) ? 'Visa' : 'Mastercard',
        ),
      );
      if (_paymentCards.length > 1) {
        _currentPage = _paymentCards.length - 1;
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Kartu baru berhasil ditambahkan!')),
    );
  }

  void _editCard(PaymentCardModel card) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Mengedit kartu ${card.cardNumber}...')),
    );
  }

  void _deleteCard(String cardId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hapus Kartu'),
          content: const Text('Apakah Anda yakin ingin menghapus kartu ini?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Hapus', style: TextStyle(color: Colors.red)),
              onPressed: () {
                setState(() {
                  _paymentCards.removeWhere((card) => card.id == cardId);
                  if (_paymentCards.isNotEmpty) {
                    if (_currentPage >= _paymentCards.length) {
                      _currentPage = _paymentCards.length - 1;
                    }
                    _pageController.jumpToPage(_currentPage);
                  } else {
                    _currentPage = 0;
                  }
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Kartu berhasil dihapus!')),
                );
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
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Metode Pembayaran',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        backgroundColor: Colors.teal[600],
        foregroundColor: Colors.white,
        activeBackgroundColor: Colors.teal[800],
        activeForegroundColor: Colors.white,
        visible: true,
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.add_circle_outline),
            backgroundColor: Colors.teal[600],
            foregroundColor: Colors.white,
            label: 'Tambah Kartu',
            labelStyle: const TextStyle(fontSize: 14, color: Colors.black),
            onTap: _addCard,
          ),
          if (_paymentCards.isNotEmpty)
            SpeedDialChild(
              child: const Icon(Icons.edit),
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
              label: 'Edit Kartu',
              labelStyle: const TextStyle(fontSize: 14, color: Colors.black),
              onTap: () => _editCard(_paymentCards[_currentPage]),
            ),
          if (_paymentCards.isNotEmpty)
            SpeedDialChild(
              child: const Icon(Icons.delete),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              label: 'Hapus Kartu',
              labelStyle: const TextStyle(fontSize: 14, color: Colors.black),
              onTap: () => _deleteCard(_paymentCards[_currentPage].id),
            ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
            child: Text(
              'Kartu Tersimpan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 200,
            child: _paymentCards.isEmpty
                ? Center(
                    child: Text(
                      'Belum ada kartu pembayaran. Silakan tambahkan!',
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      textAlign: TextAlign.center,
                    ),
                  )
                : PageView.builder(
                    controller: _pageController,
                    itemCount: _paymentCards.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      final card = _paymentCards[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: PaymentCard(
                          cardNumber: card.cardNumber,
                          cardHolderName: card.cardHolderName,
                          expiryDate: card.expiryDate,
                          cardType: card.cardType,
                        ),
                      );
                    },
                  ),
          ),
          const SizedBox(height: 10),
          if (_paymentCards.isNotEmpty)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_paymentCards.length, (index) {
                return Container(
                  width: 8.0,
                  height: 8.0,
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? Colors.teal[600]
                        : Colors.grey[300],
                  ),
                );
              }),
            ),
          const SizedBox(height: 20),
          Expanded(
            child: _paymentCards.isEmpty
                ? const SizedBox.shrink()
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    itemCount: _paymentCards.length,
                    itemBuilder: (context, index) {
                      final card = _paymentCards[index];
                      IconData typeIcon;
                      switch (card.cardType.toLowerCase()) {
                        case 'visa':
                          typeIcon = Icons.payment;
                          break;
                        case 'mastercard':
                          typeIcon = Icons.credit_card;
                          break;
                        case 'amex':
                          typeIcon = Icons.credit_card;
                          break;
                        default:
                          typeIcon = Icons.credit_card;
                      }
                      return ListTile(
                        leading: Icon(
                          typeIcon,
                          color: Colors.teal[600],
                          size: 20,
                        ),
                        title: Text(
                          card.cardNumber,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Text(
                          '${card.cardType} - Berlaku hingga ${card.expiryDate}',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14,
                          ),
                        ),
                        trailing: Icon(
                          _currentPage == index
                              ? Icons.check_circle
                              : Icons.circle_outlined,
                          color: _currentPage == index
                              ? Colors.teal[600]
                              : Colors.grey[400],
                        ),
                        onTap: () {
                          setState(() {
                            _currentPage = index;
                            _pageController.animateToPage(
                              _currentPage,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn,
                            );
                          });
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

// --- Widget PaymentCard ---
class PaymentCard extends StatelessWidget {
  final String cardNumber;
  final String cardHolderName;
  final String expiryDate;
  final String cardType;

  const PaymentCard({
    super.key,
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiryDate,
    required this.cardType,
  });

  @override
  Widget build(BuildContext context) {
    IconData typeIcon;
    Color cardColor;

    switch (cardType.toLowerCase()) {
      case 'visa':
        typeIcon = Icons.payment;
        cardColor = Colors.indigo[400]!;
        break;
      case 'mastercard':
        typeIcon = Icons.credit_card;
        cardColor = Colors.orange[400]!;
        break;
      case 'amex':
        typeIcon = Icons.credit_card;
        cardColor = Colors.blueGrey[400]!;
        break;
      default:
        typeIcon = Icons.credit_card;
        cardColor = Colors.grey[600]!;
    }

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [cardColor, cardColor.withOpacity(0.8)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: cardColor.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Icon(
                typeIcon,
                color: Colors.white,
                size: 40,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              cardNumber,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Nama Pemegang Kartu',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      cardHolderName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Berlaku Hingga',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      expiryDate,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// --- Main App ---
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Payment Method Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const PaymentMethodPage(),
    );
  }
}