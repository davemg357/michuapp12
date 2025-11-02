import 'package:flutter/material.dart';
import 'package:michuapp/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Dynamic paddings and spacings
    final horizontalPadding = screenWidth * 0.06;
    final verticalPadding = screenHeight * 0.04;
    final fieldSpacing = screenHeight * 0.025;
    final logoHeight = screenHeight * 0.05;
    final buttonWidth = screenWidth * 0.4;
    final buttonHeight = screenHeight * 0.05;

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),

      resizeToAvoidBottomInset: true,

      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            child: Form(
              key: _formKey, // 👈 Form key for validation
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo (Top Right)
                  Align(
                    alignment: Alignment.topRight,
                    child: Image.asset(
                      'lib/assets/MICHU-LOGO-2.png',
                      height: logoHeight,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),

                  // Title
                  Text(
                    'Login',
                    style: TextStyle(
                      color: const Color(0xFF33A6FF),
                      fontSize: screenWidth * 0.08,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),

                  // Subtitle
                  Text(
                    'Please enter your password',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: screenWidth * 0.04,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),

                  // Mobile Number Field
                  TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      prefixIcon:
                          const Icon(Icons.phone, color: Colors.white70),
                      hintText: '+251 92577****7',
                      hintStyle: const TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Colors.transparent,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white54),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white54),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: fieldSpacing),

                  // Password Field with Validator
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.vpn_key, color: Colors.white70),
                      suffixIcon:
                          const Icon(Icons.visibility, color: Colors.white70),
                      hintText: 'Password',
                      hintStyle: const TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Colors.transparent,

                      // Normal border
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.white54),
                      ),

                      // Focused border
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Color(0xFFFFA53E)),
                      ),

                      // Error borders (red)
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.red, width: 1.5),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Colors.red, width: 1.5),
                      ),
                    ),

                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password cannot be empty';
                      } else if (value.length < 8) {
                        return 'Password must be at least 8 characters long';
                      }
                      return null; 
                    },
                  ),
                  SizedBox(height: screenHeight * 0.01),

                  // Password note
                  Text(
                    'Password must be 8 characters long',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: screenWidth * 0.03,
                    ),
                  ),
                  SizedBox(height: fieldSpacing),

                  // Forgot Password link
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot Password?',
                        style: TextStyle(
                          color: const Color(0xFFFFA53E),
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),

                  // Login Button
                  Center(
                    child: SizedBox(
                      width: buttonWidth,
                      height: buttonHeight,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const WelcomeBackPage(),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 255, 7, 7),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Login',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.045,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
