import 'package:flutter/material.dart';
import 'package:michuapp/aichat.dart';
import 'package:michuapp/drawer.dart';
import 'package:michuapp/offer.dart'; 

class WelcomeBackPage extends StatelessWidget {
  const WelcomeBackPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Detect if the app is in dark mode
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Background color changes with theme
    final backgroundColor = isDark ? const Color(0xFF0D0D0D) : Colors.white;

    // Adjust text/icon color for visibility on light mode
    final baseTextColor = isDark ? Colors.white : Colors.black;
    final secondaryTextColor = isDark ? Colors.white70 : Colors.black87;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.06, vertical: screenHeight * 0.04),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.menu, color: baseTextColor, size: 30),
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const ProfileDrawerPage()),
                    ),
                  ),
                  Image.asset(
                    'lib/assets/MICHU-LOGO-2.png',
                    height: screenHeight * 0.05,
                  ),
                  IconButton(
                    icon: Icon(Icons.smart_toy, color: baseTextColor, size: 30),
                    onPressed: () => showAIBottomSheet(context),
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.03),

              // Welcome Text
              Text(
                'Welcome back',
                style: TextStyle(
                  color: baseTextColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Dawit Megerssa Gedefa',
                style: TextStyle(
                  color: Color(0xFFFFA53E),
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),

              // Loan History Link
              const Row(
                children: [
                  Text(
                    'View Loan History',
                    style: TextStyle(
                      color: Color(0xFF33A6FF),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 6),
                  Icon(Icons.arrow_right_alt,
                      color: Color(0xFF33A6FF), size: 22),
                ],
              ),

              SizedBox(height: screenHeight * 0.04),

              // Loan Image
              Center(
                child: Image.asset(
                  'lib/assets/loan.png',
                  height: screenHeight * 0.35,
                  fit: BoxFit.contain,
                ),
              ),

              SizedBox(height: screenHeight * 0.05),

              // Info Text
              Text(
                'You have successfully completed your loan. Would you like to reapply for a new Loan?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: secondaryTextColor,
                  fontSize: 16,
                  height: 1.4,
                ),
              ),

              SizedBox(height: screenHeight * 0.05),

              // Button
              Center(
                child: SizedBox(
                  width: screenWidth * 0.4,
                  height: screenHeight * 0.05,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const EligibleLoanPage()),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFA53E),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Reapply Now',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
