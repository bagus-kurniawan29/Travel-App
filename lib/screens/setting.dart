import 'package:flutter/material.dart';
import 'package:travel_app/l10n/app_localizations.dart';

class Settings extends StatefulWidget {
  final bool isDark;
  final String currentLang;
  final Function(bool) onToggle;
  final Function(String) onLangChange;

  const Settings({
    super.key,
    required this.isDark,
    required this.currentLang,
    required this.onToggle,
    required this.onLangChange,
  });

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final List<Map<String, dynamic>> languages = [
    {'id': 'id', 'native': 'Indonesia', 'flag': '🇮🇩'},
    {'id': 'en', 'native': 'English', 'flag': '🇺🇸'},
    {'id': 'de', 'native': 'Deutsch', 'flag': '🇩🇪'},
    {'id': 'ar', 'native': 'عربي', 'flag': '🇸🇦'},
    {'id': 'ja', 'native': '日本語', 'flag': '🇯🇵'},
    {'id': 'zh', 'native': '中文', 'flag': '🇨🇳'},
    {'id': 'ko', 'native': '한국어', 'flag': '🇰🇷'},
  ];

  @override
  Widget build(BuildContext context) {
    final bool isDark = widget.isDark;

    var t = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: isDark ? Colors.grey[900] : Colors.grey[100],
      appBar: AppBar(
        title: Text(
          "Settings",
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
                    color:
                        isDark
                            ? Colors.black54
                            : Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    t.appSetting,
                    style: TextStyle(
                      fontSize: 14,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.blue[200] : Colors.blue[800],
                    ),
                  ),
                  const SizedBox(height: 25),

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
                          Text(t.darkmode),
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
                          Text(t.language),
                        ],
                      ),
                      DropdownButton<String>(
                        value: widget.currentLang,
                        underline: const SizedBox(),
                        dropdownColor: isDark ? Colors.grey[850] : Colors.white,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            widget.onLangChange(newValue);
                          }
                        },
                        items:
                            languages.map<DropdownMenuItem<String>>((lang) {
                              return DropdownMenuItem<String>(
                                value: lang['id'],
                                child: Row(
                                  children: [
                                    Text(
                                      lang['flag'],
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      lang['native'],
                                      style: TextStyle(
                                        color:
                                            isDark
                                                ? Colors.white
                                                : Colors.black,
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
