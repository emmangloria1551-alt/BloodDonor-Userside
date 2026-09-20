class UserProfile {
  final String name;
  final String email;
  final String contact;
  final String address;
  final String bloodType;

  UserProfile({
    required this.name,
    required this.email,
    required this.contact,
    required this.address,
    required this.bloodType,
  });

  UserProfile copyWith({
    String? name,
    String? email,
    String? contact,
    String? address,
    String? bloodType,
  }) {
    return UserProfile(
      name: name ?? this.name,
      email: email ?? this.email,
      contact: contact ?? this.contact,
      address: address ?? this.address,
      bloodType: bloodType ?? this.bloodType,
    );
  }
}
