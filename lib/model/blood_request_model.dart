class BloodRequest {
  final String id;
  final String name;
  final String bloodType;
  final int units;
  final String hospital;
  final String location;
  final String urgency;
  final DateTime createdAt;

  const BloodRequest({
    required this.id,
    required this.name,
    required this.bloodType,
    required this.units,
    required this.hospital,
    required this.location,
    required this.urgency,
    required this.createdAt,
  });

  factory BloodRequest.fromJson(Map<String, dynamic> json) {
    return BloodRequest(
      id: json['id'].toString(),
      name: json["name"]. toString(),
      bloodType: json['blood_type'] as String,
      units: json['units'] as int,
      hospital: json['hospital'] as String,
      location: json['location'] as String,
      urgency: json['urgency'] as String,
      createdAt: DateTime.parse(
        json['created_at'] as String,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      "name": name,
      'blood_type': bloodType,
      'units': units,
      'hospital': hospital,
      'location': location,
      'urgency': urgency,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
