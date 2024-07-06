import 'package:flutter/material.dart';
import 'package:nuranisah_uts/history_page.dart';
import 'package:nuranisah_uts/destination_detail_page.dart';
import 'package:nuranisah_uts/profile_page.dart';

class Destination {
  final String title;
  final String description;
  final String imagePath;
  final String location;
  final String ticketPrice;

  Destination({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.location,
    required this.ticketPrice,
  });
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Destination> destinations;
  late List<Destination> filteredDestinations;

  @override
  void initState() {
    super.initState();
    destinations = [
      Destination(
        title: 'Taman Hutan Raya Ir. H. Djuanda',
        description:
            'Taman hutan raya dengan luas 590 hektar yang menawarkan keindahan alam Bandung.',
        imagePath: 'assets/bandung1.jpg',
        location:
            'Jl. Ir. H. Djuanda No.99, Ciburial, Kec. Cimenyan, Bandung, Jawa Barat 40198',
        ticketPrice: 'Rp 20.000',
      ),
      Destination(
        title: 'Farmhouse Lembang',
        description:
            'Suasana pedesaan Eropa dengan berbagai spot foto yang instagramable.',
        imagePath: 'assets/bandung2.jpg',
        location:
            'Jl. Raya Lembang No.108, Gudangkahuripan, Lembang, Kabupaten Bandung Barat, Jawa Barat 40391',
        ticketPrice: 'Rp 25.000',
      ),
      Destination(
        title: 'Kawah Putih Ciwidey',
        description:
            'Danau kawah dengan air berwarna putih kehijauan yang terkenal karena keindahan alamnya.',
        imagePath: 'assets/bandung3.jpg',
        location:
            'Jl. Raya Soreang - Ciwidey, Kertawangi, Kec. Ciwidey, Bandung, Jawa Barat 40973',
        ticketPrice: 'Rp 50.000',
      ),
      Destination(
        title: 'Tebing Keraton',
        description:
            'Menawarkan pemandangan alam yang menakjubkan, terutama saat matahari terbenam.',
        imagePath: 'assets/bandung4.jpg',
        location:
            'Jl. Raya Punclut No.502, Ciumbuleuit, Kec. Cidadap, Kota Bandung, Jawa Barat 40198',
        ticketPrice: 'Gratis',
      ),
      Destination(
        title: 'Gedung Sate',
        description:
            'Ikonya arsitektur Bandung dengan nilai sejarah yang tinggi.',
        imagePath: 'assets/bandung5.jpg',
        location:
            'Jl. Diponegoro No.22, Citarum, Kec. Bandung Wetan, Kota Bandung, Jawa Barat 40115',
        ticketPrice: 'Rp 10.000',
      ),
      Destination(
        title: 'Ranca Upas',
        description:
            'Sebuah camping ground, dengan fasilitas yang cukup lengkap seperti kamar mandi umum dan sarana beribadah Mesjid. Juga terdapat arena outbound dan penyewaan kendaraan ATV. ',
        imagePath: 'assets/bandung6.jpg',
        location:
            'Jl. Raya Ciwidey - Patengan, Patengan, Kec. Rancabali, Bandung, Jawa Barat 40973',
        ticketPrice: 'Rp 25.000',
      ),
    ];
    filteredDestinations = destinations;
  }

  void filterDestinations(String query) {
    setState(() {
      filteredDestinations = destinations.where((destination) {
        final titleLower = destination.title.toLowerCase();
        final descriptionLower = destination.description.toLowerCase();
        final searchLower = query.toLowerCase();

        return titleLower.contains(searchLower) ||
            descriptionLower.contains(searchLower);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MAIN MENU',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0D47A1), Color(0xFF42A5F5)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 16.0),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Cari destinasi wisata',
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                  hintStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.3),
                ),
                style: TextStyle(color: Colors.white),
                onChanged: (value) => filterDestinations(value),
              ),
              SizedBox(height: 16.0),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredDestinations.length,
                  itemBuilder: (context, index) {
                    return buildDestinationCard(
                        context, filteredDestinations[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CircleIconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HistoryPage()),
                );
              },
              icon: Icon(Icons.history, color: Colors.white),
              tooltip: 'Histori Pembelian',
            ),
            CircleIconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
              icon: Icon(Icons.account_circle, color: Colors.white),
              tooltip: 'Profil',
            ),
          ],
        ),
        color: Colors.blue,
      ),
    );
  }

  Widget buildDestinationCard(BuildContext context, Destination destination) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DestinationDetailPage(
              title: destination.title,
              description: destination.description,
              imagePath: destination.imagePath,
              location: destination.location,
              ticketPrice: destination.ticketPrice,
            ),
          ),
        );
      },
      child: Card(
        elevation: 4.0,
        margin: EdgeInsets.symmetric(vertical: 8.0),
        color: Colors.white.withOpacity(0.8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              destination.imagePath,
              fit: BoxFit.cover,
              height: 200,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    destination.title,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    destination.description,
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CircleIconButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Icon icon;
  final String tooltip;

  const CircleIconButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    required this.tooltip,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: ShapeDecoration(
          color: Colors.blue,
          shape: CircleBorder(),
        ),
        child: IconButton(
          onPressed: onPressed,
          icon: icon,
          tooltip: tooltip,
          color: Colors.white,
        ),
      ),
    );
  }
}
