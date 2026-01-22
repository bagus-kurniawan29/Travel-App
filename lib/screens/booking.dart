import 'package:flutter/material.dart';
import 'package:travel_app/screens/ticket.dart';
import 'dart:math';
import 'package:travel_app/database/database.dart';


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

  Map<String, dynamic> databaseticket() {
    return {
      'id': id,
      'nama': nama,
      'noTelp': noTelp,
      'jumlah': jumlah,
      'pemandu': pemandu,
      'total': total,
      'tanggalPemesanan': tanggalPemesanan.toIso8601String(),
    };
  }

  factory TicketData.ticketdatabase(Map<String, dynamic> map) {
    return TicketData(
      id: map['id'],
      nama: map['nama'],
      noTelp: map['noTelp'],
      jumlah: map['jumlah'],
      pemandu: map['pemandu'],
      total: map['total'],
      tanggalPemesanan: DateTime.parse(map['tanggalPemesanan']),
    );
  }
}

List<TicketData> ListTiketPemesanan = [];

class Booking extends StatefulWidget {
  
  final bool isDark;
  const Booking({super.key, required this.isDark});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  bool guide = false;
  int baseprice = 150000;
  int regularPrice = 200000;
  int count = 1;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  int calculateTotal() {
    int priceWithGuide = guide ? baseprice + 50000 : baseprice;
    return priceWithGuide * count;
  }

  String generateId() {
    const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ0123456789';
    return List.generate(
      6,
      (index) => chars[Random().nextInt(chars.length)],
    ).join();
  }

  @override
  Widget build(BuildContext context) {
    
    final bool isDark = widget.isDark;
    final Color textColor = isDark ? Colors.white : Colors.black;
    final Color subTextColor = isDark ? Colors.white70 : Colors.grey[600]!;

    return Scaffold(
      
      backgroundColor: isDark ? Colors.grey[900] : Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 50.0, left: 10),
        child: FloatingActionButton(
          mini: true,
          backgroundColor: isDark ? Colors.grey[800] : Colors.white,
          elevation: 2,
          onPressed: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back, color: textColor),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 105),
                const Text(
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
                  style: TextStyle(color: subTextColor, fontSize: 14),
                ),
                const SizedBox(height: 40),
                Form(
                  child: Column(
                    children: [
                      
                      TextFormField(
                        controller: nameController,
                        style: TextStyle(color: textColor),
                        decoration: _inputStyle(
                          "Nama Lengkap",
                          Icons.person_outline,
                          isDark,
                        ),
                      ),
                      const SizedBox(height: 20),
                      
                      TextFormField(
                        controller: phoneController,
                        style: TextStyle(color: textColor),
                        keyboardType: TextInputType.phone,
                        decoration: _inputStyle(
                          "Nomor WhatsApp / Telepon",
                          Icons.phone_android,
                          isDark,
                        ),
                      ),
                      const SizedBox(height: 25),
                      
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Jumlah Pengunjung',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: textColor,
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
                                  onPressed:
                                      () => setState(() {
                                        if (count > 1) count--;
                                      }),
                                  icon: const Icon(
                                    Icons.remove_circle_outline,
                                    color: Colors.blue,
                                  ),
                                ),
                                Text(
                                  count.toString(),
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                IconButton(
                                  onPressed:
                                      () => setState(() {
                                        count++;
                                      }),
                                  icon: const Icon(
                                    Icons.add_circle_outline,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _guideButton(
                            false,
                            "Tanpa Pemandu",
                            Icons.person,
                            isDark,
                          ),
                          _guideButton(
                            true,
                            "Dengan Pemandu",
                            Icons.flag,
                            isDark,
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      Divider(
                        color: isDark ? Colors.grey[700] : Colors.grey[300],
                        thickness: 1,
                      ),
                      const SizedBox(height: 15),
                      
                      _priceRow(
                        "Pengunjung:",
                        "+${baseprice * count}",
                        subTextColor,
                      ),
                      _priceRow(
                        guide ? "Pemandu wisata:" : "Tanpa Pemandu:",
                        guide ? "+50.000" : "0",
                        subTextColor,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Harga:",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: textColor,
                            ),
                          ),
                          Text(
                            "Rp ${calculateTotal().toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                
                ElevatedButton(
                  onPressed: () async {
                    if (nameController.text.isEmpty ||
                        phoneController.text.isEmpty) {
                      _showSnackBar("Harap isi semua data pemesan");
                      return;
                    }
                    final ticket = TicketData(
                      id: generateId(),
                      nama: nameController.text,
                      noTelp: phoneController.text,
                      jumlah: count,
                      pemandu: guide ? "iya" : "tidak",
                      total: calculateTotal().toString(),
                      tanggalPemesanan: DateTime.now(),
                    );
                    try {
                      await DatabaseHelper().insertTicket(
                        ticket.databaseticket(),
                      );
                      if (mounted) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => Ticket(ticket: ticket, isDark: isDark),
                          ),
                        );
                      }
                    } catch (e) {
                      _showSnackBar("Gagal simpan database: $e");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 55),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    "Pesan Sekarang",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  

  InputDecoration _inputStyle(String label, IconData icon, bool isDark) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: isDark ? Colors.white70 : Colors.grey),
      prefixIcon: Icon(icon, color: isDark ? Colors.blue : Colors.grey),
      filled: true,
      fillColor: isDark ? Colors.grey[850] : Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: isDark ? Colors.grey[700]! : Colors.grey.shade300,
        ),
      ),
    );
  }

  Widget _guideButton(bool isActive, String label, IconData icon, bool isDark) {
    bool selected = guide == isActive;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(140, 100),
        backgroundColor:
            selected
                ? Colors.blueAccent
                : (isDark ? Colors.grey[800] : Colors.grey[200]),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      onPressed: () => setState(() => guide = isActive),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color:
                selected
                    ? Colors.white
                    : (isDark ? Colors.white70 : Colors.black),
            size: 28,
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color:
                  selected
                      ? Colors.white
                      : (isDark ? Colors.white70 : Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _priceRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: color)),
          Text(
            value,
            style: TextStyle(color: color, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
