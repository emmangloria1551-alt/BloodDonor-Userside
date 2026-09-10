import 'package:blood_donor/Home.dart';
import 'package:flutter/material.dart';
import 'Theme.dart';
import 'Transition.dart';
import 'Common.dart';
import 'Register.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  bool _obscure = true;
  late final AnimationController _pulse = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1600),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.darkFade),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 24),
                  FadeSlideIn(
                    child: ScaleTransition(
                      scale: Tween(begin: 0.94, end: 1.05).animate(
                        CurvedAnimation(parent: _pulse, curve: Curves.easeInOut),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(22),
                        decoration: BoxDecoration(
                          gradient: AppColors.bloodGradient,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.45),
                              blurRadius: 30,
                              spreadRadius: 4,
                            ),
                          ],
                        ),
                        child: const Icon(Icons.water_drop,
                            color: Colors.white, size: 44),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const FadeSlideIn(
                    delayMs: 80,
                    child: Text(
                      'COMMUNITY BLOOD DONOR',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  FadeSlideIn(
                    delayMs: 120,
                    child: Text(
                      'Be there when someone need you most!',
                      style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
                    ),
                  ),
                  const SizedBox(height: 36),
                  FadeSlideIn(
                    delayMs: 160,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Email',
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                        const SizedBox(height: 8),
                        TextField(
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            hintText: 'Enter email',
                            prefixIcon: Icon(Icons.email_outlined, size: 20),
                          ),
                        ),
                        const SizedBox(height: 18),
                        const Text('Password',
                            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                        const SizedBox(height: 8),
                        TextField(
                          obscureText: _obscure,
                          decoration: InputDecoration(
                            hintText: '••••••••••',
                            prefixIcon: const Icon(Icons.lock_outline, size: 20),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscure
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                size: 20,
                                color: AppColors.textMuted,
                              ),
                              onPressed: () => setState(() => _obscure = !_obscure),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  FadeSlideIn(
                    delayMs: 200,
                    child: GradientButton(
                      label: 'LOGIN',
                      onTap: () {
                       Navigator.push(context,
                           MaterialPageRoute(builder: (context)=> HomeScreen()));
                      },
                    ),
                  ),
                  const SizedBox(height: 18),
                  FadeSlideIn(
                    delayMs: 240,
                    child: TextButton(
                      onPressed: () {},
                      child: const Text('Forgot Password?',
                          style: TextStyle(color: AppColors.primaryLight)),
                    ),
                  ),
                  FadeSlideIn(
                    delayMs: 260,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account? ",
                            style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                        GestureDetector(
                          onTap: () => pushSlideFade(context, const RegisterScreen()),
                          child: const Text('Register',
                              style: TextStyle(
                                  color: AppColors.primaryLight,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 13)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
