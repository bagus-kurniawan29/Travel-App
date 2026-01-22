import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  final bool isDark;
  final String currentLang; // Tambahkan ini
  final Function(bool) onToggle;
  final Function(String) onLangChange; // Tambahkan ini

  const Settings({
    super.key,
    required this.isDark,
    required this.currentLang, // Wajib diisi
    required this.onToggle,
    required this.onLangChange, // Wajib diisi
  });

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final List<Map<String, dynamic>> languages = [
    {'name': 'Indonesia', 'native': 'Indonesia', 'flag': '🇮🇩'},
    {'name': 'English', 'native': 'English', 'flag': '🇺🇸'},
    {'name': 'Japan', 'native': '日本語', 'flag': '🇯🇵'},
    {'name': 'Chinese', 'native': '中文', 'flag': '🇨🇳'},
  ];

  // Kamus terjemahan
  final Map<String, Map<String, String>> translation = {
    'Indonesia': {
      'setting_title': 'Pengaturan',
      'dark_mode': 'Mode Gelap',
      'language': 'Bahasa',
      'app_setting': 'PENGATURAN APLIKASI',
    },
    'English': {
      'setting_title': 'Settings',
      'dark_mode': 'Dark Mode',
      'language': 'Language',
      'app_setting': 'APP SETTINGS',
    },
    'Japan': {
      'setting_title': '設定',
      'dark_mode': 'ダークモード',
      'language': '言語',
      'app_setting': 'アプリ設定',
    },
    'Chinese': {
      'setting_title': '设置',
      'dark_mode': '深色模式',
      'language': '语言',
      'app_setting': '应用设置',
    },
  };

  @override
  Widget build(BuildContext context) {
    final bool isDark = widget.isDark;
    // Ambil bahasa yang aktif saat ini dari widget induk (MainScreen/MyApp)
    final String currentLang = widget.currentLang;

    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : Colors.grey[100],
      appBar: AppBar(
        // Teks judul AppBar otomatis berubah sesuai bahasa
        title: Text(
          translation[currentLang]?['setting_title'] ?? 'Settings',
          style: TextStyle(color: isDark ? Colors.white : Colors.black),
        ),
        backgroundColor: isDark ? Colors.black : Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: isDark ? Colors.white : Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: isDark ? Colors.black87 : Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: isDark ? Colors.black54 : Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    translation[currentLang]?['app_setting'] ?? 'APP SETTINGS',
                    style: TextStyle(
                      fontSize: 14,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.blue[200] : Colors.blue[800],
                    ),
                  ),
                  const SizedBox(height: 25),

                  // Row Dark Mode
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            isDark ? Icons.dark_mode : Icons.light_mode,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                          const SizedBox(width: 20),
                          Text(
                            translation[currentLang]?['dark_mode'] ?? 'Dark Mode',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Switch(
                        value: isDark,
                        onChanged: (newValue) => widget.onToggle(newValue),
                        activeColor: Colors.blue,
                      ),
                    ],
                  ),
                  const Divider(height: 30),

                  // Row Bahasa
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.language,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                          const SizedBox(width: 20),
                          Text(
                            translation[currentLang]?['language'] ?? 'Language',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: isDark ? Colors.white : Colors.black,
                            ),
                          ),
                        ],
                      ),
                      DropdownButton<String>(
                        // Gunakan currentLang agar Dropdown sinkron dengan pilihan global
                        value: currentLang, 
                        underline: const SizedBox(),
                        dropdownColor: isDark ? Colors.grey[850] : Colors.white,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            // Panggil fungsi ganti bahasa global
                            widget.onLangChange(newValue); 
                          }
                        },
                        items: languages.map<DropdownMenuItem<String>>((lang) {
                          return DropdownMenuItem<String>(
                            value: lang['name'],
                            child: Row(
                              children: [
                                Text(lang['flag'], style: const TextStyle(fontSize: 18)),
                                const SizedBox(width: 10),
                                Text(
                                  lang['native'],
                                  style: TextStyle(
                                    color: isDark ? Colors.white : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}