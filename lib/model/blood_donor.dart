class BloodDonor {
  final String name;
  final String email;
  final String bloodType;
  final String contact;
  final String location;
  final int unitsNeeded;
  final String urgency;
  final DateTime requestedAt;
  final bool isAvailable;

  const BloodDonor({
    required this.name,
    required this.email,
    required this.bloodType,
    required this.contact,
    required this.location,
    required this.unitsNeeded,
    required this.urgency,
    required this.requestedAt,
    required this.isAvailable,
  });
}
