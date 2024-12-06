import 'dart:developer';
import 'package:flutter/material.dart';
import 'signup_screen.dart';
import '../widgets/button.dart';
import '../widgets/textfield.dart';
import 'auth_service.dart';
import 'package:nmercy/HomePage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = AuthService();
  final _email = TextEditingController();
  final _password = TextEditingController();
  String? _errorMessage;

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            const Spacer(),
            const Text(
              "Login",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w500,
                color: Colors.deepPurple,  // Bright and vibrant color
              ),
            ),
            const SizedBox(height: 50),
            CustomTextField(
              hint: "Enter Email",
              label: "Email",
              controller: _email,
            ),
            const SizedBox(height: 20),
            CustomTextField(
              hint: "Enter Password",
              label: "Password",
              controller: _password,
              isPassword: true,
            ),
            const SizedBox(height: 30),
            if (_errorMessage != null) ...[
              Text(
                _errorMessage!,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
            ],
            CustomButton(
              label: "Login",
              onPressed: _login,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account? "),
                InkWell(
                  onTap: () => goToSignup(context),
                  child: const Text(
                    "Signup",
                    style: TextStyle(
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }

  goToSignup(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SignupScreen()),
      );

  goToHome(BuildContext context) => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  HomePage()),
      );

  _login() async {
    setState(() {
      _errorMessage = null; // Reset error message on every login attempt
    });

    final user = await _auth.loginUserWithEmailAndPassword(_email.text, _password.text);

    if (user != null) {
      log("User Logged In");
      goToHome(context);
    } else {
      setState(() {
        _errorMessage = "Wrong email or password. Please try again.";
      });
    }
  }
}
