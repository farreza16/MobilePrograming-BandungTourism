import 'package:flutter/material.dart';
import 'package:nuranisah_uts/transaction_provider.dart';
import 'package:provider/provider.dart';
import 'package:nuranisah_uts/qris_page.dart';
import 'package:nuranisah_uts/transaction.dart';

class TransactionRecapPage extends StatelessWidget {
  final String destinationTitle;
  final String destinationAddress;
  final String ticketPrice;
  final DateTime selectedDate;
  final int ticketCount;
  final String customerName;

  const TransactionRecapPage({
    Key? key,
    required this.destinationTitle,
    required this.destinationAddress,
    required this.ticketPrice,
    required this.selectedDate,
    required this.ticketCount,
    required this.customerName, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int totalPrice = _calculateTotalPrice();

    // Mendapatkan informasi ukuran layar
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction Recap'),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenSize.width * 0.05), // Padding responsif
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Transaction Details:',
              style: TextStyle(fontSize: screenSize.width * 0.06, fontWeight: FontWeight.bold, color: Colors.indigo),
            ),
            SizedBox(height: screenSize.height * 0.02), // Padding responsif
            _buildDetailItem('Customer Name', customerName, screenSize),
            _buildDetailItem('Destination', destinationTitle, screenSize),
            _buildDetailItem('Address', destinationAddress, screenSize),
            _buildDetailItem('Ticket Price', ticketPrice, screenSize),
            _buildDetailItem('Date', '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}', screenSize),
            _buildDetailItem('Ticket Count', ticketCount.toString(), screenSize),
            SizedBox(height: screenSize.height * 0.04), // Padding responsif
            Text(
              'Total Price:',
              style: TextStyle(fontSize: screenSize.width * 0.06, fontWeight: FontWeight.bold, color: Colors.indigo),
            ),
            Text(
              'Rp $totalPrice',
              style: TextStyle(fontSize: screenSize.width * 0.07, color: Colors.green, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: screenSize.height * 0.06), // Padding responsif
            ElevatedButton(
              onPressed: () {
                Provider.of<TransactionProvider>(context, listen: false).addTransaction(
                  Transaction(
                    destinationTitle: destinationTitle,
                    destinationAddress: destinationAddress,
                    ticketPrice: ticketPrice,
                    selectedDate: selectedDate,
                    ticketCount: ticketCount,
                    customerName: customerName,
                  ),
                );

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QRISPage(
                      totalPrice: totalPrice,
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.08, vertical: screenSize.height * 0.02), // Padding responsif
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(screenSize.width * 0.03), // BorderRadius responsif
                ),
              ),
              child: Text(
                'Bayar Sekarang',
                style: TextStyle(fontSize: screenSize.width * 0.05, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String title, String value, Size screenSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: screenSize.width * 0.04, fontWeight: FontWeight.bold, color: Colors.indigo),
        ),
        SizedBox(height: screenSize.height * 0.01), // Padding responsif
        Text(
          value,
          style: TextStyle(fontSize: screenSize.width * 0.035),
        ),
        SizedBox(height: screenSize.height * 0.015), // Padding responsif
      ],
    );
  }

  int _calculateTotalPrice() {
    int price = _parseTicketPrice(ticketPrice);
    return price * ticketCount;
  }

  int _parseTicketPrice(String ticketPrice) {
    String cleanTicketPrice = ticketPrice.replaceAll('Rp ', '').replaceAll('.', '');
    return int.tryParse(cleanTicketPrice) ?? 0;
  }
}
