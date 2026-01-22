import 'package:flutter/material.dart';
import 'package:travel_app/screens/booking.dart';
import 'package:travel_app/screens/ticket.dart';
import 'package:travel_app/database/database.dart';

class DaftarTicket extends StatefulWidget {
  const DaftarTicket({super.key, required this.isDark});
  final bool isDark;

  @override
  State<DaftarTicket> createState() => _DaftarTicketState();
}

class _DaftarTicketState extends State<DaftarTicket> {
  @override
  Widget build(BuildContext context) {
    // Definisi warna berdasarkan isDark agar kode lebih bersih
    final bool isDark = widget.isDark;
    final Color textColor = isDark ? Colors.white : Colors.black;
    final Color subTextColor = isDark ? Colors.white70 : Colors.black54;
    final Color cardColor = isDark ? Colors.grey[850]! : Colors.white;

    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : Colors.grey[100],
      appBar: AppBar(
        // Sesuaikan AppBar dengan mode tema
        backgroundColor: isDark ? Colors.black : Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: textColor),
        title: Text(
          "Daftar Ticket",
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: DatabaseHelper().queryAllTickets(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error: ${snapshot.error}",
                style: TextStyle(color: textColor),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                "Belum ada tiket yang dipesan",
                style: TextStyle(color: subTextColor),
              ),
            );
          }

          final daftarTiketSql = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: daftarTiketSql.length,
            itemBuilder: (context, index) {
              final item = daftarTiketSql[index];
              final data = TicketData.ticketdatabase(item);

              return Card(
                color: cardColor, // Warna kartu mengikuti mode
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
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor, // Warna teks judul
                    ),
                  ),
                  subtitle: Text(
                    "ID: ${data.id}\n${data.jumlah} Orang • IDR ${data.total}\n${data.tanggalPemesanan.toLocal().toString().split(' ')[0]}",
                    style: TextStyle(
                      color: subTextColor,
                    ), // Warna teks subtitle
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: subTextColor,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        // Kirim juga parameter isDark ke halaman detail Ticket
                        builder: (_) => Ticket(ticket: data, isDark: isDark),
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
