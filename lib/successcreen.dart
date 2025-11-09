import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'dart:math';

import 'package:michuapp/home.dart';

class LoanSuccessPage extends StatefulWidget {
  const LoanSuccessPage({Key? key}) : super(key: key);

  @override
  State<LoanSuccessPage> createState() => _LoanSuccessPageState();
}

class _LoanSuccessPageState extends State<LoanSuccessPage> {
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 3));
    _confettiController.play();
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black87;
    final bgColor = isDark ? Colors.black : Colors.white;

    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          // 🔹 Confetti animation
          ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            emissionFrequency: 0.05,
            numberOfParticles: 40,
            gravity: 0.2,
            colors: const [
              Colors.orange,
              Colors.blue,
              Colors.green,
              Colors.purple,
              Colors.pink,
            ],
          ),

          // 🔹 Success content
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.celebration,
                    color: Colors.orange, size: 100),
                const SizedBox(height: 30),
                Text(
                  "Loan Request Successful!",
                  style: TextStyle(
                    color: textColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  "Your loan request has been received successfully.\nYou will be notified once it’s processed.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                        return WelcomeBackPage();
                      }));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding:
                          const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Text(
                      "Back to Home",
                      style:
                          TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
