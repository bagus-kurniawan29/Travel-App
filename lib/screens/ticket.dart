import 'package:flutter/material.dart';
import 'package:travel_app/screens/booking.dart';

class Ticket extends StatelessWidget {
  final TicketData ticket;
  final bool isDark; // Variabel harus final

  const Ticket({super.key, required this.ticket, required this.isDark});

  @override
  Widget build(BuildContext context) {
    // Definisi warna berdasarkan isDark
    final Color cardColor = isDark ? Colors.grey[850]! : Colors.white;
    final Color textColor = isDark ? Colors.white : Colors.black87;
    final Color subTextColor = isDark ? Colors.white70 : Colors.grey;

    return Scaffold(
      // PENTING: Gunakan 'isDark', bukan 'widget.isDark' karena ini StatelessWidget
      backgroundColor: isDark ? Colors.grey[900] : Colors.grey[100],
      appBar: AppBar(
        // Menyesuaikan AppBar dengan tema
        backgroundColor: isDark ? Colors.grey[900] : Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: textColor),
        title: Text("Tiket Pesanan", style: TextStyle(color: textColor)),
      ),
      body: Center(
        child: SingleChildScrollView(
          // Tambahkan ini agar tidak overflow di layar kecil
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                color: cardColor, // Warna kartu mengikuti mode
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDark ? 0.3 : 0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Header Biru (Tetap biru karena ini aksen tiket)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "BOOKING ID",
                          style: TextStyle(color: Colors.white70, fontSize: 10),
                        ),
                        Text(
                          ticket.id,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        _buildTicketRow(
                          "Nama Pemesan",
                          ticket.nama,
                          Icons.person_outline,
                          isDark,
                        ),
                        const SizedBox(height: 16),
                        _buildTicketRow(
                          "Nomor WhatsApp",
                          ticket.noTelp,
                          Icons.phone_android,
                          isDark,
                        ),
                        const SizedBox(height: 16),
                        _buildTicketRow(
                          "Jumlah Pengunjung",
                          "${ticket.jumlah} Orang",
                          Icons.groups_outlined,
                          isDark,
                        ),
                        const SizedBox(height: 16),
                        _buildTicketRow(
                          "Pemandu Wisata",
                          ticket.pemandu == "iya"
                              ? "Dengan Pemandu"
                              : "Tanpa Pemandu",
                          Icons.tour_outlined,
                          isDark,
                        ),
                        const SizedBox(height: 16),
                        _buildTicketRow(
                          "Tanggal Booking",
                          "${ticket.tanggalPemesanan.day}/${ticket.tanggalPemesanan.month}/${ticket.tanggalPemesanan.year}",
                          Icons.calendar_today,
                          isDark,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Divider(
                            color: isDark ? Colors.grey[700] : Colors.grey[300],
                            thickness: 1,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total Bayar",
                              style: TextStyle(
                                fontSize: 14,
                                color: subTextColor,
                              ),
                            ),
                            Text(
                              "Rp ${ticket.total}",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 30),
                        // QR Code Container
                        Container(
                          height: 80,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: isDark ? Colors.grey[800] : Colors.grey[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.qr_code_2,
                            size: 60,
                            color: isDark ? Colors.white70 : Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Tunjukkan tiket ini saat kedatangan",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 10, color: subTextColor),
                        ),
                      ],
                    ),
                  ),
                  // Tombol Kembali
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 20,
                      left: 24,
                      right: 24,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed:
                            () => Navigator.pop(
                              context,
                            ), // Cukup Pop saja agar tidak menumpuk stack
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Kembali Ke Beranda",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper Row yang mendukung Dark Mode
  Widget _buildTicketRow(
    String label,
    String value,
    IconData icon,
    bool isDark,
  ) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.blue, size: 20),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(color: Colors.grey, fontSize: 11),
            ),
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
