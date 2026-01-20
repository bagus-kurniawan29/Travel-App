import 'package:flutter/material.dart';
import 'package:travel_app/screens/ticket.dart';
import 'dart:math';

class TicketData {
  final String id;
  final String nama;
  final String noTelp;
  final int jumlah;
  final String pemandu;
  final String total;
  final DateTime tanggalPemesanan;

  TicketData({
    required this.id,
    required this.nama,
    required this.noTelp,
    required this.jumlah,
    required this.pemandu,
    required this.total,
    required this.tanggalPemesanan,
  });
}

// ignore: non_constant_identifier_names
List<TicketData> ListTiketPemesanan = [];

class Booking extends StatefulWidget {
  const Booking({super.key});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  bool guide = false;
  int price = 150000;
  int baseprice = 150000;
  int regularPrice = 200000;
  int count = 1;
  int calculateTotal() {
    int priceWithGuide = guide ? baseprice + 50000 : baseprice;
    return priceWithGuide * count;
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String generateId() {
    const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ0123456789';
    return List.generate(
      6,
      (index) => chars[Random().nextInt(chars.length)],
    ).join();
  }

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
                    color: Colors.blue,
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
                        controller: nameController,
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
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: "Nomor WhatsApp / Telepon",
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
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Jumlah Pengunjung',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue),
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    if (count > 1) {
                                      setState(() {
                                        count--;
                                      });
                                    }
                                  },
                                  icon: const Icon(Icons.remove_circle_outline),
                                  color: Colors.blue,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  count.toString(),
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(width: 8),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      count++;
                                    });
                                  },
                                  icon: Icon(Icons.add_circle_outline),
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(100, 100),
                                  backgroundColor:
                                      !guide
                                          ? Colors.blueAccent
                                          : Colors.grey[300],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    guide = false;
                                    price = baseprice;
                                  });
                                },

                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.person,
                                      color:
                                          !guide ? Colors.white : Colors.black,
                                      size: 25,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "Tanpa Pemandu",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color:
                                            !guide
                                                ? Colors.white
                                                : Colors.black,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    guide = true;
                                    price = regularPrice;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(100, 100),
                                  backgroundColor:
                                      guide
                                          ? Colors.blueAccent
                                          : Colors.grey[300],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.flag,
                                      color:
                                          guide ? Colors.white : Colors.black,
                                      size: 25,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "Dengan Pemandu",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color:
                                            guide ? Colors.white : Colors.black,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 40),
                          Divider(color: Colors.grey[300], thickness: 1),
                          const SizedBox(height: 7),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Pengunjung:"),
                              Text(
                                "+${baseprice * count}".replaceAllMapped(
                                  RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                  (Match m) => '${m[1]}.',
                                ),
                                style: const TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                guide
                                    ? "Pemandu wisata:"
                                    : "tanpa Pemandu Wisata:",
                                style: TextStyle(color: Colors.grey[800]),
                              ),
                              Text(
                                guide ? "+50.000" : "0",
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Total Harga:",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Rp ${calculateTotal().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    if (nameController.text.isEmpty ||
                        phoneController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Harap isi semua data pemesan"),
                        ),
                      );
                      return;
                    }
                    final ticket = TicketData(
                      id: generateId(),
                      nama: nameController.text,
                      noTelp: phoneController.text,
                      jumlah: count,
                      pemandu: guide ? "iya" : "tidak",
                      total: calculateTotal().toString().replaceAllMapped(
                        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                        (Match m) => '${m[1]}.',
                      ),
                      tanggalPemesanan: DateTime.now(),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => Ticket(ticket: ticket)),
                    );
                    setState(() {
                      ListTiketPemesanan.add(ticket);
                    });
                  },

                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "Pesan Sekarang",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
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
