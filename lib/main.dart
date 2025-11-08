import 'package:flutter/material.dart';
import 'package:michuapp/login.dart';
import 'package:michuapp/themeprovider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
        ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Main(),
    ),
  );
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
            theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      themeMode: themeProvider.themeMode,
      home: LoginPage(),
    );
  }
}