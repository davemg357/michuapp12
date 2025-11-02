import 'package:flutter/material.dart';
import 'package:michuapp/drawer.dart';
import 'package:michuapp/offer.dart';

class WelcomeBackPage extends StatelessWidget {
  const WelcomeBackPage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final horizontalPadding = screenWidth * 0.06;
    final verticalPadding = screenHeight * 0.04;
    final imageHeight = screenHeight * 0.35;
    final buttonWidth = screenWidth * 0.4;
    final buttonHeight = screenHeight * 0.05;

    return Scaffold(
          
      backgroundColor: const Color(0xFF0D0D0D),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row with Menu and Logo
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Menu Icon
                    IconButton(
                      icon: const Icon(Icons.menu, color: Colors.white, size: 30),
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context){
                          return ProfileDrawerPage();
                        }));
                      },
                    ),
                    // Logo
                    Image.asset(
                      'lib/assets/MICHU-LOGO-2.png', 
                      height: screenHeight * 0.05,
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.03),

                // Welcome Message
                const Text(
                  'Welcome back',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: screenHeight * 0.005),

                // User Name
                const Text(
                  'Dawit Megerssa Gedefa',
                  style: TextStyle(
                    color: Color(0xFFFFA53E),
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),

                // View Loan History link
                Row(
                  children: [
                    Text(
                      'View Loan History',
                      style: TextStyle(
                        color: const Color(0xFF33A6FF),
                        fontSize: screenWidth * 0.035,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(Icons.arrow_right_alt,
                        color: Color(0xFF33A6FF), size: 22),
                  ],
                ),
                SizedBox(height: screenHeight * 0.04),

                // Illustration Image
                Center(
                  child: Image.asset(
                    'lib/assets/loan.png', 
                    height: imageHeight,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),

                // Info Text
                Text(
                  'You have successfully completed your loan. '
                  'Would you like to reapply for a new Loan?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: screenWidth * 0.04,
                    height: 1.4,
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),

                // Reapply Now Button
                Center(
                  child: SizedBox(
                    width: buttonWidth,
                    height: buttonHeight,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context){
                          return EligibleLoanPage();
                        }));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFA53E),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Reapply Now',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth * 0.045,
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
      ),
    );
  }
}
