import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../widget/gradient_button.dart';
import 'login.dart';
import '../services/api_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _contactController = TextEditingController();
  final _locationController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String? _bloodType;

  final List<String> _bloodTypes = [
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-',
  ];

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  bool _isRegistering = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _contactController.dispose();
    _locationController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // ============================================================
  // REGISTER ACCOUNT
  // ============================================================

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isRegistering = true;
    });

    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    final result = await ApiService.register(
      name: name,
      email: email,
      password: password,
      bloodType: _bloodType,
    );

    if (!mounted) {
      return;
    }

    setState(() {
      _isRegistering = false;
    });

    if (result['success'] == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Account created successfully! Please login.',
          ),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        ),
      );
    } else {
      String message =
          result['message']?.toString() ?? 'Registration failed.';

      final errors = result['errors'];

      if (errors is Map) {
        final errorMessages = <String>[];

        for (final value in errors.values) {
          if (value is List && value.isNotEmpty) {
            errorMessages.add(value.first.toString());
          }
        }

        if (errorMessages.isNotEmpty) {
          message = errorMessages.join('\n');
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Account'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 18),
            child: Icon(
              Icons.verified_user_outlined,
              color: theme.colorScheme.primary,
            ),
          ),
        ],
      ),
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [
                    AppColors.background,
                    const Color(0xFF120D10),
                  ]
                : [
                    const Color(0xFFFFF7F8),
                    const Color(0xFFFFECEF),
                  ],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 28),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface.withValues(
                      alpha: isDark ? 0.92 : 0.96,
                    ),
                    borderRadius: BorderRadius.circular(
                      AppRadius.lg,
                    ),
                    border: Border.all(
                      color: theme.dividerColor.withValues(
                        alpha: 0.55,
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(
                          alpha: isDark ? 0.12 : 0.07,
                        ),
                        blurRadius: 24,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(
                                alpha: 0.12,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.person_add_alt_1_rounded,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Join the donor community',
                                  style:
                                      theme.textTheme.titleLarge,
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  'Create your account and help save lives.',
                                  style: theme.textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // NAME
                      _Field(
                        label: 'Full Name',
                        icon: Icons.badge_outlined,
                        controller: _nameController,
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty) {
                            return 'Please enter your full name';
                          }

                          if (value.trim().length < 2) {
                            return 'Name is too short';
                          }

                          return null;
                        },
                      ),

                      // EMAIL
                      _Field(
                        label: 'Email',
                        icon: Icons.email_outlined,
                        keyboardType:
                            TextInputType.emailAddress,
                        controller: _emailController,
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty) {
                            return 'Please enter your email';
                          }

                          final emailRegex = RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          );

                          if (!emailRegex.hasMatch(
                            value.trim(),
                          )) {
                            return 'Please enter a valid email';
                          }

                          return null;
                        },
                      ),

                      // CONTACT
                      _Field(
                        label: 'Contact Number',
                        icon: Icons.phone_outlined,
                        keyboardType: TextInputType.phone,
                        controller: _contactController,
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty) {
                            return 'Please enter your contact number';
                          }

                          if (value.trim().length < 11 ||
                              value.trim().length > 12) {
                            return 'Please enter a valid contact number';
                          }

                          return null;
                        },
                      ),

                      // ADDRESS
                      _Field(
                        label: 'Address',
                        icon: Icons.location_on_outlined,
                        controller: _locationController,
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty) {
                            return 'Please enter your address';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 4),

                      // BLOOD TYPE
                      DropdownButtonFormField<String>(
                        initialValue: _bloodType,
                        dropdownColor:
                            theme.colorScheme.surface,
                        style: TextStyle(
                          color: theme.colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: InputDecoration(
                          labelText: 'Blood Type',
                          prefixIcon: Icon(
                            Icons.water_drop_outlined,
                            size: 20,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        hint: const Text(
                          'Select blood type',
                        ),
                        items: _bloodTypes
                            .map(
                              (bloodType) =>
                                  DropdownMenuItem<String>(
                                value: bloodType,
                                child: Text(
                                  bloodType,
                                  style: TextStyle(
                                    color: theme
                                        .colorScheme.onSurface,
                                    fontWeight:
                                        FontWeight.w600,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _bloodType = value;
                          });
                        },
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty) {
                            return 'Please select your blood type';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      // PASSWORD
                      _Field(
                        label: 'Password',
                        icon: Icons.lock_outline,
                        obscureText: !_passwordVisible,
                        controller: _passwordController,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _passwordVisible =
                                  !_passwordVisible;
                            });
                          },
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty) {
                            return 'Please enter your password';
                          }

                          if (value.length < 8) {
                            return 'Password must be at least 8 characters';
                          }

                          return null;
                        },
                      ),

                      // CONFIRM PASSWORD
                      _Field(
                        label: 'Confirm Password',
                        icon: Icons.lock_outline,
                        obscureText:
                            !_confirmPasswordVisible,
                        controller:
                            _confirmPasswordController,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _confirmPasswordVisible =
                                  !_confirmPasswordVisible;
                            });
                          },
                          icon: Icon(
                            _confirmPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty) {
                            return 'Please confirm your password';
                          }

                          if (value !=
                              _passwordController.text) {
                            return 'Passwords do not match';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 18),

                      // CREATE ACCOUNT BUTTON
                      SizedBox(
                        width: double.infinity,
                        child: _isRegistering
                            ? const Center(
                                child:
                                    CircularProgressIndicator(),
                              )
                            : GradientButton(
                                label: 'CREATE ACCOUNT',
                                onTap: _register,
                              ),
                      ),

                      const SizedBox(height: 14),

                      Align(
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account?',
                              style:
                                  theme.textTheme.bodySmall,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        const LoginScreen(),
                                  ),
                                );
                              },
                              child: const Text('Login'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// REUSABLE TEXT FIELD
// ============================================================

class _Field extends StatelessWidget {
  const _Field({
    required this.label,
    required this.icon,
    required this.controller,
    required this.validator,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
  });

  final String label;
  final IconData icon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator: validator,
          autovalidateMode:
              AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            labelText: label,
            hintText:
                'Enter ${label.toLowerCase()}',
            prefixIcon: Icon(
              icon,
              size: 20,
            ),
            suffixIcon: suffixIcon,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}