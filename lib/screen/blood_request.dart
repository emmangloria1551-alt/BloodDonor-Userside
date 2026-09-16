import 'package:flutter/material.dart';

import '../model/blood_donor.dart';
import '../widget/blood_donor.dart';
import '../theme/app_colors.dart';


class Blood_Request extends StatelessWidget {
  const Blood_Request({super.key});

  @override
  Widget build(BuildContext context) {
    const BloodDonor donor = BloodDonor(
      name: 'Juan Dela Cruz',
      bloodType: 'O+',
      location: 'Quezon City',
      isAvailable: true,
    );

    return Scaffold(
      backgroundColor: Colors.backGo

      appBar: AppBar(
        title: const Text(
          'Community Blood Donors',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: BloodDonorCard(
          donor: donor,

          onRequestBlood: () {
            // For now, just show a message.
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Blood request selected for Juan Dela Cruz',
                ),
                backgroundColor: Color(0xFFD32F2F),
              ),
            );
          },
        ),
      ),
    );
  }
}
