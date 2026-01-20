import 'package:flutter/material.dart';

class Booking extends StatefulWidget {
  const Booking({super.key});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  bool guide = false;
  int price = 1500000;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 50.0, left: 10),
        child: FloatingActionButton(
          mini: true,
          backgroundColor: Colors.white,
          elevation: 2,
          onPressed: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                Text(
                  "Isi Data Pemesan",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Pastikan data yang Anda isi valid agar kami dapat menghubungi Anda.",
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),

                const SizedBox(height: 40),

                Form(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Nama Lengkap",
                          prefixIcon: const Icon(Icons.person_outline),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.blue),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      TextFormField(
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: "Nomor WhatsApp / Telepon",
                          hintText: "0812xxxx",
                          prefixIcon: const Icon(Icons.phone_android),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Colors.blue),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Butuh Pemandu Wisata?", style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            
                          ),
                          ),
                          ElevatedButton(style: ElevatedButton.styleFrom(
                            backgroundColor: guide ? Colors.blue[800] : Colors.grey[300],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ), onPressed: () {
                            setState(() {
                              guide = !guide;
                              if (guide) {
                                price += 500000;
                              } else {
                                price -= 500000;
                              }
                            });
                          }, child: Text(guide ? "Ya" : "Tidak", style: TextStyle(color: guide ? Colors.white : Colors.black),))
                        ],
                      ),
                      const SizedBox(height: 40),

                      SizedBox(
                        width: double.infinity,
                        height: 55,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue[800],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 5,
                            shadowColor: Colors.blue.withOpacity(0.3),
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Pemesanan diproses..."),
                              ),
                            );
                          },
                          child: const Text(
                            "Pesan Sekarang",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
    );
  }
}