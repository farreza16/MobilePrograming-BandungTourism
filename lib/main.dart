// main.dart

import 'package:flutter/material.dart';
import 'package:nuranisah_uts/login_page.dart';
import 'package:provider/provider.dart';
import 'package:nuranisah_uts/transaction_provider.dart'; // Import the TransactionProvider

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TransactionProvider()), // Provide TransactionProvider
      ],
      child: MaterialApp(
        title: 'Bandung Tourism',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoginPage(),
      ),
    );
  }
}
