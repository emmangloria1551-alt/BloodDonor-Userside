import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../services/user_session.dart';

class BloodRequestScreen extends StatefulWidget {
  const BloodRequestScreen({super.key});

  @override
  State<BloodRequestScreen> createState() =>
      _BloodRequestScreenState();
}

class _BloodRequestScreenState extends State<BloodRequestScreen> {
  List<Map<String, dynamic>> donors = [];
  bool loadingDonors = true;
  String? donorError;

  @override
  void initState() {
    super.initState();
    loadDonors();
  }

  Future<void> loadDonors() async {
    setState(() {
      loadingDonors = true;
      donorError = null;
    });

    final result = await ApiService.getDonors();

    if (!mounted) return;

    if (result['success'] == true) {
      final data = result['donors'];

      setState(() {
        donors = data is List
            ? data
                .whereType<Map>()
                .map((item) => Map<String, dynamic>.from(item))
                .toList()
            : [];
        loadingDonors = false;
      });
    } else {
      setState(() {
        loadingDonors = false;
        donorError = result['message']?.toString() ??
            'Unable to load donors.';
      });
    }
  }

  void createRequest() {
    final patientNameController = TextEditingController();
    final hospitalController = TextEditingController();
    final notesController = TextEditingController();

    String bloodType = 'O+';
    String units = '1';
    String urgency = 'Normal';
    bool submitting = false;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => StatefulBuilder(
        builder: (dialogContext, setDialogState) {
          Future<void> submitRequest() async {
            if (patientNameController.text.trim().isEmpty ||
                hospitalController.text.trim().isEmpty) {
              ScaffoldMessenger.of(dialogContext).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Please enter the patient name and hospital.',
                  ),
                ),
              );
              return;
            }

            final int? userId = UserSession.userId;

            if (userId == null) {
              ScaffoldMessenger.of(dialogContext).showSnackBar(
                const SnackBar(
                  content: Text('Please login again.'),
                ),
              );
              return;
            }

            final patientName = patientNameController.text.trim();
            final hospital = hospitalController.text.trim();
            final selectedBloodType = bloodType;
            final selectedUnits = int.parse(units);
            final selectedUrgency = urgency;
            final additionalNotes = notesController.text.trim();

            setDialogState(() => submitting = true);

            final result = await ApiService.createBloodRequest(
              userId: userId,
              patientName: patientName,
              bloodType: selectedBloodType,
              unitsNeeded: selectedUnits,
              hospital: hospital,
              notes: 'Urgency: $selectedUrgency\n$additionalNotes',
            );

            if (!dialogContext.mounted || !mounted) return;

            if (result['success'] == true) {
              Navigator.of(dialogContext).pop();

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Blood request submitted successfully!',
                  ),
                  backgroundColor: Colors.green,
                ),
              );

              patientNameController.dispose();
              hospitalController.dispose();
              notesController.dispose();
            } else {
              setDialogState(() => submitting = false);

              ScaffoldMessenger.of(dialogContext).showSnackBar(
                SnackBar(
                  content: Text(
                    result['message']?.toString() ??
                        'Failed to submit blood request.',
                  ),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }

          return AlertDialog(
            title: const Text('Create Blood Request'),
            content: SingleChildScrollView(
              child: SizedBox(
                width: 400,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: patientNameController,
                      enabled: !submitting,
                      decoration: const InputDecoration(
                        labelText: 'Patient Name',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: bloodType,
                      decoration: const InputDecoration(
                        labelText: 'Blood Type',
                        prefixIcon: Icon(Icons.bloodtype),
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(value: 'A+', child: Text('A+')),
                        DropdownMenuItem(value: 'A-', child: Text('A-')),
                        DropdownMenuItem(value: 'B+', child: Text('B+')),
                        DropdownMenuItem(value: 'B-', child: Text('B-')),
                        DropdownMenuItem(value: 'AB+', child: Text('AB+')),
                        DropdownMenuItem(value: 'AB-', child: Text('AB-')),
                        DropdownMenuItem(value: 'O+', child: Text('O+')),
                        DropdownMenuItem(value: 'O-', child: Text('O-')),
                      ],
                      onChanged: submitting
                          ? null
                          : (value) {
                              if (value != null) {
                                setDialogState(() => bloodType = value);
                              }
                            },
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: units,
                      decoration: const InputDecoration(
                        labelText: 'Units Needed',
                        prefixIcon: Icon(Icons.water_drop),
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(value: '1', child: Text('1 Unit')),
                        DropdownMenuItem(value: '2', child: Text('2 Units')),
                        DropdownMenuItem(value: '3', child: Text('3 Units')),
                        DropdownMenuItem(value: '4', child: Text('4 Units')),
                        DropdownMenuItem(value: '5', child: Text('5 Units')),
                      ],
                      onChanged: submitting
                          ? null
                          : (value) {
                              if (value != null) {
                                setDialogState(() => units = value);
                              }
                            },
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: hospitalController,
                      enabled: !submitting,
                      decoration: const InputDecoration(
                        labelText: 'Hospital',
                        prefixIcon: Icon(Icons.local_hospital),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    DropdownButtonFormField<String>(
                      initialValue: urgency,
                      decoration: const InputDecoration(
                        labelText: 'Urgency',
                        prefixIcon: Icon(Icons.warning),
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'Normal',
                          child: Text('Normal'),
                        ),
                        DropdownMenuItem(
                          value: 'High',
                          child: Text('High'),
                        ),
                        DropdownMenuItem(
                          value: 'Critical',
                          child: Text('Critical'),
                        ),
                      ],
                      onChanged: submitting
                          ? null
                          : (value) {
                              if (value != null) {
                                setDialogState(() => urgency = value);
                              }
                            },
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: notesController,
                      enabled: !submitting,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: 'Additional Notes',
                        prefixIcon: Icon(Icons.notes),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: submitting
                    ? null
                    : () => Navigator.of(dialogContext).pop(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: submitting ? null : submitRequest,
                child: submitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : const Text('Submit Request'),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blood Requests'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: loadDonors,
            icon: const Icon(Icons.refresh),
            tooltip: 'Refresh donors',
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Need Blood?',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Create a blood request and find available donors.',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: createRequest,
                    icon: const Icon(Icons.add),
                    label: const Text('Create Blood Request'),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Registered Donors',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: loadingDonors
                ? const Center(child: CircularProgressIndicator())
                : donorError != null
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(donorError!),
                              const SizedBox(height: 12),
                              ElevatedButton(
                                onPressed: loadDonors,
                                child: const Text('Try Again'),
                              ),
                            ],
                          ),
                        ),
                      )
                    : donors.isEmpty
                        ? const Center(child: Text('No donors found.'))
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            itemCount: donors.length,
                            itemBuilder: (context, index) {
                              final donor = donors[index];
                              final name =
                                  donor['name']?.toString() ??
                                      'Unknown Donor';
                              final blood =
                                  donor['blood_type']?.toString() ??
                                      'Unknown';
                              final location =
                                  donor['location']?.toString() ??
                                      'Location not provided';
                              final availability =
                                  donor['availability']?.toString() ??
                                      'Unknown';
                              final available =
                                  availability.toLowerCase() == 'available';

                              return Card(
                                margin: const EdgeInsets.only(bottom: 10),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    child: Text(
                                      blood,
                                      style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(location),
                                  trailing: Text(
                                    availability,
                                    style: TextStyle(
                                      color: available
                                          ? Colors.green
                                          : Colors.orange,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
          ),
        ],
      ),
    );
  }
}