import 'package:blood_donor/widget/donation_activity.dart';
import 'package:flutter/material.dart';
import 'package:blood_donor/model/blood_request_model.dart';

class Donate extends StatefulWidget {
  const Donate({super.key});

  @override
  State<Donate> createState() => _DonateState();
}

class _DonateState extends State<Donate> {

  final BloodRequest donationActivity = BloodRequest(
    id: '1',
    name: 'Juan Dela Cruz',
    bloodType: 'O+',
    units: 2,
    hospital: 'Community Hospital',
    location: 'Quezon City',
    urgency: 'Urgent',
    createdAt: DateTime.now(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "Give Blood, Give Hope",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),

            const SizedBox(height: 26),

            DonationActivityCard(
              activity: donationActivity,
              onJoin: () {
                print("Help button pressed");
              },
            ),
          ],
        ),
      ),
    );
  }
}