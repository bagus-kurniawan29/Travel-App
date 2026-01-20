import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../widget/map_widget.dart';
import 'package:travel_app/screens/booking.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int selectedGuests = 1;
  DateTime selectedDate = DateTime.now();

  late AnimationController _controller;

  final List<String> _galleryImages = [
    'assets/img/rinjani 1.png',
    'assets/img/rinjani 2.jpg',
    'assets/img/rinjani 3.jpeg',
    'assets/img/rinjani 4.webp',
    'assets/img/rinjani 5.jpg',
  ];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 320.0,
                floating: false,
                pinned: true,
                backgroundColor: Colors.blue[800],
                flexibleSpace: FlexibleSpaceBar(
                  title: const Text(
                    "Gunung Rinjani",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      shadows: [Shadow(blurRadius: 10, color: Colors.black45)],
                    ),
                  ),
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        "assets/img/Rinjani.jpg",
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(color: Colors.grey);
                        },
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.transparent,
                              Colors.black.withOpacity(0.8),
                            ],
                            stops: const [0.0, 0.5, 1.0],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 120),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              "Open Trip",
                              style: TextStyle(
                                color: Colors.blue[800],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 18),
                              SizedBox(width: 4),
                              Text(
                                "4.9 (1.2k)",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildInfoItem(Icons.terrain, "3726 mdpl", "Tinggi"),
                          _buildInfoItem(Icons.thermostat, "32°C", "Suhu"),
                          _buildInfoItem(Icons.sunny, "Cerah", "Cuaca"),
                          _buildInfoItem(Icons.map, "Senaru", "Jalur"),
                        ],
                      ),

                      const SizedBox(height: 24),

                      const Text(
                        "Tentang Destinasi",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Pendakian Gunung Rinjani via Senaru adalah rute favorit untuk menikmati pemandangan Danau Segara Anak dari bibir kawah. Jalur ini melewati hutan hujan tropis yang lebat.",
                        style: TextStyle(color: Colors.grey[600], height: 1.5),
                      ),

                      const SizedBox(height: 30),

                      const Text(
                        "Galeri Momen",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "tangkap dan abadikan moment berharga anda",
                        style: TextStyle(color: Colors.grey[600], height: 1.5),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 300,
                        child: AnimatedBuilder(
                          animation: _controller,
                          builder: (context, child) {
                            return Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.blue.withOpacity(0.1),
                                    border: Border.all(
                                      color: Colors.blue.withOpacity(0.3),
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.blue[800],
                                  ),
                                ),
                                ..._buildOrbitingGalleryItems(context),
                              ],
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 23),

                      const Text(
                        "Lokasi & Rute",
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        "Rute otomatis dari lokasi Anda menuju Basecamp Senaru.",
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),

                      const SizedBox(height: 15),

                      SizedBox(
                        height: 300,
                        width: double.infinity,
                        child: const MapWidget(),
                      ),

                      const SizedBox(height: 20),

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          const Text(
                            "Apa Yang orang bilang tentang destinasi ini?",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Card(
                            shadowColor: Color(0xFFE0E0E0),
                            color: Colors.white,
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.blue,
                                child: Icon(Icons.person, color: Colors.white),
                              ),
                              title: Text(
                                "Andi Pratama",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                "Pendakian yang menantang namun sangat memuaskan! Pemandangan dari puncak luar biasa.",
                              ),
                            ),
                          ),
                          const Card(
                            shadowColor: Color(0xFFE0E0E0),
                            color: Colors.white,
                            margin: EdgeInsets.symmetric(vertical: 8),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.blue,
                                child: Icon(Icons.person, color: Colors.white),
                              ),
                              title: Text(
                                "Bayu Prayoga",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                "Pupuk lengkap mantap bisa menumbuhkan segala macam batang whahahaha",
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 50),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Mulai dari",
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          "IDR 150K",
                          style: TextStyle(
                            color: Colors.blue[800],
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Booking()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 14,
                      ),
                    ),
                    child: const Text(
                      "Booking",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildOrbitingGalleryItems(BuildContext context) {
    final List<Widget> items = [];
    final int count = _galleryImages.length;

    final double screenWidth = MediaQuery.of(context).size.width;
    final double radius = screenWidth * 0.35;

    for (int i = 0; i < count; i++) {
      final double baseAngle = (2 * math.pi * i) / count;
      final double currentAngle = baseAngle + (_controller.value * 2 * math.pi);

      final double x = radius * math.cos(currentAngle);
      final double y = (radius * 0.6) * math.sin(currentAngle);

      final double scale = 0.6 + (math.sin(currentAngle) + 1) * 0.2;

      items.add(
        Transform.translate(
          offset: Offset(x, y),
          child: Transform.scale(
            scale: scale,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  _galleryImages[i],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(Icons.broken_image, color: Colors.grey),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      );
    }
    return items;
  }

  Widget _buildInfoItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue[800], size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 10)),
      ],
    );
  }
}
