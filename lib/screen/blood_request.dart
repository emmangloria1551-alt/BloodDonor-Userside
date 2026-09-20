import 'package:flutter/material.dart';

import '../model/blood_donor.dart';
import '../widget/blood_donor.dart';

class BloodRequestScreen extends StatefulWidget {
  const BloodRequestScreen({super.key});

  @override
  State<BloodRequestScreen> createState() => _BloodRequestScreenState();
}

class _BloodRequestScreenState extends State<BloodRequestScreen> {
  final _requestFormKey = GlobalKey<FormState>();
  final _searchController = TextEditingController();
  String? _selectedBloodType;
  final _locationController = TextEditingController();
  String _requestedBloodType = 'O+';
  String _requestedUrgency = 'Urgent';
  int _requestedUnits = 1;

  final List<BloodDonor> _donors = [
    BloodDonor(
      name: 'Juan Dela Cruz',
      email: 'juan.delacruz@example.com',
      bloodType: 'O+',
      contact: '0917 123 4567',
      location: 'Quezon City',
      unitsNeeded: 2,
      urgency: 'Urgent',
      requestedAt: DateTime(2026, 9, 16),
      isAvailable: true,
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _showCreateRequestDialog() async {
    _locationController.clear();
    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            final theme = Theme.of(context);
            final foregroundColor = theme.colorScheme.onSurface;
            final iconColor = theme.colorScheme.primary;

            return AlertDialog(
              titlePadding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
              contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
              title: Row(
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.bloodtype_rounded,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Create Blood Request',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: foregroundColor,
                      ),
                    ),
                  ),
                ],
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Form(
                      key: _requestFormKey,
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Tell us what is needed so nearby donors can respond quickly.',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.textTheme.bodySmall?.color,
                              ),
                            ),
                          ),
                          const SizedBox(height: 18),
                          DropdownButtonFormField<String>(
                            initialValue: _requestedBloodType,
                            decoration: InputDecoration(
                              labelText: 'Blood type',
                              prefixIcon: Icon(
                                Icons.bloodtype_outlined,
                                color: iconColor,
                              ),
                            ),
                            items:
                                const [
                                      'A+',
                                      'A-',
                                      'B+',
                                      'B-',
                                      'AB+',
                                      'AB-',
                                      'O+',
                                      'O-',
                                    ]
                                    .map(
                                      (type) => DropdownMenuItem(
                                        value: type,
                                        child: Text(
                                          type,
                                          style: TextStyle(
                                            color: foregroundColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    )
                                    .toList(),
                            onChanged: (value) {
                              if (value != null) {
                                setDialogState(() {
                                  _requestedBloodType = value;
                                });
                              }
                            },
                          ),
                          const SizedBox(height: 12),
                          DropdownButtonFormField<int>(
                            initialValue: _requestedUnits,
                            decoration: InputDecoration(
                              labelText: 'Units needed',
                              prefixIcon: Icon(
                                Icons.water_drop_outlined,
                                color: iconColor,
                              ),
                            ),
                            items: [1, 2, 3, 4, 5]
                                .map(
                                  (units) => DropdownMenuItem(
                                    value: units,
                                    child: Text(
                                      '$units ${units == 1 ? 'unit' : 'units'}',
                                      style: TextStyle(
                                        color: foregroundColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              if (value != null) {
                                setDialogState(() {
                                  _requestedUnits = value;
                                });
                              }
                            },
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _locationController,
                            textCapitalization: TextCapitalization.words,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return 'Enter a hospital or location';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Hospital or location',
                              hintText: 'e.g. Community Hospital',
                              prefixIcon: Icon(
                                Icons.location_on_outlined,
                                color: iconColor,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          DropdownButtonFormField<String>(
                            initialValue: _requestedUrgency,
                            decoration: InputDecoration(
                              labelText: 'Urgency',
                              prefixIcon: Icon(
                                Icons.priority_high_rounded,
                                color: iconColor,
                              ),
                            ),
                            items: const ['Normal', 'Urgent', 'Critical']
                                .map(
                                  (urgency) => DropdownMenuItem(
                                    value: urgency,
                                    child: Text(
                                      urgency,
                                      style: TextStyle(
                                        color: foregroundColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: (value) {
                              if (value != null) {
                                setDialogState(() {
                                  _requestedUrgency = value;
                                });
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Cancel'),
                ),
                FilledButton.icon(
                  onPressed: () {
                    if (!_requestFormKey.currentState!.validate()) {
                      return;
                    }

                    Navigator.pop(dialogContext);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '$_requestedBloodType blood request created for '
                          '$_requestedUnits ${_requestedUnits == 1 ? 'unit' : 'units'}.',
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.send_rounded),
                  label: const Text('Submit Request'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.trim().toLowerCase();
    final filteredDonors = _donors.where((donor) {
      final matchesSearch =
          query.isEmpty ||
          donor.name.toLowerCase().contains(query) ||
          donor.bloodType.toLowerCase().contains(query) ||
          donor.location.toLowerCase().contains(query) ||
          donor.contact.toLowerCase().contains(query);
      return matchesSearch &&
          (_selectedBloodType == null || donor.bloodType == _selectedBloodType);
    }).toList();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Find a donor when it matters most.',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
          ),
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Search nearby requests and connect with an available donor.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
            ),
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: Theme.of(context).dividerColor.withValues(alpha: 0.35),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: (_) => setState(() {}),
                    decoration: InputDecoration(
                      hintText: 'Search donors...',
                      prefixIcon: const Icon(Icons.search_rounded),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.surface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                PopupMenuButton<String>(
                  tooltip: 'Filter requests',
                  onSelected: (filter) => setState(
                    () =>
                        _selectedBloodType = filter == 'All' ? null : filter,
                  ),
                  itemBuilder: (context) => const [
                    PopupMenuItem(
                      value: 'All',
                      child: Text('All blood types'),
                    ),
                    PopupMenuItem(value: 'A+', child: Text('A+')),
                    PopupMenuItem(value: 'A-', child: Text('A-')),
                    PopupMenuItem(value: 'B+', child: Text('B+')),
                    PopupMenuItem(value: 'B-', child: Text('B-')),
                    PopupMenuItem(value: 'AB+', child: Text('AB+')),
                    PopupMenuItem(value: 'AB-', child: Text('AB-')),
                    PopupMenuItem(value: 'O+', child: Text('O+')),
                    PopupMenuItem(value: 'O-', child: Text('O-')),
                  ],
                  icon: Icon(
                    Icons.tune_rounded,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          if (_selectedBloodType != null) ...[
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Chip(
                avatar: const Icon(Icons.bloodtype_rounded, size: 17),
                label: Text(_selectedBloodType!),
                onDeleted: () => setState(() => _selectedBloodType = null),
              ),
            ),
          ],
          const SizedBox(height: 16),
          if (filteredDonors.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 48),
              child: Column(
                children: [
                  Icon(
                    Icons.search_off_rounded,
                    size: 52,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'No blood requests found',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Try a different search or filter.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            )
          else
            ...filteredDonors.map(
              (donor) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: BloodDonorCard(
                  donor: donor,
                  onRequestBlood: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Blood request selected for ${donor.name}',
                        ),
                        backgroundColor: Theme.of(context).colorScheme.error,
                      ),
                    );
                  },
                ),
              ),
            ),
          const SizedBox(height: 18),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Theme.of(
                  context,
                ).colorScheme.primary.withValues(alpha: 0.25),
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(
                    context,
                  ).colorScheme.primary.withValues(alpha: 0.08),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Theme.of(
                          context,
                        ).colorScheme.primary.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.bloodtype_rounded,
                        color: Theme.of(context).colorScheme.primary,
                        size: 26,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'No compatible donor yet?',
                            style: Theme.of(context).textTheme.titleMedium
                                ?.copyWith(fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Your request can reach donors who are ready to help.',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  'Create a request now and give your community a chance to save a life.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: _showCreateRequestDialog,
                    icon: const Icon(Icons.bloodtype_rounded),
                    label: const Text('Make a Blood Request'),
                    style: FilledButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
