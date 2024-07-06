// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:nuranisah_uts/transcation_recap_page.dart'; // Import halaman Transaction Recap

class TransactionPage extends StatefulWidget {
  final String destinationTitle;
  final String destinationAddress;
  final String ticketPrice;
  final String customerName; // Tambahkan properti customerName

  const TransactionPage({
    Key? key,
    required this.destinationTitle,
    required this.destinationAddress,
    required this.ticketPrice,
    required this.customerName, // Tambahkan customerName ke constructor
  }) : super(key: key);

  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  late DateTime _selectedDate = DateTime.now();
  int _ticketCount = 1;
  late String _customerName = ''; // Tambahkan variabel _customerName

  @override
  Widget build(BuildContext context) {
    int price = _parseTicketPrice(widget.ticketPrice);

    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nama Destinasi: ${widget.destinationTitle}',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Alamat: ${widget.destinationAddress}',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Harga Tiket:',
                  style: TextStyle(fontSize: 18.0),
                ),
                Text(
                  widget.ticketPrice,
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tanggal Pemesanan:',
                  style: TextStyle(fontSize: 18.0),
                ),
                Text(
                  '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                  style: TextStyle(fontSize: 18.0),
                ),
                IconButton(
                  onPressed: () {
                    _selectDate(context);
                  },
                  icon: Icon(Icons.calendar_today),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Jumlah Tiket:',
                  style: TextStyle(fontSize: 18.0),
                ),
                DropdownButton<int>(
                  value: _ticketCount,
                  onChanged: (value) {
                    setState(() {
                      _ticketCount = value!;
                    });
                  },
                  items: List.generate(10, (index) => index + 1)
                      .map<DropdownMenuItem<int>>((int value) {
                    return DropdownMenuItem<int>(
                      value: value,
                      child: Text(value.toString()),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Harga:',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Rp ${price * _ticketCount}',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            BookingForm(
              onTap: _navigateToTransactionRecap,
              onNameChanged: (value) {
                _customerName = value; // Tangkap nilai nama dari form
              },
            ),
          ],
        ),
      ),
    );
  }

  int _parseTicketPrice(String ticketPrice) {
    String cleanTicketPrice = ticketPrice.replaceAll('Rp ', '').replaceAll('.', '');
    return int.tryParse(cleanTicketPrice) ?? 0;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _navigateToTransactionRecap() {
    if (_customerName.isNotEmpty) { // Periksa apakah nama tidak kosong
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TransactionRecapPage(
            destinationTitle: widget.destinationTitle,
            destinationAddress: widget.destinationAddress,
            ticketPrice: widget.ticketPrice,
            selectedDate: _selectedDate,
            ticketCount: _ticketCount,
            customerName: _customerName,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Nama tidak boleh kosong'), // Tampilkan pesan jika nama kosong
        ),
      );
    }
  }
}

class BookingForm extends StatelessWidget {
  final VoidCallback onTap;
  final ValueChanged<String> onNameChanged; // Tambahkan properti onNameChanged

  const BookingForm({Key? key, required this.onTap, required this.onNameChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Form Pemesanan',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),
        TextFormField(
          onChanged: onNameChanged, // Panggil callback saat nilai berubah
          decoration: InputDecoration(
            labelText: 'Atas Nama',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16.0),
        Text(
          'Pembayaran hanya via QRIS BCA',
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16.0),
        Center(
          child: ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              minimumSize: Size(300, 50),
              backgroundColor: Color.fromARGB(255, 0, 61, 228),
            ),
            child: Text(
              'Pesan Sekarang',
              style: TextStyle(
                color: Color.fromRGBO(242, 243, 237, 1),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
