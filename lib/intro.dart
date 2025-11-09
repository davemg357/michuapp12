import 'dart:async';
import 'package:flutter/material.dart';
import 'package:michuapp/products.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  final List<Map<String, String>> _slides = [
    {
      'title': 'Apply Now',
      'subtitle': 'Fill a simple loan application form and submit',
      'image': 'lib/assets/apply.png'
    },
    {
      'title': 'Quick Approval',
      'subtitle': 'Get your loan approved within minutes',
      'image': 'lib/assets/approve.png'
    },
    {
      'title': 'Secure Transactions',
      'subtitle': 'Your data is protected with top-grade security',
      'image': 'lib/assets/secure.png'
    },
    {
      'title': 'Instant Disbursement',
      'subtitle': 'Receive your funds directly in your account',
      'image': 'lib/assets/quick.png'
    },
  ];

  @override
  void initState() {
    super.initState();
    _autoSlide();
  }

  void _autoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < _slides.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      if (mounted) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF0A0A0A) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final greyText = isDark ? Colors.grey[400] : Colors.grey[600];
    const accentBlue = Color(0xFF3DB6FF);
    const accentAmber = Color(0xFFFF8C32);

    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // --- Logo ---
            Padding(
              padding: EdgeInsets.only(top: h * 0.02),
              child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.only(right: w * 0.05),
                  child: Image.asset(
                    'lib/assets/MICHU-LOGO-2.png',
                    height: h * 0.06,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),

            // --- PageView (Slides) ---
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _slides.length,
                onPageChanged: (int index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  final slide = _slides[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.08),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          slide['image']!,
                          height: h * 0.35,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(height: h * 0.08),
                        Text(
                          slide['title']!,
                          style: TextStyle(
                            color: textColor,
                            fontSize: h * 0.035,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: h * 0.01),
                        Text(
                          slide['subtitle']!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: greyText,
                            fontSize: h * 0.018,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // --- Dots indicator ---
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_slides.length, (index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(horizontal: w * 0.01),
                  height: h * 0.012,
                  width: _currentPage == index ? h * 0.025 : h * 0.012,
                  decoration: BoxDecoration(
                    color: _currentPage == index ? accentBlue : Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                );
              }),
            ),
            SizedBox(height: h * 0.04),

            // --- Skip and Next buttons ---
            Padding(
              padding: EdgeInsets.symmetric(horizontal: w * 0.08),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Skip (invisible on last slide)
                  Visibility(
                    visible: _currentPage != _slides.length - 1,
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AvailableProductsPage()),
                        );
                      },
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          color: accentAmber,
                          fontSize: h * 0.02,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  // Next
                  SizedBox(
                    width: w * 0.25,
                    height: h * 0.06,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accentAmber,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        if (_currentPage < _slides.length - 1) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOut,
                          );
                        } else {
                          // Navigate to next page
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AvailableProductsPage()),
                          );
                        }
                      },
                      child: Text(
                        _currentPage == _slides.length - 1 ? 'Start' : 'Next',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: h * 0.022,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: h * 0.02),

            // --- Footer ---
            Padding(
              padding: EdgeInsets.only(bottom: h * 0.02),
              child: Text(
                'Powered by Qena',
                style: TextStyle(
                  color: greyText,
                  fontSize: h * 0.016,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
