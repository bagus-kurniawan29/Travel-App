import 'package:flutter/material.dart';
import 'package:travel_app/screens/booking.dart'; // Import agar listTiketPemesanan terbaca
import 'package:travel_app/screens/ticket.dart';
import 'package:travel_app/database/database.dart';

class DaftarTicket extends StatefulWidget {
  const DaftarTicket({super.key});

  @override
  State<DaftarTicket> createState() => _DaftarTicketState();
}

class _DaftarTicketState extends State<DaftarTicket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Daftar Ticket",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: DatabaseHelper().queryAllTickets(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Belum ada tiket yang dipesan"));
          }

          final daftarTiketSql = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: daftarTiketSql.length,
            itemBuilder: (context, index) {
              final item = daftarTiketSql[index];

              // Menggunakan method factory yang kamu buat
              final data = TicketData.ticketdatabase(item);

              return Card(
                color: Colors.white,
                elevation: 3,
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(13),
                  leading: const CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.confirmation_number, color: Colors.white),
                  ),
                  title: Text(
                    data.nama,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "ID: ${data.id}\n${data.jumlah} Orang • IDR ${data.total}\n${data.tanggalPemesanan.toLocal().toString().split(' ')[0]}",
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => Ticket(ticket: data),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}