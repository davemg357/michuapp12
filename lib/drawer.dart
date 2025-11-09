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
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final cardPadding = screenWidth * 0.04;
    final profileHeight = screenHeight * 0.14;
    final borderRadius = screenWidth * 0.05;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Column(
        children: [
          // Header
          Container(
            height: screenHeight * 0.2,
            color: Colors.blue,
            child: Stack(
              children: [
                Positioned(
                  top: screenHeight * 0.05,
                  left: screenWidth * 0.04,
                  child: CircleAvatar(
                    backgroundColor: theme.cardColor,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: theme.colorScheme.secondary),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: cardPadding, vertical: cardPadding),
              child: Column(
                children: [
                  // Profile Card
                  Container(
                    width: double.infinity,
                    height: profileHeight,
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(borderRadius),
                      border: Border.all(color: theme.colorScheme.secondary, width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: theme.shadowColor.withOpacity(0.1),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(screenWidth * 0.04),
                      child: Row(
                        children: [
                          Container(
                            width: screenWidth * 0.16,
                            height: screenWidth * 0.16,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.secondary,
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "DG",
                              style: theme.textTheme.titleLarge?.copyWith(
                                color: theme.colorScheme.onSecondary,
                                fontWeight: FontWeight.bold,
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
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "+251 92 577 7387",
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.03),

                  // Settings Tiles
                  _buildSettingTile(context, "Theme"),
                  _buildSettingTile(context, "Loan History"),
                  _buildSettingTile(context, "Bank Account"),

                  SizedBox(height: screenHeight * 0.03),

                  // Language Section
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.015,
                      horizontal: screenWidth * 0.04,
                    ),
                    decoration: BoxDecoration(
                      color: theme.cardColor,
                      borderRadius: BorderRadius.circular(borderRadius),
                      border: Border.all(color: theme.colorScheme.secondary, width: 1),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLanguageOption(context, "English"),
                        _buildLanguageOption(context, "አማርኛ"),
                        _buildLanguageOption(context, "Afaan Oromoo"),
                        _buildLanguageOption(context, "ትግርኛ"),
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

  Widget _buildSettingTile(BuildContext context, String title) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () {
        if (title == "Theme") _showThemeDialog();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: theme.colorScheme.secondary, width: 0.8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: theme.textTheme.bodyLarge),
            Icon(Icons.arrow_forward_ios, color: theme.iconTheme.color?.withOpacity(0.7), size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(BuildContext context, String lang) {
    final theme = Theme.of(context);
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
            Text(lang, style: theme.textTheme.bodyLarge),
            Checkbox(
              value: isSelected,
              activeColor: theme.primaryColor,
              checkColor: theme.colorScheme.onPrimary,
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
        final theme = Theme.of(context);
        return AlertDialog(
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
        );
      },
    );
  }
}
