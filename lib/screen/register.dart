import 'package:flutter/material.dart';
import 'home.dart';
import '../../theme/app_colors.dart';
import '../widget/gradient_button.dart';

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
  final List<String> _bloodTypes = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Account')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Field(
                label: 'Full Name',
                icon: Icons.badge_outlined,
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your full name';
                  }
                  if (value.trim().length < 2) {
                    return 'Name is too short';
                  }
                  return null;
                },
              ),
              _Field(
                label: 'Email',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your email';
                  }
                  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                  if (!emailRegex.hasMatch(value.trim())) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              _Field(
                label: 'Contact Number',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                controller: _contactController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your contact number';
                  }
                  if (value.trim().length < 11 || value.trim().length > 12) {
                    return 'Please enter a valid contact number';
                  }
                  return null;
                },
              ),
              _Field(
                label: 'Address',
                icon: Icons.location_on_outlined,
                controller: _locationController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              const Text('Blood Type', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                initialValue: _bloodType,
                dropdownColor: AppColors.surfaceElevated,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.water_drop_outlined, size: 20),
                ),
                hint: const Text('Select blood type'),
                items: _bloodTypes
                    .map((bloodType) => DropdownMenuItem(value: bloodType, child: Text(bloodType)))
                    .toList(),
                onChanged: (value) => setState(() => _bloodType = value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select your blood type';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              _Field(
                label: 'Password',
                icon: Icons.lock_outline,
                obscureText: !_passwordVisible,
                controller: _passwordController,
                suffixIcon: IconButton(
                  onPressed: () => setState(() => _passwordVisible = !_passwordVisible),
                  icon: Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 8) {
                    return 'Password must be at least 8 characters';
                  }
                  return null;
                },
              ),
              _Field(
                label: 'Confirm Password',
                icon: Icons.lock_outline,
                obscureText: !_confirmPasswordVisible,
                controller: _confirmPasswordController,
                suffixIcon: IconButton(
                  onPressed: () => setState(() => _confirmPasswordVisible = !_confirmPasswordVisible),
                  icon: Icon(_confirmPasswordVisible ? Icons.visibility : Icons.visibility_off),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your password';
                  }
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: GradientButton(
                  label: 'CREATE ACCOUNT',
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const HomeScreen()),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account?', style: TextStyle(color: Colors.grey, fontSize: 12)),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => const HomeScreen()),
                        );
                      },
                      child: const Text('Login', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w800)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            hintText: 'Enter $label',
            prefixIcon: Icon(icon, size: 20),
            suffixIcon: suffixIcon,
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
