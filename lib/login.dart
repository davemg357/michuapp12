import 'package:flutter/material.dart';
import 'package:michuapp/aichat.dart';
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
    // Theme-aware colors
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDark ? const Color(0xFF0D0D0D) : Colors.white;
    final textColor = isDark ? Colors.white : Colors.black87;
    final hintColor = isDark ? Colors.white70 : Colors.black54;
    final borderColor = isDark ? Colors.white54 : Colors.black38;

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
      backgroundColor: backgroundColor,
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
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: Image.asset(
                      'lib/assets/MICHU-LOGO-2.png',
                      height: logoHeight,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),

                  Text(
                    'Login',
                    style: TextStyle(
                      color: const Color(0xFF33A6FF),
                      fontSize: screenWidth * 0.08,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),

                  Text(
                    'Please enter your password',
                    style: TextStyle(
                      color: hintColor,
                      fontSize: screenWidth * 0.04,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.05),

                  TextField(
                    enabled: false,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.phone, color: hintColor),
                      hintText: '+251 92577****7',
                      hintStyle: TextStyle(color: hintColor),
                      filled: true,
                      fillColor: Colors.transparent,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: borderColor),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: borderColor),
                      ),
                    ),
                    style: TextStyle(color: textColor),
                  ),
                  SizedBox(height: fieldSpacing),

                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    style: TextStyle(color: textColor),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.vpn_key, color: hintColor),
                      suffixIcon: Icon(Icons.visibility, color: hintColor),
                      hintText: 'Password',
                      hintStyle: TextStyle(color: hintColor),
                      filled: true,
                      fillColor: Colors.transparent,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: borderColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide:
                            const BorderSide(color: Color(0xFFFFA53E)),
                      ),
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

                  Text(
                    'Password must be 8 characters long',
                    style: TextStyle(
                      color: hintColor,
                      fontSize: screenWidth * 0.03,
                    ),
                  ),
                  SizedBox(height: fieldSpacing),

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
                          backgroundColor: const Color(0xFFFFA53E),
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
      floatingActionButton: FloatingActionButton(onPressed: (){

      showAIBottomSheet(context);
      },
      backgroundColor: Colors.amber,
      child: Icon(Icons.smart_toy,color: Colors.black,),
      ),
    );
  }
}
