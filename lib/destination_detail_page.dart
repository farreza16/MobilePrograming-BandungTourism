import 'package:flutter/material.dart';
import 'package:nuranisah_uts/transcation_page.dart';
import 'package:url_launcher/url_launcher.dart';

class DestinationDetailPage extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final String location;
  final String ticketPrice;

  const DestinationDetailPage({
    Key? key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.location,
    required this.ticketPrice,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  height: 300,
                ),
                Container(
                  padding: EdgeInsets.all(16.0),
                  color: Colors.black.withOpacity(0.4),
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Deskripsi',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Divider(),
                  SizedBox(height: 16.0),
                  Text(
                    'Alamat:',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    location,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  const Text(
                    'Harga Tiket:',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    ticketPrice,
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TransactionPage(
                      destinationTitle: title,
                      ticketPrice: ticketPrice,
                      destinationAddress: location,
                      customerName: '',
                    ),
                  ),
                );
              },
              icon: Icon(Icons.shopping_cart),
              label: Text('Pesan Tiket Sekarang'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                _launchMapsUrl(location);
              },
              icon: Icon(Icons.map),
              label: Text('Buka Maps'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
              ),
            ),
          ],
        ),
        color: Colors.transparent,
      ),
    );
  }

  void _launchMapsUrl(String location) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$location';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
