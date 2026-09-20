import 'package:flutter/material.dart';

import 'home.dart';
import 'register.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../widget/gradient_button.dart';
import '../widget/app_logo.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  bool obscurePassword = true;
  bool _registerHovered = false;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late final AnimationController _pulseController;

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textTheme = theme.textTheme;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? [AppColors.background, const Color(0xFF120D10)]
                : [const Color(0xFFFFF7F8), const Color(0xFFFFECEF)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Column(
                  children: [
                    const SizedBox(height: 12),
                    Text(
                      'COMMUNITY BLOOD DONOR',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.5,
                        color: isDark ? AppColors.primaryLight : AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const AppLogo(size: 88, iconSize: 44),
                    const SizedBox(height: 32),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(28),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface.withValues(
                          alpha: isDark ? 0.85 : 0.94,
                        ),
                        borderRadius: BorderRadius.circular(AppRadius.lg),
                        border: Border.all(
                          color: theme.dividerColor.withValues(
                            alpha: isDark ? 0.4 : 0.2,
                          ),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(
                              alpha: isDark ? 0.3 : 0.08,
                            ),
                            blurRadius: 30,
                            offset: const Offset(0, 15),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Welcome back',
                            textAlign: TextAlign.center,
                            style: textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Sign in to continue helping save lives.',
                            textAlign: TextAlign.center,
                            style: textTheme.bodyMedium?.copyWith(
                              color: textTheme.bodySmall?.color,
                            ),
                          ),
                          const SizedBox(height: 28),
                          Form(
                            key: _formKey,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            child: Column(
                              children: [
                        // Email
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            hintText: 'Enter your email',
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              size: 20,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Email is required';
                            }
                            final emailRegex = RegExp(
                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                            );
                            if (!emailRegex.hasMatch(value.trim())) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 18),

                        // Password
                        TextFormField(
                          controller: _passwordController,
                          obscureText: obscurePassword,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: 'Enter your password',
                            prefixIcon: const Icon(
                              Icons.lock_outline,
                              size: 20,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  obscurePassword = !obscurePassword;
                                });
                              },
                              icon: Icon(
                                obscurePassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                size: 20,
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Password is required';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 28),

                        // Login button
                        SizedBox(
                          width: double.infinity,
                          child: GradientButton(
                            label: 'LOGIN',
                            onTap: () {
                              if (_formKey.currentState!.validate()) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const HomeScreen(),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextButton(
                            onPressed: () {},
                            child: const Text('Forgot Password?'),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account? ",
                                style: textTheme.bodySmall?.copyWith(
                                  color: textTheme.bodySmall?.color,
                                ),
                              ),
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                onEnter: (_) =>
                                    setState(() => _registerHovered = true),
                                onExit: (_) =>
                                    setState(() => _registerHovered = false),
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) =>
                                            const RegisterScreen(),
                                      ),
                                    );
                                  },
                                  child: AnimatedDefaultTextStyle(
                                    duration:
                                        const Duration(milliseconds: 150),
                                    style: TextStyle(
                                      color: _registerHovered
                                          ? AppColors.primary
                                          : AppColors.primaryLight,
                                      fontWeight: FontWeight.w700,
                                      fontSize: _registerHovered ? 14 : 13,
                                      decoration: _registerHovered
                                          ? TextDecoration.underline
                                          : TextDecoration.none,
                                    ),
                                    child: const Text('Register'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}