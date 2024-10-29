import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laund/app/modules/home/controllers/auth_controller.dart';
import 'package:laund/app/modules/home/views/register_view.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthController _authController = Get.find<AuthController>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _authController.checkLoginStatus();
  }

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
              // Logo or Icon
              Image.asset(
                'assets/Logo/logoAPP.PNG',
                height: 120,
              ),
              const SizedBox(height: 24),
              // Title Text
              Text(
                'Welcome in Laundry APP!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[800],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Please log in to continue',
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
              // Login Button
              Obx(() {
                return ElevatedButton(
                  onPressed: _authController.isLoading.value
                      ? null
                      : () {
                          _authController.loginUser(
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
                          'Log In',
                          style: TextStyle(fontSize: 18),
                        ),
                );
              }),
              const SizedBox(height: 16),
              // Sign Up Option
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(color: Colors.blueGrey[700]),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(RegisterPage());
                    },
                    child: Text(
                      'Sign Up',
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
