import 'package:flutter/material.dart';
import 'package:travel_app/screens/booking.dart';
import 'package:travel_app/screens/main_screen.dart';
import 'package:travel_app/l10n/app_localizations.dart';

class Ticket extends StatelessWidget {
  final TicketData ticket;
  final bool isDark;
  
  
  final Function(bool) onToggle;
  final Function(String) onLangChange;

  const Ticket({
    super.key, 
    required this.ticket, 
    required this.isDark,
    
    required this.onToggle, 
    required this.onLangChange,
  });

  @override
  Widget build(BuildContext context) {
    var t = AppLocalizations.of(context)!;
    final Color cardColor = isDark ? Colors.grey[850]! : Colors.white;
    final Color textColor = isDark ? Colors.white : Colors.black87;
    final Color subTextColor = isDark ? Colors.white70 : Colors.grey;

    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : Colors.grey[100],
      appBar: AppBar(
        backgroundColor: isDark ? Colors.grey[900] : Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: textColor),
        title: Text("Order Ticket", style: TextStyle(color: textColor)),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                color: cardColor,
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
                          t.name,
                          ticket.nama,
                          Icons.person_outline,
                          isDark,
                        ),
                        const SizedBox(height: 16),
                        _buildTicketRow(
                          t.phoneNumber,
                          ticket.noTelp,
                          Icons.phone_android,
                          isDark,
                        ),
                        const SizedBox(height: 16),
                        _buildTicketRow(
                          "Orang",
                          "${ticket.jumlah} ${t.visitors}",
                          Icons.groups_outlined,
                          isDark,
                        ),
                        const SizedBox(height: 16),
                        _buildTicketRow(
                          t.withGuide,
                          ticket.pemandu == "iya" ? t.withGuide : t.withoutGuide,
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
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Jumlah",
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
                        Icon(
                          Icons.qr_code_2,
                          size: 80,
                          color: isDark ? Colors.white70 : Colors.black54,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          t.showTicket,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 10, color: subTextColor),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          String currentLang = Localizations.localeOf(context).languageCode;
                          
                          
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MainScreen(
                                onToggle: onToggle, 
                                onLangChange: onLangChange,
                                isDark: isDark,
                                currentLang: currentLang,
                              ),
                            ),
                            (route) => false,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          t.backHome,
                          style: const TextStyle(
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