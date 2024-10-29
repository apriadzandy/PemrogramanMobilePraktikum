import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laund/app/modules/home/controllers/auth_controller.dart';
import 'package:laund/app/modules/home/views/login_view.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final AuthController _authController = Get.put(AuthController());
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Logo from local asset (optional, can use the same logo as LoginPage)
              
              const SizedBox(height: 24),
              // Title Text
              Text(
                'Create an Account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Sign up to get started',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.blueGrey[600],
                ),
              ),
              const SizedBox(height: 40),
              // Email TextField
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.blueGrey[700]),
                  prefixIcon: Icon(Icons.email, color: Colors.blue[700]),
                  filled: true,
                  fillColor: Colors.blue[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Password TextField
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.blueGrey[700]),
                  prefixIcon: Icon(Icons.lock, color: Colors.blue[700]),
                  filled: true,
                  fillColor: Colors.blue[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              // Register Button
              Obx(() {
                return ElevatedButton(
                  onPressed: _authController.isLoading.value
                      ? null
                      : () {
                          _authController.registerUser(
                            _emailController.text,
                            _passwordController.text,
                          );
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[700],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _authController.isLoading.value
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text(
                          'Register',
                          style: TextStyle(fontSize: 18),
                        ),
                );
              }),
              const SizedBox(height: 16),
              // Login Option
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(color: Colors.blueGrey[700]),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.off(LoginPage());
                    },
                    child: Text(
                      'Log In',
                      style: TextStyle(
                        color: Colors.blue[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
