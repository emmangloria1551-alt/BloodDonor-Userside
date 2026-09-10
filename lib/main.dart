import 'package:flutter/material.dart';
import 'Theme.dart';
import 'Login.dart';

void main() {
  runApp(const CommunityBloodDonorApp());
}

class CommunityBloodDonorApp extends StatelessWidget {
  const CommunityBloodDonorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Community Blood Donor',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      themeMode: ThemeMode.dark,
      home: const LoginScreen(),
    );
  }
}