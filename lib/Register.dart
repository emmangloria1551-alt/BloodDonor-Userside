import 'package:blood_donor/Home.dart';
import 'package:flutter/material.dart';
import 'Theme.dart';
import 'Common.dart';
import 'Login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? _bloodType;
  final _bloodTypes = ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'];
  final _formkey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _contactController = TextEditingController();
  final _locationController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _Password =true;
  bool _Confirmpassword = true;
  
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


  Widget _field(String label, 
      {
        required IconData icon,
        bool obscure = false, 
        TextInputType? type,
        Widget? suffixIcon,
     required TextEditingController controller,
      String? Function(String?)? validator, }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscure,
          keyboardType: type,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            hintText: 'Enter $label'.toString(),
            prefixIcon: icon != null ? Icon(icon, size: 20) : null,
            suffixIcon: suffixIcon
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Account')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formkey,
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeSlideIn(
                child: _field(
                    'Full Name',
                    icon: Icons.badge_outlined,
                controller: _nameController,
                validator: (value){
                      if (value == null || value.trim().isEmpty){
                        return "Please enter your fullname";
                      }
                      if(value.trim().length <2){
                        return "Name is too short";
                      }
                      return null;
                },
                )
            ),
            FadeSlideIn(
                delayMs: 40,
                child: _field(
                    'Email',
                    icon: Icons.email_outlined,
                    type: TextInputType.emailAddress,
                controller: _emailController,
                validator: (value){
                      if (value == null || value.isEmpty){
                        return "Please enter your email";
                      }
                      final emailRegex = RegExp( r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      );
                      if(!emailRegex.hasMatch(value.trim())){
                        return "Please enter a valid email";
                      }
                      return null;

                })),
            FadeSlideIn(
                delayMs: 120,
                child: _field(
                    'Contact Number',
                    icon: Icons.phone_outlined,
                    type: TextInputType.phone,
                controller: _contactController,
                validator: (value){
                      if(value == null || value.isEmpty){
                        return "Please enter your contact number";
                      }
                      if (value.trim().length<11 || value.trim().length >12){
                        return "Please enter a valid contact number";
                      }
                      return null;

                },
                ),
            ),
            FadeSlideIn(
                delayMs: 200,
                child: _field(
                    'Address',
                    icon: Icons.location_on_outlined,
                controller: _locationController,
                validator: (value){
                      if(value == null || value.isEmpty){
                        return "Please enter your address";
                      }
                      return null;
                },
                )
            ),

            FadeSlideIn(
              delayMs: 160,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Blood Type', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: _bloodType,
                    dropdownColor: AppColors.surfaceElevated,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.water_drop_outlined, size: 20),
                    ),
                    hint: const Text('Select blood type'),
                    items: _bloodTypes
                        .map((b) => DropdownMenuItem(value: b, child: Text(b)))
                        .toList(),
                    onChanged: (v) => setState(() => _bloodType = v),
                    validator: (value){
                      if(value == null || value.isEmpty){
                        return "Please select your bloodtype";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
            FadeSlideIn(
                delayMs: 80,
                child: _field(
                    'Password',
                    icon: Icons.lock_outline,
                    obscure: _Password,
                suffixIcon: IconButton(
                    onPressed: (){
                      setState(() {
                        _Password=!_Password;
                      });
                    },
                    icon:Icon(_Password
                ? Icons.visibility_off
                :Icons.visibility)),
                controller: _passwordController,
                validator: (value){
                      if(value == null || value.isEmpty){
                        return "Please enter your password";
                      }if(value.length <8){
                        return "Password must be at least 8 character";
                      }
                      return null;
                })),
            FadeSlideIn(
                delayMs: 80,
                child: _field(
                    'Confirm Password',
                    icon: Icons.lock_outline,
                    obscure: _Confirmpassword,
                controller: _confirmPasswordController,
                suffixIcon: IconButton(
                    onPressed: (){
                      setState(() {
                        _Confirmpassword =!_Confirmpassword;
                      });
                    },
                    icon: Icon(_Confirmpassword
                    ?Icons.visibility_off
                    :Icons.visibility)),
                validator: (value){
                      if(value == null|| value.isEmpty){
                        return "Please confirm your password";

                      }if(value != _passwordController.text){
                        return "Password do not match";
                      }
                      return null;
                })
            ),
            const SizedBox(height: 8),
            FadeSlideIn(
              delayMs: 240,
              child: GradientButton(
                label: 'CREATE ACCOUNT',
                onTap: () {
                  if(_formkey.currentState!.validate()) {
                   Navigator.push(context,
                       MaterialPageRoute(builder: (context) => HomeScreen()));
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
                Text("Already have an account?",
              style:TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w400,
                fontSize: 12
              ) ,
            ),
                TextButton(
                    onPressed: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder:
                          (context)=> LoginScreen(),)
                      );
                    },
                    child: Text("Login",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),

                    ),)
      ]
              )
            )
          ],

        ),
      ),
      ),
    );
  }
}
