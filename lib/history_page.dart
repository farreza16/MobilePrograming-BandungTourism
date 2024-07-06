import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nuranisah_uts/transaction_provider.dart';
import 'package:nuranisah_uts/transaction.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Transaction> transactions = Provider.of<TransactionProvider>(context).transactions;

    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0D47A1), Color(0xFF42A5F5)],
          ),
        ),
        child: ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(
                transactions[index].destinationTitle,
                style: TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                'Total Pembayaran: Rp ${transactions[index].totalPrice}',
                style: TextStyle(color: Colors.white),
              ),
              trailing: Text(
                '${transactions[index].selectedDate.day}/${transactions[index].selectedDate.month}/${transactions[index].selectedDate.year}',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                _showTransactionDetails(context, transactions[index]);
              },
            );
          },
        ),
      ),
    );
  }

  void _showTransactionDetails(BuildContext context, Transaction transaction) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.blue,
          title: Text(
            'Detail Transaksi',
            style: TextStyle(color: Colors.white),
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Pelanggan: ${transaction.customerName}',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                'Tujuan: ${transaction.destinationTitle}',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                'Alamat: ${transaction.destinationAddress}',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                'Harga Tiket: ${transaction.ticketPrice}',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                'Tanggal: ${transaction.selectedDate.day}/${transaction.selectedDate.month}/${transaction.selectedDate.year}',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                'Jumlah Tiket: ${transaction.ticketCount}',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                'Total Pembayaran: Rp ${transaction.totalPrice}',
                style: TextStyle(color: Colors.white),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Tutup pop-up
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      },
    );
  }
}
