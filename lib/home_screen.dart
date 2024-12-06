import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart'; // Firebase core initialization
import 'widgets/button.dart';
import 'HomePage.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController altPhoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  String? bloodGroup;
  String? state;

  // Initialize Firebase before using Firestore
  Future<void> _initializeFirebase() async {
    await Firebase.initializeApp();
  }

  // Save user details to Firestore
  Future<void> saveUserDetails() async {
    if (usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        bloodGroup == null ||
        state == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all fields.')),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('users').add({
        'username': usernameController.text,
        'email': emailController.text,
        'phone_number': phoneController.text,
        'alt_phone_number': altPhoneController.text,
        'address': addressController.text,
        'blood_group': bloodGroup,
        'state': state,
        'created_at': FieldValue.serverTimestamp(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('User details saved successfully!')),
      );

      // Clear fields after saving
      usernameController.clear();
      emailController.clear();
      phoneController.clear();
      altPhoneController.clear();
      addressController.clear();
      setState(() {
        bloodGroup = null;
        state = null;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving details: $e')),
      );
    }
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.grey[900],
      labelText: label,
      labelStyle: const TextStyle(color: Colors.grey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: Colors.white),
      ),
    );
  }

  Widget _buildDropdownField(
    String hint,
    List<String> items,
    ValueChanged<String?> onChanged,
  ) {
    return DropdownButtonFormField<String>(
      dropdownColor: Colors.grey[900],
      hint: Text(hint, style: const TextStyle(color: Colors.grey)),
      style: const TextStyle(color: Colors.white),
      decoration: _inputDecoration(''),
      items: items
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      onChanged: onChanged,
    );
  }

  @override
  void initState() {
    super.initState();
    _initializeFirebase(); // Ensure Firebase is initialized when the screen is loaded
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Text(
                'User Details',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: usernameController,
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration('Username'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: emailController,
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration('Email'),
              ),
              const SizedBox(height: 16),
              _buildDropdownField(
                'Select Blood Group',
                ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'],
                (value) => setState(() => bloodGroup = value),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: phoneController,
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration('Phone Number'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: altPhoneController,
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration('Alternate Phone Number'),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: addressController,
                maxLines: 2,
                style: const TextStyle(color: Colors.white),
                decoration: _inputDecoration('Address'),
              ),
              const SizedBox(height: 16),
              _buildDropdownField(
                'Select State',
                [
                  'Andhra Pradesh',
  'Arunachal Pradesh',
  'Assam',
  'Bihar',
  'Chhattisgarh',
  'Goa',
  'Gujarat',
  'Haryana',
  'Himachal Pradesh',
  'Jharkhand',
  'Karnataka',
  'Kerala',
  'Madhya Pradesh',
  'Maharashtra',
  'Manipur',
  'Meghalaya',
  'Mizoram',
  'Nagaland',
  'Odisha',
  'Punjab',
  'Rajasthan',
  'Sikkim',
  'Tamil Nadu',
  'Telangana',
  'Tripura',
  'Uttar Pradesh',
  'Uttarakhand',
  'West Bengal',
  'Andaman ',
  'Chandigarh',
 
  'Lakshadweep',
  'Delhi',
  'Puducherry'
                ],
                (value) => setState(() => state = value),
              ),
              const SizedBox(height: 16),
              CustomButton(
                label: "Submit",
                onPressed: () async {
                  // Check if user details are filled
                  if (usernameController.text.isEmpty ||
                      emailController.text.isEmpty ||
                      phoneController.text.isEmpty ||
                      bloodGroup == null ||
                      state == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please fill in all fields.')),
                    );
                    return;
                  }

                  // Save user details to Firestore
                  await saveUserDetails();

                  // Navigate to the HomePage after saving details
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) =>  HomePage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
