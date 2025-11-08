import 'package:flutter/material.dart';
import 'package:michuapp/themeprovider.dart';
import 'package:provider/provider.dart';

class ProfileDrawerPage extends StatefulWidget {
  const ProfileDrawerPage({super.key});

  @override
  State<ProfileDrawerPage> createState() => _ProfileDrawerPageState();
}

class _ProfileDrawerPageState extends State<ProfileDrawerPage> {
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final cardPadding = screenWidth * 0.04;
    final profileHeight = screenHeight * 0.14;
    final borderRadius = screenWidth * 0.05;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Container(
            height: screenHeight * 0.2,
            color: const Color(0xFF33A6FF),
            child: Stack(
              children: [
                Positioned(
                  top: screenHeight * 0.05,
                  left: screenWidth * 0.04,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Color(0xFFFFA53E)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: cardPadding, vertical: cardPadding),
              child: Column(
                children: [
                  // Profile card
                  Container(
                    width: double.infinity,
                    height: profileHeight,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(borderRadius),
                      border: Border.all(color: const Color(0xFFFFA53E), width: 1),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(screenWidth * 0.04),
                      child: Row(
                        children: [
                          Container(
                            width: screenWidth * 0.16,
                            height: screenWidth * 0.16,
                            decoration: const BoxDecoration(
                              color: Color(0xFFFFA53E),
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "DG",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: screenWidth * 0.06,
                              ),
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.04),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Dawit Megerssa Gedefa",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: screenWidth * 0.045,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "+251 92 577 7387",
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: screenWidth * 0.035,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),

                  // Settings items
                  _buildSettingTile("Theme"),
                  _buildSettingTile("Loan History"),
                  _buildSettingTile("Bank Account"),
                  SizedBox(height: screenHeight * 0.03),

                  // Language Section
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.015, horizontal: screenWidth * 0.04),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(borderRadius),
                      border: Border.all(color: const Color(0xFFFFA53E), width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLanguageOption("English"),
                        _buildLanguageOption("አማርኛ"),
                        _buildLanguageOption("Afaan Oromoo"),
                        _buildLanguageOption("ትግርኛ"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingTile(String title) {
    return InkWell(
      onTap: () {
        if (title == "Theme") _showThemeDialog();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: const Color(0xFFFFA53E), width: 0.8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(color: Colors.white, fontSize: 16)),
            const Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(String lang) {
    final isSelected = _selectedLanguage == lang;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedLanguage = lang;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(lang, style: const TextStyle(color: Colors.white, fontSize: 16)),
            Checkbox(
              value: isSelected,
              activeColor: const Color(0xFF33A6FF),
              checkColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _selectedLanguage = lang;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showThemeDialog() {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    ThemeMode current = themeProvider.themeMode;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select Theme'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<ThemeMode>(
                title: const Text('Light'),
                value: ThemeMode.light,
                groupValue: current,
                onChanged: (mode) {
                  themeProvider.setTheme(mode!);
                  Navigator.pop(context);
                },
              ),
              RadioListTile<ThemeMode>(
                title: const Text('Dark'),
                value: ThemeMode.dark,
                groupValue: current,
                onChanged: (mode) {
                  themeProvider.setTheme(mode!);
                  Navigator.pop(context);
                },
              ),
              RadioListTile<ThemeMode>(
                title: const Text('System'),
                value: ThemeMode.system,
                groupValue: current,
                onChanged: (mode) {
                  themeProvider.setTheme(mode!);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
