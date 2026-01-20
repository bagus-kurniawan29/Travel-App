import 'package:flutter/material.dart';
import 'package:travel_app/screens/booking.dart'; // Import agar listTiketPemesanan terbaca
import 'package:travel_app/screens/ticket.dart';

class DaftarTicket extends StatelessWidget {
  const DaftarTicket({super.key});

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
          style: TextStyle(color: Colors.black),
        ),
      ),
      body:
          ListTiketPemesanan.isEmpty
              ? const Center(child: Text("Belum ada tiket yang dipesan"))
              : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: ListTiketPemesanan.length,
                itemBuilder: (context, index) {
                  final data = ListTiketPemesanan[index];
                  return Card(
                    color: Colors.white,
                    elevation: 3,
                    margin: const EdgeInsets.only(bottom: 10),
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(13),
                      leading: const CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Icon(
                          Icons.confirmation_number,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        data.nama,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text("ID: ${data.id}\n${data.jumlah} Orang \n${data.total} \n${data.tanggalPemesanan.toLocal().toString().split(' ')[0]}"),
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
              ),
    );
  }
}
