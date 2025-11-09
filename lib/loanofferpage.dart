import 'package:flutter/material.dart';
import 'package:michuapp/successcreen.dart';

class LoanOfferPage extends StatefulWidget {
  const LoanOfferPage({Key? key}) : super(key: key);

  @override
  State<LoanOfferPage> createState() => _LoanOfferPageState();
}

class _LoanOfferPageState extends State<LoanOfferPage> {
  final TextEditingController _amountController =
      TextEditingController(text: "8,314");

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Colors.black : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subTextColor = isDark ? Colors.grey.shade400 : Colors.grey.shade600;
    final cardColor = isDark ? Colors.grey.shade900 : Colors.white;
    final borderColor = isDark ? Colors.grey.shade700 : Colors.grey.shade300;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Michu Logo
              Align(
                alignment: Alignment.topRight,
                child: Image.asset(
                  "lib/assets/MICHU-LOGO-2.png", 
                  height: 30,
                ),
              ),
              const SizedBox(height: 20),

              // 🔹 Title
              Text(
                "Your Loan Offer",
                style: TextStyle(
                  color: textColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              // 🔹 Blue offer card
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                decoration: BoxDecoration(
                  color: const Color(0xFF3DB2FF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "You are offered",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "8,314 Br",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _amountController,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                      decoration: const InputDecoration(
                        hintText: "Enter a different amount",
                        hintStyle: TextStyle(color: Colors.white70),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white70),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              // 🔹 Offer Details Title
              Text(
                "Offer Detail",
                style: TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),

              // 🔹 Detail Cards
              _buildInfoRow(
                leftTitle: "Access fee - 12.0%",
                leftValue: "997.68 Br",
                rightTitle: "Interest - 0%",
                rightValue: "0 Br",
                isDark: isDark,
                cardColor: cardColor,
                borderColor: borderColor,
                subTextColor: subTextColor,
                textColor: textColor,
              ),
              const SizedBox(height: 12),
              _buildInfoRow(
                leftTitle: "Loan duration",
                leftValue: "7 days",
                rightTitle: "Total Repayment",
                rightValue: "8,314 Br",
                isDark: isDark,
                cardColor: cardColor,
                borderColor: borderColor,
                subTextColor: subTextColor,
                textColor: textColor,
              ),
              const SizedBox(height: 12),
              _buildInfoRow(
                leftTitle: "Daily Penalty Rate",
                leftValue: "0.714%",
                rightTitle: "No of Installment",
                rightValue: "1 Installments",
                isDark: isDark,
                cardColor: cardColor,
                borderColor: borderColor,
                subTextColor: subTextColor,
                textColor: textColor,
              ),

              const SizedBox(height: 30),

              // 🔹 Next Button
             // 🔹 Next Button (renamed to Accept)
SizedBox(
  width: double.infinity,
  child: ElevatedButton(
    onPressed: () {
      // Navigate to success screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoanSuccessPage(),
        ),
      );
    },
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.orange,
      padding: const EdgeInsets.symmetric(vertical: 14),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8)),
    ),
    child: const Text(
      "Accept",
      style: TextStyle(color: Colors.white, fontSize: 16),
    ),
  ),
),

              const SizedBox(height: 10),

              // 🔹 Reject Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isDark
                        ? Colors.grey.shade700
                        : Colors.grey.shade400,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text(
                    "Reject",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Helper for offer detail rows
  Widget _buildInfoRow({
    required String leftTitle,
    required String leftValue,
    required String rightTitle,
    required String rightValue,
    required bool isDark,
    required Color cardColor,
    required Color borderColor,
    required Color subTextColor,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildInfoColumn(leftTitle, leftValue, textColor, subTextColor),
          _buildInfoColumn(rightTitle, rightValue, textColor, subTextColor),
        ],
      ),
    );
  }

  Widget _buildInfoColumn(
      String title, String value, Color textColor, Color subTextColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(color: subTextColor, fontSize: 13)),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: textColor,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
