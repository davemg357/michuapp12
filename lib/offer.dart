import 'package:flutter/material.dart';
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
    // Simulate API delay for the loan offer only
    Future.delayed(const Duration(seconds: 4), () {
      setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Choose loan you are eligible for",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Eligible Loans",
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
              const SizedBox(height: 20),

              // 🔹 Show shimmer or actual loan card
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                child: _isLoading ? _buildShimmerOffer() : _buildLoanOffer(),
              ),

              const Spacer(),
              _buildRejectButton(),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Shimmer placeholder for loan offer only
// 🔹 Shimmer placeholder for loan offer content only
Widget _buildShimmerOffer() {
  return Container(
    height: 230,
    decoration: BoxDecoration(
      color: Colors.black, // card background stays
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.blueAccent), // keep border
    ),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Shimmer.fromColors(
        baseColor: Colors.grey.shade800,
        highlightColor: Colors.grey.shade700,
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 14,
                        width: 100,
                        color: Colors.grey.shade900,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        height: 12,
                        width: 80,
                        color: Colors.grey.shade900,
                      ),
                      const SizedBox(height: 6),
                      Container(
                        height: 12,
                        width: 120,
                        color: Colors.grey.shade900,
                      ),
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
                      Container(
                        height: 60,
                        width: 100,
                        color: Colors.grey.shade900,
                      ),
                      Container(
                        height: 60,
                        width: 100,
                        color: Colors.grey.shade900,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 45,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900,
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
  Widget _buildLoanOffer() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.black,
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
                children: const [
                  Text(
                    "Michu-Guyya",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  Text("8,314 Br",
                      style: TextStyle(color: Colors.white70, fontSize: 16)),
                  Text("Credit Period 7 days",
                      style: TextStyle(color: Colors.white54, fontSize: 14)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Interest Rate - (7 days)",
                      style: TextStyle(color: Colors.grey, fontSize: 13)),
                  Text("0%",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Text("Monthly Repayment",
                      style: TextStyle(color: Colors.grey, fontSize: 13)),
                  Text("8,314 Br",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Penalty Rate",
                      style: TextStyle(color: Colors.grey, fontSize: 13)),
                  Text("5.00%",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Text("Total Repayment",
                      style: TextStyle(color: Colors.grey, fontSize: 13)),
                  Text("8,314 Br",
                      style: TextStyle(
                          color: Colors.white,
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
              onPressed: () {},
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

  // 🔹 Reject button stays always visible
  Widget _buildRejectButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey.shade700,
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
