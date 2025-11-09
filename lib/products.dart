import 'package:flutter/material.dart';
import 'package:michuapp/login.dart';

class AvailableProductsPage extends StatefulWidget {
  const AvailableProductsPage({super.key});

  @override
  State<AvailableProductsPage> createState() => _AvailableProductsPageState();
}

class _AvailableProductsPageState extends State<AvailableProductsPage> {
  String? selectedProduct;

  final List<Map<String, String>> products = [
    {
      'title': 'Michu–Wabii',
      'description':
          'Access up to 100,000 birr with an interest rate as low as 8% per month. Enjoy the convenience of a 1-month repayment period. Apply now!',
      'icon': 'lib/assets/product.png', // replace with your asset
    },
    {
      'title': 'Michu–Kiyya',
      'description':
          'A product designed for women, offering up to 30,000 birr at a reduced interest rate of 3.75%. The loan duration ranges from 14 days to 1 month. Apply now!',
      'icon': 'lib/assets/product.png', // replace with your asset
    },
    {
      'title': 'Michu–Guyya',
      'description':
          'Get up to 15,000 birr with only a 12% access fee and no interest. The loan is repayable in 7 days. Apply now!',
      'icon': 'lib/assets/product.png', // replace with your asset
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF0A0A0A) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final cardColor = isDark ? const Color(0xFF1A1A1A) : Colors.grey.shade100;
    const accentBlue = Color(0xFF3DB6FF);
    const accentAmber = Color(0xFFFF8C32);
    final greyText = isDark ? Colors.grey[400] : Colors.grey[700];

    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.06, vertical: h * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: h * 0.01),
              Text(
                'Available Products',
                style: TextStyle(
                  fontSize: h * 0.03,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              SizedBox(height: h * 0.02),

              // --- Product List ---
              Expanded(
                child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    final isSelected = selectedProduct == product['title'];

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedProduct = product['title'];
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: h * 0.02),
                        padding: EdgeInsets.all(w * 0.04),
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected ? accentBlue : Colors.grey.shade700,
                            width: isSelected ? 2 : 1,
                          ),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: w * 0.15,
                              height: w * 0.15,
                              decoration: BoxDecoration(
                                color: accentBlue,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Image.asset(
                                  product['icon']!,
                                  width: w * 0.07,
                                  height: w * 0.07,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(width: w * 0.04),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product['title']!,
                                    style: TextStyle(
                                      color: textColor,
                                      fontSize: h * 0.022,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: h * 0.008),
                                  Text(
                                    product['description']!,
                                    style: TextStyle(
                                      color: greyText,
                                      fontSize: h * 0.016,
                                      height: 1.3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // --- Get Started Button ---
              SizedBox(height: h * 0.02),
              Center(
                child: SizedBox(
                  width: h*0.2,
                  height: h * 0.06,
                  child: ElevatedButton(
                    onPressed: selectedProduct == null
                        ? null
                        : () {
                          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
                            return LoginPage();
                          }));
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          selectedProduct == null ? Colors.grey : accentAmber,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: h * 0.022,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: h * 0.015),

              // Footer
              Center(
                child: Text(
                  'Powered by Qena',
                  style: TextStyle(
                    color: greyText,
                    fontSize: h * 0.01,
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
