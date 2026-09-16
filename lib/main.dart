
import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'screen/login.dart';

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
      home: const LoginScreen(),
    );
  }
}
