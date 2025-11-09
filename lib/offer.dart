import 'package:flutter/material.dart';
import 'package:michuapp/loanofferpage.dart';
import 'package:shimmer/shimmer.dart';

class EligibleLoanPage extends StatefulWidget {
  const EligibleLoanPage({Key? key}) : super(key: key);

  @override
  State<EligibleLoanPage> createState() => _EligibleLoanPageState();
}

class _EligibleLoanPageState extends State<EligibleLoanPage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Simulate API delay
    Future.delayed(const Duration(seconds: 4), () {
      setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? Colors.black : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final subTextColor = isDark ? Colors.grey : Colors.black54;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                "Choose loan you are eligible for",
                style: TextStyle(
                  color: textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Eligible Loans",
                style: TextStyle(color: subTextColor, fontSize: 14),
              ),
              const SizedBox(height: 20),

              AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: _isLoading ? _buildShimmerOffer(isDark) : _buildLoanOffer(isDark),
              ),

              const Spacer(),
              _buildRejectButton(isDark),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Shimmer placeholder for loan offer
  Widget _buildShimmerOffer(bool isDark) {
    final base = isDark ? Colors.grey.shade800 : Colors.grey.shade300;
    final highlight = isDark ? Colors.grey.shade700 : Colors.grey.shade100;

    return Container(
      height: 230,
      decoration: BoxDecoration(
        color: isDark ? Colors.black : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blueAccent),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Shimmer.fromColors(
          baseColor: base,
          highlightColor: highlight,
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: base,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(height: 14, width: 100, color: base),
                        const SizedBox(height: 8),
                        Container(height: 12, width: 80, color: base),
                        const SizedBox(height: 6),
                        Container(height: 12, width: 120, color: base),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(height: 60, width: 100, color: base),
                        Container(height: 60, width: 100, color: base),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 45,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: base,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Actual loan offer card
  Widget _buildLoanOffer(bool isDark) {
    final cardColor = isDark ? Colors.black : Colors.white;
    final titleColor = isDark ? Colors.white : Colors.black87;
    final detailColor = isDark ? Colors.white70 : Colors.black54;
    final subTextColor = isDark ? Colors.grey : Colors.black54; // <--- defined here

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.blueAccent),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(12),
                child: const Icon(Icons.person, color: Colors.white, size: 40),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Michu-Guyya",
                    style: TextStyle(
                      color: titleColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("8,314 Br",
                      style: TextStyle(color: detailColor, fontSize: 16)),
                  Text("Credit Period 7 days",
                      style: TextStyle(color: detailColor, fontSize: 14)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Interest Rate - (7 days)",
                      style: TextStyle(color: subTextColor, fontSize: 13)),
                  Text("0%",
                      style: TextStyle(
                          color: titleColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text("Monthly Repayment",
                      style: TextStyle(color: subTextColor, fontSize: 13)),
                  Text("8,314 Br",
                      style: TextStyle(
                          color: titleColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Penalty Rate",
                      style: TextStyle(color: subTextColor, fontSize: 13)),
                  Text("5.00%",
                      style: TextStyle(
                          color: titleColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 5),
                  Text("Total Repayment",
                      style: TextStyle(color: subTextColor, fontSize: 13)),
                  Text("8,314 Br",
                      style: TextStyle(
                          color: titleColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                  return LoanOfferPage();
                }));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text("Apply Now",
                  style: TextStyle(color: Colors.white, fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Reject button
  Widget _buildRejectButton(bool isDark) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isDark ? Colors.grey.shade700 : Colors.grey.shade400,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const Text(
          "Reject All",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
