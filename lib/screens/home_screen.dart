import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travel_app/screens/Test.dart';
import 'package:travel_app/widget/destination_card.dart';
import 'dart:async';
import 'package:travel_app/widget/detail_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // 1. Definisikan Controller
  final PageController _pageController = PageController(viewportFraction: 0.99);
  Timer? _timer;
  int _currentPage = 0;
  final List<String> _galleryImages = [
    'assets/img/desa adat bele.png',
    'assets/img/air terjun tiu ngumbak.webp',
    'assets/img/masjid adat gumantar.jpg',
  ];
  final LatLng _tujuan = const LatLng(-8.2877237, 116.2954221);
  Set<Polyline> _polylines = {};
  void buatRute() async {
    Position pos = await Geolocator.getCurrentPosition();
    PolylinePoints polylinePoints = PolylinePoints();

    // FORMAT BARU: Gunakan nama parameter (Named Arguments)
    PolylineRequest request = PolylineRequest(
      origin: PointLatLng(pos.latitude, pos.longitude),
      destination: PointLatLng(_tujuan.latitude, _tujuan.longitude),
      mode: TravelMode.driving,
      // Masukkan API Key kamu di sini
    );

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleApiKey:
          "AIzaSyCxmPiVRwyPQwuo1gxi4SpWeCa0xT359Rg", // Pakai googleApiKey:
      request: request,
    );

    if (result.points.isNotEmpty) {
      List<LatLng> titikGaris =
          result.points.map((p) => LatLng(p.latitude, p.longitude)).toList();

      setState(() {
        _polylines.add(
          Polyline(
            polylineId: const PolylineId("rute_wisata"),
            points: titikGaris,
            color: Colors.blue,
            width: 5,
          ),
        );
      });
    } else {
      print("gagal mengambil rute ${result.errorMessage}");
    }
  }

  Widget _buildGalleryItem(String path) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          path,
          fit: BoxFit.cover,
          errorBuilder:
              (context, error, stackTrace) => Container(
                color: Colors.grey[300],
                child: const Icon(Icons.broken_image),
              ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < _galleryImages.length - 1) {
        _currentPage++;
      } else {}

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const TextField(
                            decoration: InputDecoration(
                              icon: Icon(Icons.search, color: Colors.grey),
                              border: InputBorder.none,
                              hintText: 'Cari destinasi...',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 5),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.person, color: Colors.white),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TestScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Top 3 Destinasi Populer',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 280,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      children: [
                        DestinationCard(
                          imagepath: 'assets/img/desa adat bele.png',
                          name: 'Desa Adat Bele',
                          location: 'Lombok utara',
                          price: 'Rp 1.500.000',
                          rating: 4.9,
                          onTap: () {
                            Navigator.of(context, rootNavigator: true).push(
                              MaterialPageRoute(
                                builder:
                                    (context) => const DetailWidget(
                                      judul: "Desa Adat Gumantar",
                                      lokasi: "Lombok Utara, NTB",
                                      imagePath:
                                          "assets/img/desa adat bele.png",
                                      harga: "Rp 1.500.000",
                                      rating: 4.9,
                                      deskripsi:
                                          "Desa Adat Gumantar, terletak di Kecamatan Kayangan, Lombok Utara, adalah salah satu kampung kuno tertua di Lombok (sejak 1257) yang melestarikan arsitektur dan adat Sasak. Terkenal dengan Dusun Beleq, desa ini memiliki 40+ rumah adat tahan gempa dari bambu dan atap jerami. Desa ini menyuguhkan wisata budaya, sejarah, dan lingkungan asri. ",
                                    ),
                              ),
                            );
                          },
                        ),
                        DestinationCard(
                          imagepath: 'assets/img/masjid adat gumantar.jpg',
                          name: 'Masjid Adat Gumantar',
                          location: 'Lombok utara',
                          price: 'Rp 2.000.000',
                          rating: 4.7,
                          onTap: () {
                            Navigator.of(context, rootNavigator: true).push(
                              MaterialPageRoute(
                                builder:
                                    (context) => const DetailWidget(
                                      judul: "Masjid Adat \nGumantar",
                                      lokasi: "Kabupaten Lombok Utara",
                                      deskripsi: "Masjid Kuno Gumantar merupakan salah satu masjid kuno tertua di pulau Lombok, Nusa Tenggara Barat (NTB) dan merupakan salah dari dua Masjid tertua di kabupaten Lombok utara selain Masjid Bayan Beleq. Keberadaan Masjid Kuno ini diperkirakan berkaitan dengan masa awal penyebaran Agama Islam di Pulau Lombok sekitar abad ke 17 Masehi.",
                                      harga: "Rp 2.000.000",
                                      imagePath: "assets/img/masjid adat gumantar.jpg",
                                      rating: 4.7,
                                    ),
                              ),
                            );
                          },
                        ),
                        DestinationCard(
                          imagepath: 'assets/img/air terjun tiu ngumbak.webp',
                          name: 'Air Terjun Tiu umbak',
                          location: 'Lombok Utara',
                          price: 'Rp 1.200.000',
                          rating: 4.5,
                          onTap: () {
                            print("Tapped on Air Terjun Tiu Ngumbak");
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        'Rekomendasi Untuk Anda',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Container(
                          width: screenWidth * 0.9,
                          height: 250,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(25),
                                child: Image.asset(
                                  'assets/img/air terjun tiu ngumbak.webp',
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.vertical(
                                      bottom: Radius.circular(25),
                                    ),
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.black.withOpacity(0.9),
                                        Colors.transparent,
                                      ],
                                      begin: Alignment.bottomCenter,
                                      end: Alignment.topCenter,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Air terjun tiuk umbaq",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            "Rp 1.200.000",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.blue,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                            child: const Text(
                                              "Explore",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Galeri",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15),
                      SizedBox(
                        height: 200,
                        child: PageView.builder(
                          controller:
                              _pageController, // Gunakan controller yang ada timernya
                          itemCount: _galleryImages.length,
                          itemBuilder: (context, index) {
                            return _buildGalleryItem(_galleryImages[index]);
                          },
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "Peta",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 300,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: GoogleMap(
                            initialCameraPosition: CameraPosition(
                              target: _tujuan,
                              zoom: 40,
                            ),
                            myLocationButtonEnabled: true,
                            polylines: _polylines,
                            markers: {
                              Marker(
                                markerId: const MarkerId("Tujuan"),
                                position: _tujuan,
                              ),
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
