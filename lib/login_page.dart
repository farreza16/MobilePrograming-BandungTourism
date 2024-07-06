import 'package:flutter/material.dart';
import 'package:nuranisah_uts/home_page.dart'; // Import halaman utama aplikasi

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Mendapatkan informasi ukuran layar
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/back.jpg'), // Gambar latar belakang
            fit: BoxFit.cover, // Gambar dipasangkan dengan layar
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: screenSize.width * 0.1, // Margin horizontal responsif
                vertical: screenSize.height * 0.1, // Margin vertikal responsif
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: screenSize.height * 0.05), // Padding responsif
                  Icon(
                    Icons.local_florist,
                    size: screenSize.width * 0.2, // Ukuran ikon responsif
                    color: Color.fromARGB(255, 6, 196, 230),
                  ),
                  SizedBox(height: screenSize.height * 0.03), // Padding responsif
                  Text(
                    'Bandung Kota Kembang',
                    style: TextStyle(
                      fontSize: screenSize.width * 0.05, // Ukuran teks responsif
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 3, 2, 2),
                    ),
                  ),
                  SizedBox(height: screenSize.height * 0.05), // Padding responsif
                  Container(
                    padding: EdgeInsets.all(screenSize.width * 0.05), // Padding responsif
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5), // Warna hitam dengan opacity 0.5
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            prefixIcon: Icon(Icons.person, color: Colors.white),
                            labelStyle: TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Username harus diisi';
                            } else if (value != 'anisah') {
                              return 'Username tidak valid';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: screenSize.height * 0.02), // Padding responsif
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock, color: Colors.white),
                            labelStyle: TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),
                          style: TextStyle(color: Colors.white),
                          obscureText: true, // Sembunyikan teks
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password harus diisi';
                            } else if (value != 'anisah') {
                              return 'Password tidak valid';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: screenSize.height * 0.02), // Padding responsif
                        ElevatedButton(
                          onPressed: () {
                            if (_usernameController.text == 'anisah' &&
                                _passwordController.text == 'anisah') {
                              // Tambahkan logika autentikasi di sini
                              // Contoh: Navigasi ke halaman utama setelah login
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => HomePage()),
                              );
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Login Gagal'),
                                    content: Text('Username atau Password tidak valid.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('OK'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          child: Text('Login'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.025), // Padding responsif
                            minimumSize: Size(double.infinity, screenSize.height * 0.08), // Ukuran tombol responsif
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
