import 'package:blood_donor/model/blood_request_model.dart';
import 'package:blood_donor/widget/donation_activity.dart';
import 'package:blood_donor/services/api_service.dart';
import 'package:blood_donor/services/user_session.dart';
import 'package:flutter/material.dart';

class Donate extends StatefulWidget {
  const Donate({super.key});

  @override
  State<Donate> createState() => _DonateState();
}

class _DonateState extends State<Donate> {
  // ============================================================
  // DONOR BLOOD TYPE
  // ============================================================

  static const _donorBloodType = 'O+';

  // ============================================================
  // CONTROLLERS
  // ============================================================

  final _searchController = TextEditingController();
  final _filterButtonKey = GlobalKey();

  // ============================================================
  // FILTERS
  // ============================================================

  String? _selectedBloodType;
  String? _selectedUrgency;

  // ============================================================
  // API DATA
  // ============================================================

  List<BloodRequest> _requests = [];

  bool _isLoading = true;
  String? _errorMessage;

  // ============================================================
  // INIT
  // ============================================================

  @override
  void initState() {
    super.initState();
    _loadBloodRequests();
  }

  // ============================================================
  // DISPOSE
  // ============================================================

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // ============================================================
  // LOAD BLOOD REQUESTS FROM LARAVEL
  // ============================================================

  Future<void> _loadBloodRequests() async {
    if (mounted) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });
    }

    final result = await ApiService.getBloodRequests();

    if (!mounted) {
      return;
    }

    if (result['success'] == true) {
      final rawRequests = result['requests'];

      if (rawRequests is List) {
        final loadedRequests = <BloodRequest>[];

        for (final item in rawRequests) {
          if (item is Map) {
            loadedRequests.add(
              _convertApiRequest(
                Map<String, dynamic>.from(item),
              ),
            );
          }
        }

        setState(() {
          _requests = loadedRequests;
          _isLoading = false;
          _errorMessage = null;
        });
      } else {
        setState(() {
          _requests = [];
          _isLoading = false;
          _errorMessage = 'No blood requests were returned.';
        });
      }
    } else {
      setState(() {
        _isLoading = false;
        _errorMessage =
            result['message']?.toString() ??
            'Unable to load blood requests.';
      });
    }
  }

  // ============================================================
  // CONVERT LARAVEL DATA TO BLOOD REQUEST MODEL
  // ============================================================

  BloodRequest _convertApiRequest(
    Map<String, dynamic> data,
  ) {
    final id = data['id']?.toString() ?? '';

    final patientName =
        data['patient_name']?.toString() ??
        'Unknown Patient';

    final bloodType =
        data['blood_type']?.toString() ??
        'Unknown';

    final hospital =
        data['hospital']?.toString() ??
        'Unknown Hospital';

    final notes =
        data['notes']?.toString() ??
        '';

    final units =
        int.tryParse(
          data['units_needed']?.toString() ?? '1',
        ) ??
        1;

    DateTime createdAt = DateTime.now();

    final createdAtValue = data['created_at'];

    if (createdAtValue != null) {
      final parsedDate = DateTime.tryParse(
        createdAtValue.toString(),
      );

      if (parsedDate != null) {
        createdAt = parsedDate;
      }
    }

    // The current Laravel blood_requests table does not
    // have separate email, contact, location, or urgency
    // columns. We therefore use available database values
    // to keep the existing Flutter UI working.

    String urgency = 'Normal';

    final lowerNotes = notes.toLowerCase();

    if (lowerNotes.contains('critical')) {
      urgency = 'Critical';
    } else if (lowerNotes.contains('urgent')) {
      urgency = 'Urgent';
    }

    return BloodRequest(
      id: id,
      name: patientName,
      email: '',
      contact: '',
      bloodType: bloodType,
      units: units,
      hospital: hospital,
      location: hospital,
      urgency: urgency,
      createdAt: createdAt,
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final query =
        _searchController.text.trim().toLowerCase();

    final requests =
        _requests.where((request) {
          final matchesSearch =
              query.isEmpty ||
              request.name
                  .toLowerCase()
                  .contains(query) ||
              request.bloodType
                  .toLowerCase()
                  .contains(query) ||
              request.hospital
                  .toLowerCase()
                  .contains(query) ||
              request.location
                  .toLowerCase()
                  .contains(query) ||
              request.email
                  .toLowerCase()
                  .contains(query) ||
              request.contact
                  .toLowerCase()
                  .contains(query) ||
              request.urgency
                  .toLowerCase()
                  .contains(query);

          final matchesBloodType =
              _selectedBloodType == null ||
              request.bloodType ==
                  _selectedBloodType;

          final matchesUrgency =
              _selectedUrgency == null ||
              request.urgency ==
                  _selectedUrgency;

          return matchesSearch &&
              matchesBloodType &&
              matchesUrgency;
        }).toList()
          ..sort((a, b) {
            final bCompatible =
                _isCompatible(b.bloodType);

            final aCompatible =
                _isCompatible(a.bloodType);

            final compatibility =
                bCompatible == aCompatible
                    ? 0
                    : (bCompatible ? 1 : -1);

            return compatibility != 0
                ? compatibility
                : b.createdAt.compareTo(
                    a.createdAt,
                  );
          });

    final hasActiveFilter =
        _selectedBloodType != null ||
        _selectedUrgency != null ||
        _searchController.text.trim().isNotEmpty;

    return RefreshIndicator(
      onRefresh: _loadBloodRequests,
      child: SingleChildScrollView(
        physics:
            const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // ==================================================
            // HEADER
            // ==================================================

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Give blood. Give hope.',
                style:
                    Theme.of(
                      context,
                    ).textTheme.headlineSmall,
              ),
            ),

            const SizedBox(height: 6),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Your donation can help a patient get '
                'the care they need. Find a request '
                'and make a difference today.',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(
                      color: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.color,
                    ),
              ),
            ),

            const SizedBox(height: 20),

            // ==================================================
            // SEARCH AND FILTER
            // ==================================================

            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .surfaceContainerHighest
                    .withValues(alpha: 0.6),
                borderRadius:
                    BorderRadius.circular(18),
                border: Border.all(
                  color: Theme.of(context)
                      .dividerColor
                      .withValues(alpha: 0.35),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller:
                          _searchController,
                      onChanged: (_) {
                        setState(() {});
                      },
                      decoration:
                          InputDecoration(
                        hintText:
                            'Search requests...',
                        prefixIcon:
                            const Icon(
                          Icons.search_rounded,
                        ),
                        filled: true,
                        fillColor:
                            Theme.of(context)
                                .colorScheme
                                .surface,
                        border:
                            OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(
                            14,
                          ),
                          borderSide:
                              BorderSide.none,
                        ),
                        enabledBorder:
                            OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(
                            14,
                          ),
                          borderSide:
                              BorderSide.none,
                        ),
                        focusedBorder:
                            OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(
                            14,
                          ),
                          borderSide: BorderSide(
                            color:
                                Theme.of(context)
                                    .colorScheme
                                    .primary,
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
                    itemBuilder:
                        (context) => const [
                      PopupMenuItem(
                        value: 'All',
                        child:
                            Text('All requests'),
                      ),
                      PopupMenuDivider(),
                      PopupMenuItem(
                        value: 'Blood type',
                        child: Text(
                          'Blood type                 ›',
                        ),
                      ),
                      PopupMenuItem(
                        value: 'Urgency',
                        child: Text(
                          'Urgency                       ›',
                        ),
                      ),
                    ],
                    icon: Icon(
                      Icons.tune_rounded,
                      color:
                          Theme.of(context)
                              .colorScheme
                              .primary,
                    ),
                  ),
                ],
              ),
            ),

            // ==================================================
            // ACTIVE FILTERS
            // ==================================================

            if (hasActiveFilter)
              Align(
                alignment:
                    Alignment.centerLeft,
                child: Wrap(
                  spacing: 8,
                  children: [
                    if (_selectedBloodType != null)
                      Chip(
                        avatar: const Icon(
                          Icons.bloodtype_rounded,
                          size: 16,
                        ),
                        label: Text(
                          _selectedBloodType!,
                        ),
                        onDeleted: () {
                          setState(() {
                            _selectedBloodType =
                                null;
                          });
                        },
                      ),

                    if (_selectedUrgency != null)
                      Chip(
                        avatar: const Icon(
                          Icons.priority_high_rounded,
                          size: 16,
                        ),
                        label: Text(
                          _selectedUrgency!,
                        ),
                        onDeleted: () {
                          setState(() {
                            _selectedUrgency =
                                null;
                          });
                        },
                      ),

                    if (_searchController.text
                        .trim()
                        .isNotEmpty)
                      Chip(
                        avatar: const Icon(
                          Icons.search_rounded,
                          size: 16,
                        ),
                        label: Text(
                          '"${_searchController.text.trim()}"',
                        ),
                        onDeleted: () {
                          setState(() {
                            _searchController
                                .clear();
                          });
                        },
                      ),
                  ],
                ),
              ),

            const SizedBox(height: 18),

            // ==================================================
            // LOADING
            // ==================================================

            if (_isLoading)
              Padding(
                padding:
                    const EdgeInsets.symmetric(
                  vertical: 60,
                ),
                child: Column(
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 16),
                    Text(
                      'Loading blood requests...',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium,
                    ),
                  ],
                ),
              )

            // ==================================================
            // ERROR
            // ==================================================

            else if (_errorMessage != null)
              Padding(
                padding:
                    const EdgeInsets.symmetric(
                  vertical: 40,
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons
                          .cloud_off_rounded,
                      size: 52,
                      color: Theme.of(context)
                          .colorScheme
                          .error,
                    ),

                    const SizedBox(height: 14),

                    Text(
                      'Unable to load requests',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium,
                    ),

                    const SizedBox(height: 8),

                    Text(
                      _errorMessage!,
                      textAlign:
                          TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium,
                    ),

                    const SizedBox(height: 18),

                    FilledButton.icon(
                      onPressed:
                          _loadBloodRequests,
                      icon: const Icon(
                        Icons.refresh_rounded,
                      ),
                      label:
                          const Text('Try again'),
                    ),
                  ],
                ),
              )

            // ==================================================
            // EMPTY
            // ==================================================

            else if (requests.isEmpty)
              Padding(
                padding:
                    const EdgeInsets.symmetric(
                  vertical: 48,
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons
                          .search_off_rounded,
                      size: 48,
                      color: Theme.of(context)
                          .colorScheme
                          .primary,
                    ),

                    const SizedBox(height: 12),

                    Text(
                      hasActiveFilter
                          ? 'No matching requests found'
                          : 'No blood requests available',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium,
                    ),

                    const SizedBox(height: 6),

                    Text(
                      hasActiveFilter
                          ? 'Try another blood type, '
                              'urgency, or search term.'
                          : 'There are currently no '
                              'blood requests.',
                      textAlign:
                          TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium,
                    ),

                    const SizedBox(height: 16),

                    if (hasActiveFilter)
                      OutlinedButton.icon(
                        onPressed: () {
                          setState(() {
                            _selectedBloodType =
                                null;
                            _selectedUrgency =
                                null;
                            _searchController
                                .clear();
                          });
                        },
                        icon: const Icon(
                          Icons.clear_all_rounded,
                        ),
                        label: const Text(
                          'Clear filters',
                        ),
                      ),
                  ],
                ),
              )

            // ==================================================
            // BLOOD REQUEST LIST
            // ==================================================

            else
              ...requests.map(
                (request) => Padding(
                  padding:
                      const EdgeInsets.only(
                    bottom: 16,
                  ),
                  child:
                      DonationActivityCard(
                    activity: request,
                    isCompatible:
                        _isCompatible(
                      request.bloodType,
                    ),
                    onJoin: () =>
                        _confirmDonation(
                      request,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // FILTER MENU
  // ============================================================

  Future<void> _showFilterItems(
    String category,
  ) async {
    final renderObject =
        _filterButtonKey.currentContext
                ?.findRenderObject()
            as RenderBox?;

    if (renderObject == null ||
        !mounted) {
      return;
    }

    final buttonRect =
        renderObject.localToGlobal(
              Offset.zero,
            ) &
            renderObject.size;

    final screenSize =
        MediaQuery.sizeOf(context);

    final items =
        category == 'Blood type'
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
            : const [
                'All urgency levels',
                'Normal',
                'Urgent',
                'Critical',
              ];

    final selected =
        await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        buttonRect.left,
        buttonRect.bottom,
        screenSize.width -
            buttonRect.right,
        screenSize.height -
            buttonRect.bottom,
      ),
      items: items
          .map(
            (item) =>
                PopupMenuItem<String>(
              value: item,
              child: Text(item),
            ),
          )
          .toList(),
    );

    if (selected == null ||
        !mounted) {
      return;
    }

    setState(() {
      if (category == 'Blood type') {
        _selectedBloodType =
            selected ==
                    'All blood types'
                ? null
                : selected;
      } else {
        _selectedUrgency =
            selected ==
                    'All urgency levels'
                ? null
                : selected;
      }
    });
  }

  // ============================================================
  // BLOOD COMPATIBILITY
  // ============================================================

  bool _isCompatible(
    String recipientBloodType,
  ) {
    const compatibleRecipients = {
      'O+': {'O+'},
      'O-': {
        'O+',
        'O-',
        'A+',
        'A-',
        'B+',
        'B-',
        'AB+',
        'AB-',
      },
      'A+': {
        'A+',
        'AB+',
      },
      'A-': {
        'A+',
        'A-',
        'AB+',
        'AB-',
      },
      'B+': {
        'B+',
        'AB+',
      },
      'B-': {
        'B+',
        'B-',
        'AB+',
        'AB-',
      },
      'AB+': {
        'AB+',
      },
      'AB-': {
        'AB+',
        'AB-',
      },
    };

    return compatibleRecipients[
          _donorBloodType
        ]?.contains(
          recipientBloodType,
        ) ??
        false;
  }

  // ============================================================
  // CONFIRM DONATION
  // ============================================================

  Future<void> _confirmDonation(
    BloodRequest request,
  ) async {
    final confirmed =
        await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text(
              'Help this patient?',
            ),
            content: Text(
              'You are responding to '
              '${request.name}\'s '
              '${request.bloodType} request '
              'for ${request.units} '
              '${request.units == 1 ? 'unit' : 'units'}.',
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                    false,
                  );
                },
                child:
                    const Text('Cancel'),
              ),

              FilledButton.icon(
                onPressed: () {
                  Navigator.pop(
                    context,
                    true,
                  );
                },
                icon: const Icon(
                  Icons
                      .volunteer_activism_rounded,
                ),
                label: const Text(
                  'Confirm',
                ),
              ),
            ],
          ),
    );

    if (confirmed != true ||
        !mounted) {
      return;
    }

    // ==========================================================
    // CHECK LOGIN
    // ==========================================================

    final userId =
        UserSession.userId;

    if (userId == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'Please login before responding '
            'to a donation request.',
          ),
        ),
      );
      return;
    }

    // ==========================================================
    // SAVE MESSENGER
    // ==========================================================

    final messenger =
        ScaffoldMessenger.of(context);

    // ==========================================================
    // CONVERT REQUEST ID
    // ==========================================================

    final bloodRequestId =
        int.tryParse(request.id);

    if (bloodRequestId == null) {
      messenger.showSnackBar(
        const SnackBar(
          content: Text(
            'Invalid blood request ID.',
          ),
        ),
      );
      return;
    }

    // ==========================================================
    // SEND DONATION RESPONSE TO LARAVEL
    // ==========================================================

    final result =
        await ApiService.respondToDonation(
      userId: userId,
      bloodRequestId:
          bloodRequestId,
    );

    if (!mounted) {
      return;
    }

    // ==========================================================
    // SUCCESS
    // ==========================================================

    if (result['success'] == true) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            result['message']?.toString() ??
                'Donation response submitted successfully.',
          ),
        ),
      );
    }

    // ==========================================================
    // ERROR
    // ==========================================================

    else {
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            result['message']?.toString() ??
                'Unable to submit donation response.',
          ),
        ),
      );
    }
  }
}