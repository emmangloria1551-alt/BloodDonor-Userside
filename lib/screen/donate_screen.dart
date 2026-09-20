import 'package:blood_donor/model/blood_request_model.dart';
import 'package:blood_donor/widget/donation_activity.dart';
import 'package:flutter/material.dart';

class Donate extends StatefulWidget {
  const Donate({super.key});

  @override
  State<Donate> createState() => _DonateState();
}

class _DonateState extends State<Donate> {
  static const _donorBloodType = 'O+';
  final _searchController = TextEditingController();
  final _filterButtonKey = GlobalKey();
  String? _selectedBloodType;
  String? _selectedUrgency;

  final List<BloodRequest> _requests = [
    BloodRequest(
      id: '1',
      name: 'Juan Dela Cruz',
      email: 'juan.delacruz@example.com',
      contact: '0917 123 4567',
      bloodType: 'O+',
      units: 2,
      hospital: 'Community Hospital',
      location: 'Quezon City',
      urgency: 'Urgent',
      createdAt: DateTime(2026, 9, 16),
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _searchController.text.trim().toLowerCase();
    final requests =
        _requests.where((request) {
          final matchesSearch =
              query.isEmpty ||
              request.name.toLowerCase().contains(query) ||
              request.bloodType.toLowerCase().contains(query) ||
              request.hospital.toLowerCase().contains(query) ||
              request.location.toLowerCase().contains(query) ||
              request.email.toLowerCase().contains(query) ||
              request.contact.toLowerCase().contains(query) ||
              request.urgency.toLowerCase().contains(query);
          final matchesBloodType =
              _selectedBloodType == null ||
              request.bloodType == _selectedBloodType;
          final matchesUrgency =
              _selectedUrgency == null || request.urgency == _selectedUrgency;
          final matchesFilter = matchesBloodType && matchesUrgency;
          return matchesSearch && matchesFilter;
        }).toList()..sort((a, b) {
          final compatibility =
              _isCompatible(b.bloodType) == _isCompatible(a.bloodType)
              ? 0
              : (_isCompatible(b.bloodType) ? 1 : -1);
          return compatibility != 0
              ? compatibility
              : b.createdAt.compareTo(a.createdAt);
        });

    final hasActiveFilter =
        _selectedBloodType != null ||
        _selectedUrgency != null ||
        _searchController.text.trim().isNotEmpty;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Give blood. Give hope.',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          const SizedBox(height: 6),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Your donation can help a patient get the care they need. Find a request and make a difference today.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
            ),
          ),
          const SizedBox(height: 20),
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
                      hintText: 'Search requests...',
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
                  key: _filterButtonKey,
                  tooltip: 'Filter requests',
                  onSelected: (filter) {
                    if (filter == 'All') {
                      setState(() {
                        _selectedBloodType = null;
                        _selectedUrgency = null;
                      });
                    } else {
                      _showFilterItems(filter);
                    }
                  },
                  itemBuilder: (context) => const [
                    PopupMenuItem(value: 'All', child: Text('All requests')),
                    PopupMenuDivider(),
                    PopupMenuItem(
                      value: 'Blood type',
                      child: Text('Blood type                 ›'),
                    ),
                    PopupMenuItem(
                      value: 'Urgency',
                      child: Text('Urgency                       ›'),
                    ),
                  ],
                  icon: Icon(
                    Icons.tune_rounded,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
          if (hasActiveFilter)
            Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                spacing: 8,
                children: [
                  if (_selectedBloodType != null)
                    Chip(
                      avatar: const Icon(Icons.bloodtype_rounded, size: 16),
                      label: Text(_selectedBloodType!),
                      onDeleted: () =>
                          setState(() => _selectedBloodType = null),
                    ),
                  if (_selectedUrgency != null)
                    Chip(
                      avatar: const Icon(Icons.priority_high_rounded, size: 16),
                      label: Text(_selectedUrgency!),
                      onDeleted: () => setState(() => _selectedUrgency = null),
                    ),
                  if (_searchController.text.trim().isNotEmpty)
                    Chip(
                      avatar: const Icon(Icons.search_rounded, size: 16),
                      label: Text('"${_searchController.text.trim()}"'),
                      onDeleted: () => setState(_searchController.clear),
                    ),
                ],
              ),
            ),
          const SizedBox(height: 18),
          if (requests.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 48),
              child: Column(
                children: [
                  Icon(
                    Icons.search_off_rounded,
                    size: 48,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'No matching requests found',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Try another blood type, urgency, or search term.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: () => setState(() {
                      _selectedBloodType = null;
                      _selectedUrgency = null;
                      _searchController.clear();
                    }),
                    icon: const Icon(Icons.clear_all_rounded),
                    label: const Text('Clear filters'),
                  ),
                ],
              ),
            )
          else
            ...requests.map(
              (request) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: DonationActivityCard(
                  activity: request,
                  isCompatible: _isCompatible(request.bloodType),
                  onJoin: () => _confirmDonation(request),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _showFilterItems(String category) async {
    final renderObject =
        _filterButtonKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderObject == null || !mounted) {
      return;
    }

    final buttonRect =
        renderObject.localToGlobal(Offset.zero) & renderObject.size;
    final screenSize = MediaQuery.sizeOf(context);
    final items = category == 'Blood type'
        ? const [
            'All blood types',
            'A+',
            'A-',
            'B+',
            'B-',
            'AB+',
            'AB-',
            'O+',
            'O-',
          ]
        : const ['All urgency levels', 'Normal', 'Urgent', 'Critical'];

    final selected = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        buttonRect.left,
        buttonRect.bottom,
        screenSize.width - buttonRect.right,
        screenSize.height - buttonRect.bottom,
      ),
      items: items
          .map((item) => PopupMenuItem<String>(value: item, child: Text(item)))
          .toList(),
    );

    if (selected == null || !mounted) {
      return;
    }

    setState(() {
      if (category == 'Blood type') {
        _selectedBloodType = selected == 'All blood types' ? null : selected;
      } else {
        _selectedUrgency = selected == 'All urgency levels' ? null : selected;
      }
    });
  }

  bool _isCompatible(String recipientBloodType) {
    const compatibleRecipients = {
      'O+': {'O+'},
      'O-': {'O+', 'O-', 'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-'},
      'A+': {'A+', 'AB+'},
      'A-': {'A+', 'A-', 'AB+', 'AB-'},
      'B+': {'B+', 'AB+'},
      'B-': {'B+', 'B-', 'AB+', 'AB-'},
      'AB+': {'AB+'},
      'AB-': {'AB+', 'AB-'},
    };
    return compatibleRecipients[_donorBloodType]?.contains(
          recipientBloodType,
        ) ??
        false;
  }

  Future<void> _confirmDonation(BloodRequest request) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Help this patient?'),
        content: Text(
          'You are responding to ${request.name}\'s ${request.bloodType} '
          'request for ${request.units} ${request.units == 1 ? 'unit' : 'units'}.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton.icon(
            onPressed: () => Navigator.pop(context, true),
            icon: const Icon(Icons.volunteer_activism_rounded),
            label: const Text('Confirm'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Thank you for helping ${request.name}.')),
      );
    }
  }
}
