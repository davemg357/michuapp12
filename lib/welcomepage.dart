import 'package:flutter/material.dart';
import 'package:michuapp/aichat.dart';
import 'package:michuapp/intro.dart';
import 'package:michuapp/themeprovider.dart';
import 'package:provider/provider.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeProvider = Provider.of<ThemeProvider>(context);

    // Color palette
    final backgroundColor = isDark ? const Color(0xFF0A0A0A) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final greyText = isDark ? Colors.grey[400] : Colors.grey[600];
    const accentBlue = Color(0xFF3DB6FF);
    const accentAmber = Color(0xFFFF8C32);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth;
          final h = constraints.maxHeight;
          final scale = (w < h ? w : h) / 250;

          final logoHeight = h * 0.1;
          final welcomeFont = 20 * scale;
          final michuFont = 40 * scale;
          final subFont = 14 * scale;
          final buttonWidth = w * 0.25;
          final buttonHeight = h * 0.05;
          final circleSmall = w * 0.04;
          final circleMedium = w * 0.08;
          final circleLarge = w * 0.15;

          return SafeArea(
            child: Stack(
              children: [
                // --- Background circles ---
                Positioned(top: h * 0.05, left: w * 0.08, child: circle(accentAmber, circleSmall)),
                Positioned(top: h * 0.12, right: w * 0.1, child: circle(accentBlue, circleMedium)),
                Positioned(bottom: h * 0.15, left: w * 0.12, child: circle(accentBlue, circleSmall * 1.2)),
                Positioned(bottom: h * 0.3, right: w * 0.15, child: circle(accentAmber, circleSmall * 0.6)),
                Positioned(bottom: h * 0.05, right: -w * 0.08, child: circle(accentBlue, circleLarge)),
                Positioned(top: h * 0.3, right: w * 0.15, child: circle(accentAmber, circleSmall)),

                // --- Main content ---
                SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: w * 0.06),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: h),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: h * 0.15),

                          // Logo
                          Image.asset(
                            'lib/assets/MICHU-LOGO-2.png',
                            height: logoHeight,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(height: h * 0.15),

                          // Texts
                          Text(
                            'Welcome to',
                            style: TextStyle(
                              color: accentAmber,
                              fontSize: welcomeFont,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: h * 0.005),
                          Text(
                            'Michu',
                            style: TextStyle(
                              color: accentBlue,
                              fontSize: michuFont,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: h * 0.005),
                          Text(
                            'Digital Lending App',
                            style: TextStyle(
                              color: greyText,
                              fontSize: subFont,
                            ),
                          ),
                          SizedBox(height: h * 0.08),

                          // Language dropdown
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: w * 0.03),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: isDark ? Colors.grey.shade700 : Colors.grey.shade400,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(w * 0.02),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: selectedLanguage,
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: textColor,
                                  size: w * 0.06,
                                ),
                                dropdownColor: isDark ? const Color(0xFF1C1C1C) : Colors.white,
                                style: TextStyle(color: textColor, fontSize: subFont),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedLanguage = newValue!;
                                  });
                                },
                                items: <String>['English', 'Amharic', 'Afaan Oromo']
                                    .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                          SizedBox(height: h * 0.04),

                          // Start button
                          Align(
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              width: buttonWidth,
                              height: buttonHeight,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: accentAmber,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(w * 0.02),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const IntroPage(),
                                  ));
                                },
                                child: Text(
                                  'Start',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14 * scale,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),

                          // Footer
                          Center(
                            child: Padding(
                              padding: EdgeInsets.only(bottom: h * 0.03),
                              child: Text(
                                'Powered by Qena',
                                style: TextStyle(
                                  color: greyText,
                                  fontSize: 12 * scale,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // --- Theme toggle button (always touchable) ---
                Positioned(
                  top: 16,
                  right: 16,
                  child: Material(
                    color: Colors.transparent,
                    shape: const CircleBorder(),
                    child: IconButton(
                      icon: Icon(
                        isDark ? Icons.light_mode : Icons.dark_mode,
                        color: isDark ? Colors.white : Colors.black,
                        size: w * 0.07,
                      ),
                      onPressed: () {
                        _showThemeDialog(context, themeProvider);
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAIBottomSheet(context);
        },
        backgroundColor: Colors.amber,
        child: const Icon(Icons.smart_toy, color: Colors.black),
      ),
    );
  }

  Widget circle(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  void _showThemeDialog(BuildContext context, ThemeProvider themeProvider) {
    ThemeMode current = themeProvider.themeMode;
    final theme = Theme.of(context);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: theme.dialogBackgroundColor,
        title: Text('Select Theme', style: theme.textTheme.titleMedium),
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
      ),
    );
  }
}
